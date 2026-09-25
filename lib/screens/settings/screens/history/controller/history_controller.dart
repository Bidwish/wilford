import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';

import '../model/history_model.dart';

class HistoryController extends GetxController {
  var history = <HistoryModel>[].obs;
  var isLoading = false.obs;

  /// --- Fetch History ---
  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }
      final rows = await Supabase.instance.client.from('orders').select().eq('user_id', userId).order('created_at', ascending: false);
      history.value = rows.map((row) => HistoryModel.fromJson(row)).toList();
    } catch (e) {
      // debugPrint('Error fetching messages: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
