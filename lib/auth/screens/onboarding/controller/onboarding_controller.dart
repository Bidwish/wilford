import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/routes/app_routes.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// veriables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// Update Current Index when page Scroll
  // ignore: strict_top_level_inference
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Jumpo to the spacific dot selected page
  // ignore: strict_top_level_inference
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Jump to the spacificn dot selected Page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final box = GetStorage();
      box.write('onboarding_shown', true);
      Get.offAll(AppRoutes.login);
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Update Current Index & jump to the last page
  void skipPage() {
    GetStorage().write('onboarding_shown', true);
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
