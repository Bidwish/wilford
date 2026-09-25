import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:wilford/auth/controllers/user_controller/refersh_user_data.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

class UpdateUsername extends GetxController {
  final userName = TextEditingController();

  final GlobalKey<FormState> updateUserNameForm = GlobalKey<FormState>();

  Future<void> updateUserName() async {
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

    if (!updateUserNameForm.currentState!.validate()) {
      TFullScreenLoader.hide();
      return;
    }

    try {
      final requestBody = {'username': userName.text.trim()};

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/user/username/"),
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
            title: 'Success', message: 'UserName changed successfully!');
        await refreshUserData();
        Get.offNamed(AppRoutes.profileScreen);
      } else {
        final errorMessage =
            responseData?['message'] ?? 'Something went wrong.';
        TLoaders.errorSnackbar(title: 'Change Failed', message: errorMessage);
        TFullScreenLoader.hide();
      }
    } catch (e) {
      // debugPrint('Exception during password change: $e');
      // TLoaders.errorSnackbar(title: 'Error', message: e.toString());
    }
  }
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
