import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';

Future<void> registerDeviceToken() async {
  final fcm = FirebaseMessaging.instance;

  // Request notification permission (important on iOS)
  await fcm.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) {
    Get.offAllNamed(AppRoutes.login);
    return;
  }

  final fcmToken = await fcm.getToken();

  if (fcmToken != null) {
    await Supabase.instance.client.from('device_tokens').upsert({
      'user_id': userId,
      'token': fcmToken,
      'platform': GetPlatform.isIOS ? 'ios' : 'android',
      'is_active': true,
      'last_seen_at': DateTime.now().toUtc().toIso8601String(),
    }, onConflict: 'token');
  }

  // Optional: handle token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    await Supabase.instance.client.from('device_tokens').upsert({
      'user_id': userId,
      'token': newToken,
      'platform': GetPlatform.isIOS ? 'ios' : 'android',
      'is_active': true,
      'last_seen_at': DateTime.now().toUtc().toIso8601String(),
    }, onConflict: 'token');
  });
}
