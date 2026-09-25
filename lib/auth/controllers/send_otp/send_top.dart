import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/utils/network/network_manager.dart';
import 'dart:convert';
import 'package:wilford/utils/popups/loaders.dart';

class EmailTopController extends GetxController {
  final secondsRemaining = 30.obs;
  final isResendAvailable = false.obs;

  Timer? _timer;
  String email = '';

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  /// Safely extract JSON from responses with possible pre-pended text
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

  void startTimer() {
    secondsRemaining.value = 30;
    isResendAvailable.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendAvailable.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> resendEmail() async {
    if (!isResendAvailable.value) return;

    // Check internet conctivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TLoaders.errorSnackbar(
        title: "No Internet",
        message: "Please check your internet connection and try again.",
      );
      return;
    }

    // Get Email
    final box = GetStorage();
    final user = box.read('user');
    final email = user['email'];

    try {
      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/auth/email-otp/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final result = extractJson(response.body);
      if (response.statusCode == 200 && result != null) {
        TLoaders.successSnackbar(
            title: 'Email Sent',
            message: 'A new Email has been sent to $email');
        startTimer();
      } else {
        final errorMessage = result?['message'] ?? 'Failed to resend Email';
        TLoaders.errorSnackbar(title: 'Error', message: errorMessage);
      }
    } catch (e) {
      TLoaders.errorSnackbar(
          title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
