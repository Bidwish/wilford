import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

class ResetPinController extends GetxController {
  static ResetPinController get instance => Get.find();

  final password = TextEditingController();
  final gCode = TextEditingController();

  final GlobalKey<FormState> resetPinFormKey = GlobalKey<FormState>();

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

  Future<void> resetPin() async {
    try {
      TFullScreenLoader.show();

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

      if (!resetPinFormKey.currentState!.validate()) return;

      final requestBody = {
        'password': password.text.trim(),
        'gCode': gCode.text.trim(),
        'email': email,
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/auth/pin/reset-pin/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final responseData = extractJson(response.body);

      if (response.statusCode == 200 && responseData != null) {
        TFullScreenLoader.hide();
        TLoaders.successSnackbar(
          title: 'Success',
          message: 'Pin Reset successfully.',
        );

        /// Update hasPin state to false after reset
        final box = GetStorage();
        box.write('has_pin', false);

        /// Navigate to Set Pin screen
        Get.offNamed(AppRoutes.setpin);
      } else {
        TFullScreenLoader.hide();
        final errorMessage =
            responseData?['message'] ?? 'Something went wrong.';
        TLoaders.errorSnackbar(
          title: 'Reset Pin Failed',
          message: errorMessage,
        );
      }
    } catch (e) {
      debugPrint('Exception during pin reset: $e');
      TLoaders.errorSnackbar(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      TFullScreenLoader.hide();
    }
  }
}
