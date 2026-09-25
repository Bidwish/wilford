import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/auth/screens/reAuth/reAuthenticate.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReauthenticateController extends GetxController {
  final hidePassword = false.obs;

  final verifyPhone = TextEditingController();
  final verifyPassword = TextEditingController();

  final GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  /// Delete Account Waring
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () => Get.to(() => ReAuthLoginForm()),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    TFullScreenLoader.show();

    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.hide();
      TLoaders.warningSnackbar(
        title: "No Internet",
        message: "Please check your internet connection and try again.",
      );
      return;
    }

    if (!reAuthFormKey.currentState!.validate()) {
      TFullScreenLoader.hide();
      return;
    }

    try {
      final requestBody = {
        'phone': verifyPhone.text.trim(),
        'password': verifyPassword.text.trim(),
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/auth/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final jsonResponse = _extractJson(response.body);
      final errorMessage = jsonResponse?['message'] ?? 'Invalid data provided';

      debugPrint('Response: ${response.body}');

      if (response.statusCode == 200 && jsonResponse != null) {
        box.erase();
        Get.offAllNamed(AppRoutes.login);
        TLoaders.successSnackbar(
            title: 'Account Deleted', message: 'Your account has been deleted');
      } else if (response.statusCode == 401) {
        TFullScreenLoader.hide();
        TLoaders.warningSnackbar(title: 'Failed', message: errorMessage);
      } else {
        TFullScreenLoader.hide();
        TLoaders.errorSnackbar(title: 'Oh Snap!', message: errorMessage);
      }
    } catch (e) {
      TFullScreenLoader.hide();
      TLoaders.warningSnackbar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

/// Helper to safely extract JSON even if server sends extra text
Map<String, dynamic>? _extractJson(String body) {
  final jsonStart = body.indexOf('{');
  if (jsonStart == -1) return null;

  final jsonString = body.substring(jsonStart);
  try {
    return jsonDecode(jsonString);
  } catch (_) {
    return null;
  }
}
