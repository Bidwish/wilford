import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifiyAccountController extends GetxController {
  final account = TextEditingController();

  var isVerifying = false.obs;
  var errorText = ''.obs;
  var accountNumber = ''.obs;
  var accountName = ''.obs;
  var accountImage = ''.obs;

  Future<void> verifyAccount({required String account}) async {
    try {
      isVerifying.value = true;
      errorText.value = '';
      accountName.value = '';
      accountImage.value = '';
      accountNumber.value = '';

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/transfar/verify/'),
        body: jsonEncode({
          'account_number': account,
          'bank_code': '0000',
        }),
      );

      debugPrint(response.body);

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        accountName.value = data['account_name'] ?? '';
        accountImage.value = data['image'] ?? '';
        accountNumber.value = data['account_number'] ?? '';
      } else {
        errorText.value = '${data['message'] ?? 'Invalid Account Number'}';
      }
    } catch (e) {
      errorText.value = 'Something went wrong.';
      debugPrint('Verify error: $e');
    } finally {
      isVerifying.value = false;
    }
  }
}
