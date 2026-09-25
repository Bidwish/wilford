import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/screens/utility/model/meter_model.dart';
import 'package:wilford/utils/popups/loaders.dart';

class GetMetersController extends GetxController {
  var isLoading = false.obs;
  var meters = <GetMeter>[].obs;

  Future<void> fatchMeters() async {
    try {
      isLoading.value = true;
      final response = await http
          .get(Uri.parse('https://api.wilford.ng/v1/utility/meters/'));

      debugPrint('$response');

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body)['data'];
        meters.value = decoded.map((e) => GetMeter.fromJson(e)).toList();
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
