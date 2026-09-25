import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';

import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notifications = <NotificationModel>[].obs;

  RxBool hasUnread = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final decoded = await Supabase.instance.client.from('notifications').select().eq('user_id', userId).order('created_at', ascending: false);
      notifications.value = decoded.map((e) => NotificationModel.fromJson(e)).toList();

      hasUnread.value = notifications.any((notification) => notification.status == '2');
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNotificationStatus() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      await Supabase.instance.client.from('notifications').update({'read_at': DateTime.now().toUtc().toIso8601String()}).eq('user_id', userId).filter('read_at', 'is', null);
      await fetchNotifications();
      notifications.refresh();
      hasUnread.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      await Supabase.instance.client.from('notifications').update({'read_at': DateTime.now().toUtc().toIso8601String()}).eq('user_id', userId).filter('read_at', 'is', null);
      await fetchNotifications();
      notifications.refresh();
      hasUnread.value = false;
    } catch (e) {
      // debugPrint(e.toString());
    }
  }
}
