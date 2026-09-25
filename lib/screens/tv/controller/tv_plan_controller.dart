import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/screens/tv/model/tv_plan_model.dart';
import 'package:wilford/utils/popups/loaders.dart';

class TvPlanController extends GetxController {
  var isLoading = false.obs;
  var tvPlans = <TvPlan>[].obs;

  var selectedProvider = 'dstv'.obs;

  Future<void> fatchTvPlans() async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('https://api.wilford.ng/v1/tv/plans/'));

      debugPrint('$response');

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body)['data'];
        tvPlans.value = decoded.map((e) => TvPlan.fromJson(e)).toList();
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
