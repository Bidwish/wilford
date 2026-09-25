import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

Future<void> submitTv({
  required String pin,
  required String amount,
  required String provider,
  required String costomerName,
  required String code,
  required String planName,
  required String uic,
}) async {
  // Show loading indicator
  TFullScreenLoader.show();

  // Check if the user is logged in
  final box = GetStorage();
  final token = box.read('token');

  // Get the user data from the storage
  final userController = Get.put(UserController());
  final user = userController.user.value;

  final userId = user?.id ?? '';
  final phone = user?.phone ?? '';

  if (token == null) {
    Get.offAllNamed(AppRoutes.login);
    TFullScreenLoader.hide();
    return;
  }

  // Check internet connectivity
  final isConnected = await NetworkManager.instance.isConnected();
  if (!isConnected) {
    TFullScreenLoader.hide();
    TLoaders.errorSnackbar(
      title: "No Internet",
      message: "Please check your internet connection and try again.",
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('https://api.wilford.ng/v1/tv/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'amount': amount,
        'user_id': userId,
        'phone': phone,
        'provider': provider,
        'customer_name': costomerName,
        'uic': uic,
        'code': code,
        'plan_name': planName,
        'pin': pin,
      }),
    );

    final jsonResponse = _extractJson(response.body);
    final errorMessage = jsonResponse?['message'] ?? 'Invalid data provided';

    debugPrint('Response: ${response.body}');

    if (response.statusCode == 200 && jsonResponse != null) {
      TFullScreenLoader.hide();
      Get.offNamed(AppRoutes.paymentSuccess, arguments: {
        'title': 'Transaction Successful',
        'subtitle':
            'The recipient account is expected to be credited within 5 minutes.!',
        'image': TImages.successfulPaymentIcon,
        'onPressed': () {
          Get.offAllNamed(AppRoutes.home);
        },
      });
    } else if (response.statusCode == 400) {
      TFullScreenLoader.hide();
      TLoaders.warningSnackbar(
        title: 'Set Transaction Pin',
        message: errorMessage,
      );
      // Get.offAllNamed(AppRoutes.setpin);
      Get.toNamed(AppRoutes.setpin);
    } else {
      TFullScreenLoader.hide();
      TLoaders.errorSnackbar(title: 'Failed', message: errorMessage);
    }
  } catch (e) {
    debugPrint('Error: $e');
    TFullScreenLoader.hide();
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
