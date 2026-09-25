import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/backend/phone_formatter.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

import '../fcm/regisiter_deivice.dart';

class LoginController extends GetxController {
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    phoneNumber.text = GetStorage().read('last_login_phone') ?? '';
  }

  Future<void> login() async {
    TFullScreenLoader.show();

    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.hide();
        TLoaders.warningSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.hide();
        return;
      }

      final phone = normalizeNigeriaPhone(phoneNumber.text);
      final response = await Supabase.instance.client.auth.signInWithPassword(
        phone: phone,
        password: password.text.trim(),
      );

      if (response.user != null && response.session != null) {

        final box = GetStorage();
        box.write('last_login_phone', phone);

        if (rememberMe.value) {
          box.write('remember_me', true);
        } else {
          box.remove('remember_me');
        }

        // Register Device Token
        await registerDeviceToken();

        Get.offAllNamed(AppRoutes.home);
      } else {
        TFullScreenLoader.hide();
        TLoaders.errorSnackbar(title: 'Login Failed', message: 'Unable to sign in');
      }
    } catch (e) {
      TFullScreenLoader.hide();
      TLoaders.errorSnackbar(
        title: 'Error',
        message: 'Something went wrong. Please try again.',
      );
    } finally {
      TFullScreenLoader.hide();
    }
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    password.dispose();
    super.onClose();
  }
}
