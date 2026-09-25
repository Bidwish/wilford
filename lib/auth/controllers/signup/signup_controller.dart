import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/backend/phone_formatter.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final hasReferral = false.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final referral = TextEditingController();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    TFullScreenLoader.show();
    try {
      if (!await NetworkManager.instance.isConnected()) {
        TLoaders.errorSnackbar(title: 'No Internet', message: 'Please check your connection and try again.');
        return;
      }
      if (!signupFormKey.currentState!.validate()) return;
      if (!privacyPolicy.value) {
        TLoaders.warningSnackbar(title: 'Accept Privacy Policy', message: 'You must accept the privacy policy before signing up.');
        return;
      }
      final phone = normalizeNigeriaPhone(phoneNumber.text);
      final response = await Supabase.instance.client.auth.signUp(
        phone: phone,
        password: password.text.trim(),
        data: {
          'first_name': firstName.text.trim(),
          'middle_name': middleName.text.trim(),
          'last_name': lastName.text.trim(),
          'email': email.text.trim(),
          if (hasReferral.value && referral.text.trim().isNotEmpty) 'referral_code': referral.text.trim(),
        },
      );
      if (response.user == null) {
        TLoaders.errorSnackbar(title: 'Signup Failed', message: 'Unable to create your account');
        return;
      }
      final otpResponse = await Supabase.instance.client.functions.invoke(
        'sms-otp',
        body: {'action': 'send', 'phone': phone},
      );
      if (otpResponse.status != 200) {
        TLoaders.errorSnackbar(title: 'Signup Failed', message: 'Unable to send verification code');
        return;
      }
      TLoaders.successSnackbar(title: 'Signup Successful', message: 'Your account has been created successfully!');
      Get.toNamed(AppRoutes.verifyEmail, arguments: {'phone': phone});
    } on AuthException catch (error) {
      TLoaders.errorSnackbar(title: 'Signup Failed', message: error.message);
    } on FormatException catch (error) {
      TLoaders.errorSnackbar(title: 'Invalid Phone', message: error.message);
    } catch (_) {
      TLoaders.errorSnackbar(title: 'Oh Snap!', message: 'An unexpected error occurred. Please try again later.');
    } finally {
      TFullScreenLoader.hide();
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    middleName.dispose();
    phoneNumber.dispose();
    password.dispose();
    email.dispose();
    referral.dispose();
    super.onClose();
  }
}
