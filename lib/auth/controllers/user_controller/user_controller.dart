import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/auth/models/auth_user_model.dart';

class UserController extends GetxController {
  final user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    try {
      final storedUser = GetStorage().read('user');
      if (storedUser != null && storedUser is Map) {
        user.value = UserModel.fromJson(Map<String, dynamic>.from(storedUser));
      }
    } catch (e) {
      debugPrint("Error loading user from storage: $e");
    }
  }
}
