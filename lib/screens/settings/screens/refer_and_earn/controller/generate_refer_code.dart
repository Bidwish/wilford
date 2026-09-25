import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/utils/popups/loaders.dart';

class GenerateReferCode extends GetxController {
  var referCode = ''.obs;
  var isLoading = false.obs;

  Future<void> generateReferCode() async {
    try {
      isLoading.value = true;

      // Delay to avoid context conflict
      await Future.delayed(const Duration(milliseconds: 200));

      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;
      final code = 'WIL-${userId.substring(0, 8).toUpperCase()}';
      await Supabase.instance.client.from('profiles').update({'referral_code': code}).eq('id', userId);
      referCode.value = code;
    } catch (e) {
      debugPrint(e.toString());
      TLoaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
