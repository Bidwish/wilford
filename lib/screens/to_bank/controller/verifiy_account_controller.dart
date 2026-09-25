import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/screens/to_user/screens/process/process.dart';

class VerifiyAccountController extends GetxController {
  final accNumber = TextEditingController();
  final GlobalKey<FormState> accountDetailFormKey = GlobalKey<FormState>();

  var isVerifying = false.obs;
  var errorText = ''.obs;
  var accountName = ''.obs;

  Future<void> verifyAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      isVerifying.value = true;
      errorText.value = '';
      accountName.value = '';

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/transfar/verify/'),
        body: jsonEncode({
          'account_number': accountNumber,
          'bank_code': bankCode,
        }),
      );

      debugPrint(response.body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        accountName.value = data['account_name'] ?? '';
      } else if (response.statusCode == 201) {
        Get.to(() => ProcessToUserScreen(
              accountNumber: accountNumber.trim(),
              bankCode: bankCode,
              bankImage: data['image'].toString(),
              bankName: 'Wilford Bank',
              accountName: data['account_name'].toString().toUpperCase(),
            ));
      } else {
        final data = jsonDecode(response.body);
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
