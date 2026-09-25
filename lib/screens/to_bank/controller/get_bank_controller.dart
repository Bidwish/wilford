import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/screens/to_bank/mordel/bank_model.dart';
import 'package:wilford/utils/popups/loaders.dart';

class GetBankController extends GetxController {
  var isLoading = false.obs;
  var banks = <GetBank>[].obs;

  Future<void> fatchBank() async {
    try {
      isLoading.value = true;
      final response = await http.get(
          Uri.parse('https://api.wilford.ng/v1/transfar/banks/get_banks/'));

      debugPrint('$response');

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body)['data'];
        banks.value = decoded.map((e) => GetBank.fromJson(e)).toList();
      } else {
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'Failed to load data plans',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
