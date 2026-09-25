import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/loaders.dart';

class CheckPinController extends GetxController {
  static CheckPinController get instance => Get.find();

  final box = GetStorage();
  var hasPin = false.obs;

  void checkPin() async {
    try {
      final token = box.read('token');
      if (token == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      final response = await http.get(
        Uri.parse("https://api.wilford.ng/v1/user/has_pin"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic>? responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        debugPrint('Error decoding JSON: $e');
        responseData = null;
      }

      if (response.statusCode == 200 && responseData != null) {
        final bool pinStatus = responseData['has_pin'] == true;

        hasPin.value = pinStatus;
        box.write('has_pin', pinStatus);
      } else {
        hasPin.value = false;
        box.write('has_pin', false);
      }
    } catch (e) {
      debugPrint('Exception during pin check: $e');
      hasPin.value = false;
      box.write('has_pin', false);
    }
  }

  void loadHasPinFromStorage() {
    final storedValue = box.read('has_pin');
    hasPin.value = storedValue is bool ? storedValue : false;
  }
}
