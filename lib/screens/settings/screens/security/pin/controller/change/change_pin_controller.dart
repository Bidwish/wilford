import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

class ChangePinController extends GetxController {
  static ChangePinController get instance => Get.find();

  final cPin = TextEditingController();
  final nPin = TextEditingController();
  final rPin = TextEditingController();
  final gCode = TextEditingController();

  final GlobalKey<FormState> changePinFormKey = GlobalKey<FormState>();

  /// Validators for form fields
  String? validateCurrentPin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Current Pin is required';
    }
    if (value.trim().length < 4) {
      return 'Pin must be at least 4 characters';
    }
    return null;
  }

  String? validateNewPin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'New Pin is required';
    }
    if (value.trim().length < 4) {
      return 'Pin must be at least 4 characters';
    }
    return null;
  }

  String? validateRepeatPin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please repeat the new Pin';
    }
    if (value.trim() != nPin.text.trim()) {
      return 'Pin do not match';
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

  Future<void> changePin() async {
    try {
      TFullScreenLoader.show();

      final box = GetStorage();
      final token = box.read('token');
      final user = box.read('user');
      final email = user['email'];

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

      if (!changePinFormKey.currentState!.validate()) return;

      final requestBody = {
        'cPin': cPin.text.trim(),
        'nPin': nPin.text.trim(),
        'rPin': rPin.text.trim(),
        'gCode': gCode.text.trim(),
        'email': email,
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/auth/pin/change-pin/"),
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
          message: 'Pin changed successfully.',
        );
        Get.offNamed(AppRoutes.pinScreen);
      } else {
        TFullScreenLoader.hide();
        final errorMessage =
            responseData?['message'] ?? 'Something went wrong.';
        TLoaders.errorSnackbar(
          title: 'Change Pin Failed',
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
      TFullScreenLoader.hide();
    }
  }
}
