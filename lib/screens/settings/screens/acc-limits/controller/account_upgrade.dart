import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'package:wilford/auth/controllers/user_controller/refersh_user_data.dart';

class UpgradeController extends GetxController {
  final dobController = TextEditingController();
  final gender = ''.obs;
  final isLoading = false.obs;

  void submitUpgradeForm() async {
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TLoaders.errorSnackbar(
        title: "No Internet",
        message: "Please check your internet connection and try again.",
      );
      return;
    }

    if (dobController.text.isEmpty || gender.value.isEmpty) {
      TLoaders.errorSnackbar(
        title: 'Error',
        message: 'Please fill in all fields.',
      );
      return;
    }

    final box = GetStorage();
    final token = box.read('token');
    if (token == null) {
      Get.snackbar('Unauthorized', 'You need to log in first');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/user/account_upgrade/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'dob': dobController.text,
          'gender': gender.value,
        }),
      );

      if (response.statusCode == 200) {
        Get.back();
        TLoaders.successSnackbar(
            title: 'Success', message: 'Account upgraded successfully');
        await refreshUserData(); // Refresh the user model
      } else {
        final body = jsonDecode(response.body);
        final message = body['message'] ?? 'Something went wrong';
        TLoaders.errorSnackbar(
          title: 'Failed',
          message: message,
        );
      }
    } catch (e) {
      //Get.snackbar('Error', e.toString());
      TLoaders.errorSnackbar(
        title: 'Error',
        message: 'An error occurred. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
