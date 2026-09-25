import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';

Future<void> submitData({
  required String pin,
  required String amount,
  required String network,
  required String phoneNumber,
  required String code,
  required String pts,
  required String name,
}) async {
  // Show loading indicator
  TFullScreenLoader.show();

  if (Supabase.instance.client.auth.currentUser == null) {
    Get.offAllNamed(AppRoutes.login);
    return;
  }

  // Check internet connectivity
  final isConnected = await NetworkManager.instance.isConnected();
  if (!isConnected) {
    TLoaders.errorSnackbar(
      title: "No Internet",
      message: "Please check your internet connection and try again.",
    );
    return;
  }

  try {
    final response = await Supabase.instance.client.functions.invoke(
      'vtpass-data',
      body: {
        'category': 'data',
        'amount': double.tryParse(amount) ?? 0,
        'network': network,
        'phone': phoneNumber,
        'pts': pts,
        'name': name,
        'pin': pin,
      },
    );
    final payload = response.data is Map ? Map<String, dynamic>.from(response.data) : <String, dynamic>{};
    final errorMessage = payload['message'] ?? payload['error'] ?? 'Invalid data provided';

    if (response.status == 202 && payload['pending'] == true) {
      TFullScreenLoader.hide();

      // Handle success response
      Get.offNamed(AppRoutes.paymentSuccess, arguments: {
        'title': 'Transaction Processing',
        'subtitle':
            'The recipient account is expected to be credited within 5 minutes.!',
        'image': TImages.successfulPaymentIcon,
        'onPressed': () {
          Get.offAllNamed(AppRoutes.home);
        },
      });
    } else if (response.status == 401) {
      TFullScreenLoader.hide();

      // Handle specific error response
      TLoaders.errorSnackbar(
        title: "Error",
        message: errorMessage,
      );
    } else {
      TFullScreenLoader.hide();

      // Handle other error responses
      TLoaders.errorSnackbar(title: 'Failed', message: errorMessage);
    }
  } catch (e) {
    debugPrint('Error: $e');
    TFullScreenLoader.hide();

    TLoaders.errorSnackbar(
      title: "Error",
      message: "An error occurred. Please try again.",
    );
  } finally {
    // Hide the loading indicator if needed
    TFullScreenLoader.hide();
  }
}
