import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wilford/routes/app_routes.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  /// Variables
  final box = GetStorage();

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to show Relevant Screen
  void screenRedirect() async {
    final onboardingShown = box.read('onboarding_shown') ?? false;
    final rememberMe = box.read('remember_me') ?? false;
    final session = Supabase.instance.client.auth.currentSession;

    if (!onboardingShown) {
      Get.offAllNamed(AppRoutes.onboarding);
      // }  else if (token == null) {
      //Get.offAllNamed(AppRoutes.home);
    } else if (session != null && rememberMe) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
