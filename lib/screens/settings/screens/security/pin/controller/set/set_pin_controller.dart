import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'package:wilford/screens/settings/screens/security/pin/controller/set/check_pin.dart';

class SetPinController extends GetxController {
  static SetPinController get instance => Get.find();

  final nPin = TextEditingController();
  final rPin = TextEditingController();

  var hasPin = false.obs;

  final GlobalKey<FormState> setPinFormKey = GlobalKey<FormState>();

  String? validatePin(String? value) {
    if (value == null || value.trim().isEmpty) return 'Pin is required';
    if (value.trim().length < 4) return 'Pin must be at least 4 digits';
    return null;
  }

  String? validateReenterPin(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please repeat the pin';
    if (value.trim() != nPin.text.trim()) return 'Pins do not match';
    return null;
  }

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

  Future<void> setPin() async {
    try {
      TFullScreenLoader.show();

      final box = GetStorage();
      final token = box.read('token');
      if (token == null) {
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

      if (!setPinFormKey.currentState!.validate()) {
        TFullScreenLoader.hide();
        return;
      }

      final requestBody = {
        'nPin': nPin.text.trim(),
        'rPin': rPin.text.trim(),
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/auth/pin/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final responseData = extractJson(response.body);
      debugPrint('SetPin response: ${response.body}');

      // Always hide loader before navigation/snackbars
      TFullScreenLoader.hide();

      if (response.statusCode == 200 && responseData != null) {
        hasPin.value = true;
        box.write('has_pin', true);

        if (Get.isRegistered<CheckPinController>()) {
          Get.find<CheckPinController>().hasPin.value = true;
        }

        TLoaders.successSnackbar(
          title: 'Success',
          message: 'Transaction PIN set successfully.',
        );

        Get.offNamed(AppRoutes.pinScreen);
      } else if (response.statusCode == 400 && responseData != null) {
        final errorMessage =
            responseData['message'] ?? 'Invalid data provided.';
        TLoaders.errorSnackbar(
          title: 'Failed to Set PIN',
          message: errorMessage,
        );
        Get.offNamed(AppRoutes.pinScreen);
      } else {
        final errorMessage =
            responseData?['message'] ?? 'Something went wrong.';
        TLoaders.errorSnackbar(
          title: 'Failed to Set PIN',
          message: errorMessage,
        );
      }
    } catch (e) {
      TFullScreenLoader.hide();
      debugPrint('Exception during PIN setup: $e');
      TLoaders.errorSnackbar(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      // Ensure loader is hidden no matter what
      TFullScreenLoader.hide();
    }
  }
}
