import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wilford/screens/deposit/model/deposit_model.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DepositController extends GetxController {
  var depositAccs = Rxn<DepositAcc>();
  var isLoading = false.obs;

  Future<void> fatchDepositDetails() async {
    try {
      isLoading.value = true;

      // Delay to avoid context conflict
      await Future.delayed(const Duration(milliseconds: 200));
      // TFullScreenLoader.show();

      final box = GetStorage();
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('https://api.wilford.ng/v1/user/acc/'),
        headers: {
          'content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        depositAccs.value = DepositAcc.fromJson(decoded);
      } else {
        TLoaders.errorSnackbar(title: 'Error');
      }
    } catch (e) {
      debugPrint(e.toString());
      TLoaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
      // TFullScreenLoader.hide();
    }
  }
}
