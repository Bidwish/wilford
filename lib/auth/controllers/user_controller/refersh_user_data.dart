import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/auth/models/auth_user_model.dart';

Future<void> refreshUserData() async {
  try {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;
    final result = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    final user = UserModel.fromJson(result);

      // Update user in The Storage
      final box = GetStorage();
      box.write('user', user.toJson());

      // Update user in userController
      final userController = Get.find<UserController>();
      userController.user.value = user;
  } catch (e) {
    debugPrint("Error refreshing user: $e");
  }
}
