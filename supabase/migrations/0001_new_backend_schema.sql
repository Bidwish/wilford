create extension if not exists pgcrypto;

create type public.app_role as enum ('customer', 'support', 'admin');
create type public.wallet_entry_type as enum ('deposit', 'purchase', 'refund', 'transfer_in', 'transfer_out', 'adjustment');
create type public.wallet_entry_status as enum ('pending', 'posted', 'reversed', 'failed');
create type public.order_status as enum ('pending', 'processing', 'successful', 'failed', 'refunded', 'cancelled');
create type public.support_status as enum ('open', 'ongoing', 'resolved', 'closed');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  first_name text not null,
  middle_name text,
  last_name text not null,
  email text,
  phone text not null unique,
  username text unique,
  date_of_birth date,
  gender text,
  avatar_path text,
  account_tier text not null default 'basic',
  role public.app_role not null default 'customer',
  referral_code text unique,
  referred_by uuid references public.profiles(id) on delete set null,
  is_verified boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (phone ~ '^\\+234[0-9]{10}$')
);

create table public.wallets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references public.profiles(id) on delete cascade,
  currency char(3) not null default 'NGN',
  balance numeric(19, 2) not null default 0,
  status text not null default 'active' check (status in ('active', 'frozen', 'closed')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (balance >= 0)
);

create table public.wallet_ledger (
  id uuid primary key default gen_random_uuid(),
  wallet_id uuid not null references public.wallets(id),
  user_id uuid not null references public.profiles(id),
  entry_type public.wallet_entry_type not null,
  status public.wallet_entry_status not null default 'posted',
  amount numeric(19, 2) not null check (amount > 0),
  balance_before numeric(19, 2),
  balance_after numeric(19, 2),
  order_id uuid,
  idempotency_key text not null unique,
  description text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table public.catalog_products (
  id uuid primary key default gen_random_uuid(),
  category text not null check (category in ('airtime', 'data', 'tv', 'utility', 'gift_card', 'transfer')),
  provider text not null,
  external_code text not null,
  name text not null,
  network text,
  amount numeric(19, 2),
  fee numeric(19, 2) not null default 0,
  validity text,
  metadata jsonb not null default '{}'::jsonb,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (provider, external_code)
);

create table public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id),
  product_id uuid references public.catalog_products(id),
  category text not null,
  status public.order_status not null default 'pending',
  amount numeric(19, 2) not null check (amount > 0),
  fee numeric(19, 2) not null default 0 check (fee >= 0),
  total_amount numeric(19, 2) generated always as (amount + fee) stored,
  reference text not null unique default encode(gen_random_bytes(12), 'hex'),
  request_payload jsonb not null default '{}'::jsonb,
  response_payload jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.wallet_ledger
  add constraint wallet_ledger_order_fk foreign key (order_id) references public.orders(id);

create table public.provider_attempts (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  provider text not null,
  external_reference text,
  status public.order_status not null default 'pending',
  request_payload jsonb not null default '{}'::jsonb,
  response_payload jsonb not null default '{}'::jsonb,
  error_message text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.bank_accounts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  provider text not null,
  account_number text not null,
  account_name text not null,
  bank_code text,
  bank_name text,
  is_default boolean not null default false,
  created_at timestamptz not null default now(),
  unique (user_id, account_number, bank_code)
);

create table public.saved_beneficiaries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  beneficiary_type text not null check (beneficiary_type in ('bank', 'wilford')),
  name text not null,
  account_number text,
  bank_code text,
  bank_name text,
  phone text,
  created_at timestamptz not null default now()
);

create table public.device_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  token text not null unique,
  platform text not null check (platform in ('android', 'ios', 'web')),
  is_active boolean not null default true,
  last_seen_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table public.referrals (
  id uuid primary key default gen_random_uuid(),
  referrer_id uuid not null references public.profiles(id),
  referred_id uuid not null unique references public.profiles(id),
  reward_order_id uuid references public.orders(id),
  reward_amount numeric(19, 2) not null default 0,
  status text not null default 'pending' check (status in ('pending', 'qualified', 'paid', 'cancelled')),
  created_at timestamptz not null default now()
);

create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  body text not null,
  data jsonb not null default '{}'::jsonb,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.support_tickets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  issue_type text not null,
  description text not null,
  status public.support_status not null default 'open',
  assigned_to uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.support_messages (
  id uuid primary key default gen_random_uuid(),
  ticket_id uuid not null references public.support_tickets(id) on delete cascade,
  sender_id uuid not null references public.profiles(id),
  message text not null,
  created_at timestamptz not null default now()
);

create table public.audit_logs (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references public.profiles(id) on delete set null,
  action text not null,
  entity_type text not null,
  entity_id uuid,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table public.webhook_events (
  id uuid primary key default gen_random_uuid(),
  provider text not null,
  event_key text not null,
  event_type text not null,
  payload jsonb not null,
  processing_status text not null default 'received' check (processing_status in ('received', 'processed', 'ignored', 'failed')),
  error_message text,
  processed_at timestamptz,
  created_at timestamptz not null default now(),
  unique (provider, event_key)
);

create table public.phone_otps (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  phone text not null,
  code_hash text not null,
  attempts integer not null default 0,
  expires_at timestamptz not null default (now() + interval '10 minutes'),
  consumed_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.user_pins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  pin_hash text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index phone_otps_lookup_idx on public.phone_otps (user_id, phone, created_at desc);
alter table public.user_pins enable row level security;
create policy user_pins_no_client_access on public.user_pins for all to authenticated using (false) with check (false);

create index wallet_ledger_wallet_created_idx on public.wallet_ledger (wallet_id, created_at desc);
create index orders_user_created_idx on public.orders (user_id, created_at desc);
create index provider_attempts_order_idx on public.provider_attempts (order_id, created_at desc);
create index notifications_user_created_idx on public.notifications (user_id, created_at desc);
create index support_messages_ticket_created_idx on public.support_messages (ticket_id, created_at);
create index webhook_events_created_idx on public.webhook_events (created_at desc);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger profiles_set_updated_at before update on public.profiles for each row execute function public.set_updated_at();
create trigger wallets_set_updated_at before update on public.wallets for each row execute function public.set_updated_at();
create trigger catalog_products_set_updated_at before update on public.catalog_products for each row execute function public.set_updated_at();
create trigger orders_set_updated_at before update on public.orders for each row execute function public.set_updated_at();
create trigger provider_attempts_set_updated_at before update on public.provider_attempts for each row execute function public.set_updated_at();
create trigger support_tickets_set_updated_at before update on public.support_tickets for each row execute function public.set_updated_at();

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, first_name, last_name, email, phone)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'first_name', ''),
    coalesce(new.raw_user_meta_data ->> 'last_name', ''),
    new.email,
    coalesce(new.phone, '')
  );
  insert into public.wallets (user_id) values (new.id);
  return new;
end;
$$;

create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();

create or replace function public.is_admin_or_support()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role in ('admin', 'support')
  );
$$;

create or replace function public.post_wallet_entry(
  p_wallet_id uuid,
  p_entry_type public.wallet_entry_type,
  p_amount numeric,
  p_idempotency_key text,
  p_description text default null,
  p_order_id uuid default null,
  p_metadata jsonb default '{}'::jsonb
)
returns public.wallet_ledger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_wallet public.wallets;
  v_entry public.wallet_ledger;
  v_before numeric(19, 2);
  v_after numeric(19, 2);
  v_signed_amount numeric(19, 2);
begin
  if p_amount <= 0 then
    raise exception 'Amount must be greater than zero';
  end if;

  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then
    raise exception 'Not authorized';
  end if;

  select * into v_entry from public.wallet_ledger where idempotency_key = p_idempotency_key;
  if found then
    return v_entry;
  end if;

  select * into v_wallet from public.wallets where id = p_wallet_id for update;
  if v_wallet.status <> 'active' then
    raise exception 'Wallet is not active';
  end if;

  v_signed_amount := case when p_entry_type in ('deposit', 'refund', 'transfer_in', 'adjustment') then p_amount else -p_amount end;
  v_before := v_wallet.balance;
  v_after := v_before + v_signed_amount;
  if v_after < 0 then
    raise exception 'Insufficient wallet balance';
  end if;

  update public.wallets set balance = v_after where id = p_wallet_id;
  insert into public.wallet_ledger (wallet_id, user_id, entry_type, amount, balance_before, balance_after, order_id, idempotency_key, description, metadata)
  values (p_wallet_id, v_wallet.user_id, p_entry_type, p_amount, v_before, v_after, p_order_id, p_idempotency_key, p_description, p_metadata)
  returning * into v_entry;
  return v_entry;
end;
$$;

revoke all on function public.post_wallet_entry(uuid, public.wallet_entry_type, numeric, text, text, uuid, jsonb) from public;
grant execute on function public.post_wallet_entry(uuid, public.wallet_entry_type, numeric, text, text, uuid, jsonb) to service_role;

create or replace function public.create_purchase_order(
  p_user_id uuid,
  p_category text,
  p_amount numeric,
  p_fee numeric,
  p_idempotency_key text,
  p_request_payload jsonb default '{}'::jsonb,
  p_product_id uuid default null
)
returns public.orders
language plpgsql
security definer
set search_path = public
as $$
declare
  v_order public.orders;
  v_wallet public.wallets;
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then
    raise exception 'Not authorized';
  end if;
  if p_amount <= 0 or p_fee < 0 then
    raise exception 'Invalid order amount';
  end if;

  select * into v_order from public.orders where reference = p_idempotency_key;
  if found then
    return v_order;
  end if;

  select * into v_wallet from public.wallets where user_id = p_user_id for update;
  if not found or v_wallet.status <> 'active' then
    raise exception 'Wallet is not active';
  end if;
  if v_wallet.balance < p_amount + p_fee then
    raise exception 'Insufficient wallet balance';
  end if;

  insert into public.orders (user_id, product_id, category, amount, fee, reference, request_payload)
  values (p_user_id, p_product_id, p_category, p_amount, p_fee, p_idempotency_key, p_request_payload)
  returning * into v_order;

  perform public.post_wallet_entry(
    v_wallet.id, 'purchase', p_amount + p_fee, 'purchase:' || v_order.id::text,
    'Purchase authorization', v_order.id, jsonb_build_object('category', p_category)
  );
  return v_order;
end;
$$;

create or replace function public.refund_failed_order(
  p_order_id uuid,
  p_idempotency_key text,
  p_reason text default 'Provider request failed'
)
returns public.orders
language plpgsql
security definer
set search_path = public
as $$
declare
  v_order public.orders;
  v_wallet public.wallets;
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then
    raise exception 'Not authorized';
  end if;

  select * into v_order from public.orders where id = p_order_id for update;
  if not found then
    raise exception 'Order not found';
  end if;
  if v_order.status = 'refunded' then
    return v_order;
  end if;
  if v_order.status <> 'failed' then
    raise exception 'Only failed orders can be refunded';
  end if;

  select * into v_wallet from public.wallets where user_id = v_order.user_id for update;
  perform public.post_wallet_entry(
    v_wallet.id, 'refund', v_order.total_amount, p_idempotency_key,
    p_reason, v_order.id, jsonb_build_object('reason', p_reason)
  );
  update public.orders set status = 'refunded' where id = v_order.id returning * into v_order;
  return v_order;
end;
$$;

revoke all on function public.create_purchase_order(uuid, text, numeric, numeric, text, jsonb, uuid) from public;
revoke all on function public.refund_failed_order(uuid, text, text) from public;
grant execute on function public.create_purchase_order(uuid, text, numeric, numeric, text, jsonb, uuid) to service_role;
grant execute on function public.refund_failed_order(uuid, text, text) to service_role;

create or replace function public.record_deposit(
  p_provider text,
  p_event_key text,
  p_account_number text,
  p_amount numeric,
  p_external_reference text,
  p_payload jsonb
)
returns public.webhook_events
language plpgsql
security definer
set search_path = public
as $$
declare
  v_event public.webhook_events;
  v_wallet public.wallets;
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then
    raise exception 'Not authorized';
  end if;
  insert into public.webhook_events (provider, event_key, event_type, payload)
  values (p_provider, p_event_key, 'payment_success', p_payload)
  on conflict (provider, event_key) do update set payload = excluded.payload
  returning * into v_event;

  if v_event.processing_status = 'processed' then
    return v_event;
  end if;
  select w.* into v_wallet
  from public.bank_accounts b
  join public.wallets w on w.user_id = b.user_id
  where b.account_number = p_account_number and w.status = 'active'
  limit 1;
  if not found then
    update public.webhook_events set processing_status = 'ignored', error_message = 'No linked wallet' where id = v_event.id returning * into v_event;
    return v_event;
  end if;
  perform public.post_wallet_entry(v_wallet.id, 'deposit', p_amount, 'deposit:' || p_provider || ':' || p_event_key, 'Incoming bank deposit', null, jsonb_build_object('external_reference', p_external_reference));
  update public.webhook_events set processing_status = 'processed', processed_at = now() where id = v_event.id returning * into v_event;
  return v_event;
end;
$$;

create or replace function public.complete_provider_order(p_order_reference text, p_provider text, p_external_reference text, p_payload jsonb)
returns public.orders
language plpgsql security definer set search_path = public
as $$
declare v_order public.orders;
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then raise exception 'Not authorized'; end if;
  update public.orders set status = 'successful', response_payload = p_payload where reference = p_order_reference returning * into v_order;
  if not found then raise exception 'Order not found'; end if;
  insert into public.provider_attempts (order_id, provider, external_reference, status, response_payload)
  values (v_order.id, p_provider, p_external_reference, 'successful', p_payload);
  return v_order;
end;
$$;

create or replace function public.fail_provider_order(p_order_reference text, p_provider text, p_external_reference text, p_payload jsonb)
returns public.orders
language plpgsql security definer set search_path = public
as $$
declare v_order public.orders;
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then raise exception 'Not authorized'; end if;
  update public.orders set status = 'failed', response_payload = p_payload where reference = p_order_reference returning * into v_order;
  if not found then raise exception 'Order not found'; end if;
  insert into public.provider_attempts (order_id, provider, external_reference, status, response_payload)
  values (v_order.id, p_provider, p_external_reference, 'failed', p_payload);
  return public.refund_failed_order(v_order.id, 'refund:' || p_provider || ':' || p_order_reference, 'Provider webhook reported failure');
end;
$$;

create or replace function public.mark_provider_order_processing(
  p_order_reference text,
  p_provider text,
  p_external_reference text,
  p_payload jsonb
)
returns public.orders
language plpgsql
security definer
set search_path = public
as $$
declare
  v_order public.orders;
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then
    raise exception 'Not authorized';
  end if;
  update public.orders
  set status = case when status = 'pending' then 'processing' else status end,
      response_payload = p_payload
  where reference = p_order_reference
  returning * into v_order;
  if not found then raise exception 'Order not found'; end if;
  insert into public.provider_attempts (order_id, provider, external_reference, status, response_payload)
  values (v_order.id, p_provider, p_external_reference, 'processing', p_payload);
  return v_order;
end;
$$;

create or replace function public.process_vtpass_webhook(
  p_event_key text,
  p_event_type text,
  p_order_reference text,
  p_external_reference text,
  p_payload jsonb,
  p_success boolean
)
returns public.webhook_events
language plpgsql
security definer
set search_path = public
as $$
declare
  v_event public.webhook_events;
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then
    raise exception 'Not authorized';
  end if;
  insert into public.webhook_events (provider, event_key, event_type, payload)
  values ('vtpass', p_event_key, p_event_type, p_payload)
  on conflict (provider, event_key) do nothing;
  select * into v_event from public.webhook_events where provider = 'vtpass' and event_key = p_event_key for update;
  if v_event.processing_status = 'processed' then return v_event; end if;

  if p_success then
    perform public.complete_provider_order(p_order_reference, 'vtpass', p_external_reference, p_payload);
  else
    update public.orders set status = 'failed', response_payload = p_payload where reference = p_order_reference and status in ('pending', 'processing');
    if found then
      perform public.refund_failed_order((select id from public.orders where reference = p_order_reference), 'refund:vtpass:' || p_order_reference, 'VTpass webhook reported failure');
    end if;
  end if;
  update public.webhook_events set processing_status = 'processed', processed_at = now() where id = v_event.id returning * into v_event;
  return v_event;
end;
$$;

revoke all on function public.record_deposit(text, text, text, numeric, text, jsonb) from public;
revoke all on function public.complete_provider_order(text, text, text, jsonb) from public;
revoke all on function public.fail_provider_order(text, text, text, jsonb) from public;
grant execute on function public.record_deposit(text, text, text, numeric, text, jsonb) to service_role;
grant execute on function public.complete_provider_order(text, text, text, jsonb) to service_role;
grant execute on function public.fail_provider_order(text, text, text, jsonb) to service_role;
revoke all on function public.mark_provider_order_processing(text, text, text, jsonb) from public;
grant execute on function public.mark_provider_order_processing(text, text, text, jsonb) to service_role;
revoke all on function public.process_vtpass_webhook(text, text, text, text, jsonb, boolean) from public;
grant execute on function public.process_vtpass_webhook(text, text, text, text, jsonb, boolean) to service_role;

alter table public.profiles enable row level security;
alter table public.wallets enable row level security;
alter table public.wallet_ledger enable row level security;
alter table public.catalog_products enable row level security;
alter table public.orders enable row level security;
alter table public.provider_attempts enable row level security;
alter table public.bank_accounts enable row level security;
alter table public.saved_beneficiaries enable row level security;
alter table public.device_tokens enable row level security;
alter table public.referrals enable row level security;
alter table public.notifications enable row level security;
alter table public.support_tickets enable row level security;
alter table public.support_messages enable row level security;
alter table public.audit_logs enable row level security;
alter table public.webhook_events enable row level security;
alter table public.phone_otps enable row level security;

create policy profiles_select_own_or_staff on public.profiles for select to authenticated using (id = auth.uid() or public.is_admin_or_support());
create policy profiles_update_own on public.profiles for update to authenticated using (id = auth.uid()) with check (id = auth.uid());
create policy wallets_select_own_or_staff on public.wallets for select to authenticated using (user_id = auth.uid() or public.is_admin_or_support());
create policy ledger_select_own_or_staff on public.wallet_ledger for select to authenticated using (user_id = auth.uid() or public.is_admin_or_support());
create policy products_select_active on public.catalog_products for select to authenticated using (is_active or public.is_admin_or_support());
create policy orders_select_own_or_staff on public.orders for select to authenticated using (user_id = auth.uid() or public.is_admin_or_support());
create policy bank_accounts_own on public.bank_accounts for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy beneficiaries_own on public.saved_beneficiaries for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy device_tokens_own on public.device_tokens for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy referrals_visible_to_participants on public.referrals for select to authenticated using (referrer_id = auth.uid() or referred_id = auth.uid() or public.is_admin_or_support());
create policy notifications_own on public.notifications for select to authenticated using (user_id = auth.uid());
create policy notifications_update_own on public.notifications for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy tickets_own_or_staff on public.support_tickets for all to authenticated using (user_id = auth.uid() or public.is_admin_or_support()) with check (user_id = auth.uid() or public.is_admin_or_support());
create policy messages_ticket_participant on public.support_messages for select to authenticated using (exists (select 1 from public.support_tickets t where t.id = ticket_id and (t.user_id = auth.uid() or public.is_admin_or_support())));
create policy messages_insert_participant on public.support_messages for insert to authenticated with check (sender_id = auth.uid() and exists (select 1 from public.support_tickets t where t.id = ticket_id and (t.user_id = auth.uid() or public.is_admin_or_support())));
create policy audit_staff_only on public.audit_logs for select to authenticated using (public.is_admin_or_support());
create policy webhook_events_staff_only on public.webhook_events for select to authenticated using (public.is_admin_or_support());
create policy phone_otps_no_client_access on public.phone_otps for all to authenticated using (false) with check (false);