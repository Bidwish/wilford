import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifyMeterController extends GetxController {
  final meterNumController = TextEditingController();
  final selectedMeter = ''.obs;
  final meterType = ''.obs;

  var statusText = ''.obs;
  var statusColor = Colors.transparent.obs;
  var isVerifying = false.obs;
  var customerName = '';

  Future<void> verifyMeter() async {
    final meterNum = meterNumController.text.trim();

    if (meterNum.isEmpty) {
      statusText.value = "Meter number is required";
      statusColor.value = Colors.red;
      return;
    }

    try {
      isVerifying.value = true;
      statusText.value = "";

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/utility/validate/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'meter': selectedMeter.value,
          'meterNum': meterNum,
          'meterType': meterType.value,
        }),
      );

      debugPrint(response.body);

      final data = jsonDecode(response.body);
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
