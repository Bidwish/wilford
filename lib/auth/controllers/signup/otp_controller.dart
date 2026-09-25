import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/text_strings.dart';
import 'package:wilford/utils/network/network_manager.dart';

import 'package:wilford/utils/popups/loaders.dart';

class VerifyOtpController extends GetxController {
  final otpController = TextEditingController();

  final secondsRemaining = 30.obs;
  final isResendAvailable = false.obs;
  final isSubmitting = false.obs;

  Timer? _timer;
  String phoneNumber = '';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    phoneNumber = args['phone'] ?? '';
    startTimer();
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

  Future<void> resendOtp() async {
    if (!isResendAvailable.value) return;

    try {
      final response = await Supabase.instance.client.functions.invoke(
        'sms-otp',
        body: {'action': 'resend', 'phone': phoneNumber},
      );
      if (response.status != 200) throw StateError('Unable to send OTP');
      TLoaders.successSnackbar(
          title: 'OTP Sent', message: 'A new OTP has been sent to $phoneNumber');
      startTimer();
    } catch (e) {
      TLoaders.errorSnackbar(
          title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }

  Future<void> submitOtp() async {
    final otp = otpController.text;
    if (otp.length != 6) {
      Get.snackbar('Invalid OTP', 'Please enter all 6 digits');
      return;
    }

    try {
      isSubmitting.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      final response = await Supabase.instance.client.functions.invoke(
        'sms-otp',
        body: {'action': 'verify', 'phone': phoneNumber, 'code': otp},
      );
      if (response.status == 200) {
        TLoaders.successSnackbar(
            title: 'Success', message: 'OTP verified successfully');
        Get.offNamed(AppRoutes.successScreen, arguments: {
          'image': TImages.staticSuccessIllustration,
          'title': TTexts.yourAccountCreatedTitle,
          'subtitle': TTexts.yourAccountCreatedSubTitle,
          'onPressed': () => Get.offAllNamed(AppRoutes.login)
        }); // Navigate to login or home
      }
    } catch (e) {
      TLoaders.errorSnackbar(
          title: 'Error', message: 'Something went wrong. Try again.');
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
