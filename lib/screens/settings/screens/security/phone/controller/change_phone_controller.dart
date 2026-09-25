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

class ChangePhoneController extends GetxController {
  final cPhone = TextEditingController();
  final nPhone = TextEditingController();
  final passWord = TextEditingController();
  final gCode = TextEditingController();

  final GlobalKey<FormState> changePhoneNumber = GlobalKey<FormState>();

  Future<void> changePhone() async {
    try {
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
        TLoaders.warningSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      if (!changePhoneNumber.currentState!.validate()) return;

      final requestBody = {
        'cPhone': cPhone.text.trim(),
        'nPhone': nPhone.text.trim(),
        'passWord': passWord.text.trim(),
        'gCode': gCode.text.trim(),
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/auth/change-phone/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final jsonStart = response.body.indexOf('{');
      final result = jsonStart != -1
          ? jsonDecode(response.body.substring(jsonStart))
          : null;

      if (response.statusCode == 200) {
        TLoaders.successSnackbar(
          title: 'Success',
          message: 'Password changed successfully.',
        );
        logoutUser();
      } else {
        final errorMessage = result?['message'] ?? 'Something went wrong.';
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
    }
  }
}
