import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/auth/controllers/logout/logout_controller.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get instance => Get.find();

  final cPassword = TextEditingController();
  final nPassword = TextEditingController();
  final rPassword = TextEditingController();
  final gCode = TextEditingController();

  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  /// Validators for form fields
  String? validateCurrentPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Current password is required';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'New password is required';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateRepeatPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please repeat the new password';
    }
    if (value.trim() != nPassword.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Extract clean JSON in case of junk before body
  Map<String, dynamic>? extractJson(String body) {
    final jsonStart = body.indexOf('{');
    if (jsonStart == -1) return null;
    final jsonString = body.substring(jsonStart);
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      debugPrint('Error parsing cleaned JSON: $e');
      return null;
    }
  }

  Future<void> changePassword() async {
    try {
      // TFullScreenLoader.show();

      final box = GetStorage();
      final token = box.read('token');
      final user = box.read('user');
      final email = user?['email'];

      if (token == null || email == null) {
        TFullScreenLoader.hide();
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.hide();
        TLoaders.errorSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      if (!changePasswordFormKey.currentState!.validate()) return;

      final requestBody = {
        'cPassword': cPassword.text.trim(),
        'nPassword': nPassword.text.trim(),
        'rPassword': rPassword.text.trim(),
        'gCode': gCode.text.trim(),
        'email': email,
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/auth/change-password/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final responseData = extractJson(response.body);

      if (response.statusCode == 200 && responseData != null) {
        TLoaders.successSnackbar(
          title: 'Success',
          message: 'Password changed successfully.',
        );
        logoutUser();
      } else {
        final errorMessage =
            responseData?['message'] ?? 'Something went wrong.';
        TLoaders.errorSnackbar(
          title: 'Change Failed',
          message: errorMessage,
        );
      }
    } catch (e) {
      debugPrint('Exception during password change: $e');
      TLoaders.errorSnackbar(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      // TFullScreenLoader.hide();
    }
  }
}
