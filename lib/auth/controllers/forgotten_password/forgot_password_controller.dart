import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordController extends GetxController {
  final email = TextEditingController();

  /// Form key
  final GlobalKey<FormState> forgottonFormKey = GlobalKey<FormState>();

  /// Helper to extract and decode vaild JSON from server response
  Map<String, dynamic>? extractJson(String body) {
    final jsonStart = body.indexOf('{');
    if (jsonStart == -1) return null;

    final jsonString = body.substring(jsonStart);
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      debugPrint('Error parssing cleaned JSON: $e');
      return null;
    }
  }

  /// Sign up method
  Future<void> forgetPassWord() async {
    try {
      // Check internet conctivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      // Vaildate Input
      if (!forgottonFormKey.currentState!.validate()) return;

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/auth/forgotten_password/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.text}),
      );

      final result = extractJson(response.body);

      if (response.statusCode == 200 && result != null) {
        TLoaders.successSnackbar(
            title: 'Success',
            message:
                'An Email has been sent to your email address. Please check your inbox.');
        Get.offNamed(AppRoutes.resetPassword, arguments: {'email': email.text});
      } else {
        final errorMessage = result?['message'] ?? 'Verification failed';
        TLoaders.errorSnackbar(title: 'Error', message: errorMessage);
      }
    } catch (e) {
      // debugPrint('Exception occurred during signup: $e');
      TLoaders.errorSnackbar(
        title: 'Oh Snap!',
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }
}
