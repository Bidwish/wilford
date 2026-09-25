import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/loaders.dart';

Future<void> submitGiftCard({
  required String pin,
  required String amount,
  required String email,
  required String senderName,
  required String message,
}) async {
  final box = GetStorage();
  final token = box.read('token');

  // Get the user data from the storage
  final userController = Get.put(UserController());
  final user = userController.user.value;

  final userId = user?.id ?? '';

  if (token == null) {
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
    final response = await http.post(
      Uri.parse('https://api.wilford.ng/v1/giftcard/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'amount': amount,
        'email': email,
        'sender_name': senderName,
        'message': message,
        'user_id': userId,
        'pin': pin,
      }),
    );

    final jsonResponse = _extractJson(response.body);
    final errorMessage = jsonResponse?['message'] ?? 'Invalid data provided';

    if (response.statusCode == 200 && jsonResponse != null) {
      // TLoaders.successSnackbar(
      //  title: 'Success',
      //  message: 'Gift Card Sent Successfully!',
      // );
      Get.offNamed(AppRoutes.paymentSuccess, arguments: {
        'title': 'Transaction Successful',
        'subtitle':
            'The recipient account is expected to be credited within 5 minutes.!',
        'image': TImages.successfulPaymentIcon,
        'onPressed': () {
          Get.offAllNamed(AppRoutes.home);
        },
      });
    } else if (response.statusCode == 400) {
      TLoaders.warningSnackbar(
        title: 'Set Transaction Pin',
        message: errorMessage,
      );
      // Get.offAllNamed(AppRoutes.setpin);
      Get.offAllNamed(AppRoutes.setpin);
    } else {
      TLoaders.errorSnackbar(title: 'Failed', message: errorMessage);
    }
  } catch (e) {
    // debugPrint('Gift Card Error: ${e.toString()}');
    TLoaders.errorSnackbar(
      title: 'Error',
      message: 'Failed to send Gift Card. Please try again.',
    );
  }
}

/// Helper to safely extract JSON even if server sends extra text
Map<String, dynamic>? _extractJson(String body) {
  final jsonStart = body.indexOf('{');
  if (jsonStart == -1) return null;

  final jsonString = body.substring(jsonStart);
  try {
    return jsonDecode(jsonString);
  } catch (_) {
    return null;
  }
}
