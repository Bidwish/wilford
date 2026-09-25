import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/screens/to_bank/mordel/recents_transfared_users_model.dart';
import 'package:wilford/utils/popups/loaders.dart';

class GetRecentTrasactionAccountController extends GetxController {
  var isLoading = false.obs;
  var accounts = <GetRecentsTransferredUsers>[].obs;

  Future<void> fatchAccounts() async {
    try {
      isLoading.value = true;

      final box = GetStorage();
      final token = box.read('token');

      if (token == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final response = await http.get(
        Uri.parse('https://api.wilford.ng/v1/transfar/recent/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('$response');

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body)['data'];
        accounts.value =
            decoded.map((e) => GetRecentsTransferredUsers.fromJson(e)).toList();
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
