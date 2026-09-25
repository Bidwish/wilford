import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/screens/data/model/data_plan_model.dart';
import 'package:wilford/utils/popups/loaders.dart';

class DataController extends GetxController {
  var isLoading = false.obs;
  var dataPlans = <DataPlan>[].obs;

  var selectedNetwork = 'mtn'.obs;
  var selectedType = 'daily'.obs;

  Future<void> fatchDataPlans() async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('https://api.wilford.ng/v1/data/plans/'));

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body)['data'];
        dataPlans.value = decoded.map((e) => DataPlan.fromJson(e)).toList();
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

  /// ✅ Types only for the selected network
  List<String> get availableTypes {
    final plansByNetwork = dataPlans.where((plan) =>
        selectedNetwork.value.isEmpty ||
        plan.network.toLowerCase() == selectedNetwork.value.toLowerCase());

    final types =
        plansByNetwork.map((e) => e.type.toLowerCase()).toSet().toList();
    types.sort();
    return types;
  }

  /// ✅ Apply both network + type filters
  List<DataPlan> get filteredPlans {
    return dataPlans.where((plan) {
      final matchNetwork = selectedNetwork.value.isEmpty ||
          plan.network.toLowerCase() == selectedNetwork.value.toLowerCase();
      final matchType = selectedType.value.isEmpty ||
          plan.type.toLowerCase() == selectedType.value.toLowerCase();
      return matchNetwork && matchType;
    }).toList();
  }
}
