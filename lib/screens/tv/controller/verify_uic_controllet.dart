import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifyUicController extends GetxController {
  final uicController = TextEditingController();
  final selectedProvider = 'dstv'.obs;

  var statusText = ''.obs;
  var statusColor = Colors.transparent.obs;
  var customerName = '';
  var isVerifying = false.obs;

  Future<void> verifyUic() async {
    final uic = uicController.text.trim();

    if (uic.isEmpty) {
      statusText.value = "SmartCard number is required";
      statusColor.value = Colors.red;
      return;
    }

    try {
      isVerifying.value = true;
      statusText.value = "";

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/tv/validate/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'provider': selectedProvider.value,
          'smartcard': uic,
        }),
      );

      debugPrint(response.body);

      final data = jsonDecode(response.body);

      debugPrint('$data'); // Correct: use string interpolation with quotes

      if (response.statusCode == 200 && data['customer'] != null) {
        customerName = data['customer'];
        statusText.value = data['customer'];
        statusColor.value = Colors.green;
      } else {
        statusText.value = data['message'] ?? 'Invalid SmartCard';
        statusColor.value = Colors.red;
      }
    } catch (e) {
      statusText.value = e.toString();
      statusColor.value = Colors.red;
    } finally {
      isVerifying.value = false;
    }
  }
}
