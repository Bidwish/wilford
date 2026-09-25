import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'package:http/http.dart' as http;

class RedeemController extends GetxController {
  final cardCode = TextEditingController();

  /// Form key
  final GlobalKey<FormState> redeemFormKey = GlobalKey<FormState>();

  Future<void> redeemCard() async {
    // Check internet connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TLoaders.errorSnackbar(
        title: "No Internet",
        message: "Please check your internet connection and try again.",
      );
      return;
    }

    if (!redeemFormKey.currentState!.validate()) return;

    try {
      // open loader (adjust method name to your actual implementation)
      TFullScreenLoader.show();

      final box = GetStorage();
      final token = box.read('token');
      final user = box.read('user');

      // Debugging aid (remove or comment out in production)
      // print('RedeemController: stored user => $user');

      if (token == null) {
        _stopLoader();
        TLoaders.errorSnackbar(
            title: 'Unauthorized', message: 'No token found. Please login.');
        return;
      }

      if (user == null || user is! Map) {
        _stopLoader();
        TLoaders.errorSnackbar(
            title: 'User not found', message: 'Please login and try again.');
        return;
      }

      // Extract userId safely (handles int or String)
      int? userId;
      final dynamic rawUserId = user['userId'] ?? user['id'] ?? user['user_id'];

      if (rawUserId is int) {
        userId = rawUserId;
      } else if (rawUserId is String && rawUserId.isNotEmpty) {
        userId = int.tryParse(rawUserId);
      }

      if (userId == null) {
        _stopLoader();
        TLoaders.errorSnackbar(
          title: 'Invalid user',
          message:
              'Unable to determine user id. Please re-login or contact support.',
        );
        return;
      }

      final requestBody = {
        'code': cardCode.text.trim(),
        'user_id': userId,
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/giftcard/redeem/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      // Close loader after response
      _stopLoader();

      // Parse response safely
      final jsonStart = response.body.indexOf('{');
      final result = jsonStart != -1
          ? jsonDecode(response.body.substring(jsonStart))
          : null;

      if (response.statusCode == 200 && result?['status'] == true) {
        TLoaders.successSnackbar(
          title: 'Successful',
          message: 'You have successfully redeemed your gift card.',
        );

        Get.offAllNamed(AppRoutes.home);
      } else {
        final errorMessage = (result != null && result['message'] != null)
            ? result['message'].toString()
            : 'Redemption failed';
        TLoaders.errorSnackbar(title: 'Redeem Failed', message: errorMessage);
      }
    } catch (e) {
      // Ensure loader is closed on any exception
      _stopLoader();
      // Optional: print stack trace for debugging
      // print('Redeem error: $e\n$st');
      TLoaders.errorSnackbar(
          title: 'Error', message: 'Something went wrong: $e');
    }
  }

  void _stopLoader() {
    try {
      TFullScreenLoader.hide();
    } catch (_) {
      // ignore if method not available or throws
    }
  }

  @override
  void onClose() {
    cardCode.dispose();
    super.onClose();
  }
}
