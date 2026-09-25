import { compare, hash } from "https://esm.sh/bcryptjs@2.4.3";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

function createServiceClient() {
  const url = Deno.env.get("SUPABASE_URL");
  const key = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !key) throw new Error("Supabase server credentials are not configured");
  return createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
}

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function response(data: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

function normalizePhone(value: unknown) {
  const digits = String(value ?? "").replace(/\D/g, "");
  if (digits.startsWith("234") && digits.length === 13) return `+${digits}`;
  if (digits.startsWith("0") && digits.length === 11) return `+234${digits.substring(1)}`;
  return "";
}

function generateCode() {
  const bytes = new Uint32Array(1);
  crypto.getRandomValues(bytes);
  return String(100000 + (bytes[0] % 900000));
}

async function sendSms(phone: string, code: string) {
  const token = Deno.env.get("KUDISMS_TOKEN");
  const appNameCode = Deno.env.get("KUDISMS_APP_NAME_CODE");
  const templateCode = Deno.env.get("KUDISMS_TEMPLATE_CODE");
  if (!token || !appNameCode || !templateCode) throw new Error("KudiSMS secrets are not configured");

  const providerResponse = await fetch("https://my.kudisms.net/api/otp", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      token,
      senderID: Deno.env.get("KUDISMS_SENDER_ID") ?? "Wilford VTU",
      recipients: phone.substring(1),
      otp: code,
      appnamecode: appNameCode,
      templatecode: templateCode,
    }),
  });
  if (!providerResponse.ok) throw new Error(`KudiSMS HTTP ${providerResponse.status}`);

  const payload = await providerResponse.json() as Record<string, unknown>;
  if (payload.status !== "success") throw new Error("KudiSMS rejected the OTP request");
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (request.method !== "POST") return response({ error: "Method not allowed" }, 405);

  try {
    const authorization = request.headers.get("Authorization");
    if (!authorization?.startsWith("Bearer ")) return response({ error: "Authentication required" }, 401);

    const supabase = createServiceClient();
    const { data: authData, error: authError } = await supabase.auth.getUser(authorization.substring(7));
    if (authError || !authData.user) return response({ error: "Authentication required" }, 401);

    const body = await request.json() as Record<string, unknown>;
    const action = String(body.action ?? "send").trim().toLowerCase();
    const phone = normalizePhone(body.phone ?? authData.user.phone);
    if (!phone || !["send", "resend", "verify"].includes(action)) return response({ error: "Invalid OTP request" }, 400);

    if (action === "verify") {
      const code = String(body.code ?? body.otp ?? "").trim();
      if (!/^\d{6}$/.test(code)) return response({ error: "Invalid OTP code" }, 400);

      const { data: otp, error: otpError } = await supabase
        .from("phone_otps")
        .select("id, code_hash, expires_at")
        .eq("user_id", authData.user.id)
        .eq("phone", phone)
        .is("consumed_at", null)
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      if (otpError) throw otpError;
      if (!otp || new Date(otp.expires_at) <= new Date()) return response({ error: "OTP has expired" }, 400);
      if (!(await compare(code, otp.code_hash))) return response({ error: "OTP does not match" }, 401);

      const { error: consumeError } = await supabase
        .from("phone_otps")
        .update({ consumed_at: new Date().toISOString() })
        .eq("id", otp.id)
        .is("consumed_at", null);
      if (consumeError) throw consumeError;
      return response({ status: true, message: "OTP verified successfully" });
    }

    const code = generateCode();
    const { error: invalidateError } = await supabase
      .from("phone_otps")
      .update({ consumed_at: new Date().toISOString() })
      .eq("user_id", authData.user.id)
      .eq("phone", phone)
      .is("consumed_at", null);
    if (invalidateError) throw invalidateError;

    const { error: insertError } = await supabase.from("phone_otps").insert({
      user_id: authData.user.id,
      phone,
      code_hash: await hash(code),
    });
    if (insertError) throw insertError;

    try {
      await sendSms(phone, code);
    } catch (error) {
      await supabase.from("phone_otps").update({ consumed_at: new Date().toISOString() })
        .eq("user_id", authData.user.id).eq("phone", phone).is("consumed_at", null);
      throw error;
    }

    return response({ status: true, message: "OTP sent successfully" });
  } catch (error) {
    console.error("SMS OTP failed", error);
    return response({ error: "Unable to process OTP request" }, 500);
  }
});
