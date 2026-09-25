import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PromoSliderController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;
  final RxList<String> banners = <String>[].obs;
  final RxBool isLoading = true.obs;

  Timer? _timer;

  /// Fetch banners
  Future<void> fetchBanners(String screen) async {
    try {
      isLoading.value = true;

      final url =
          Uri.parse("https://api.wilford.ng/v1/promo_banner/?screen=$screen");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          banners.assignAll(
            List<String>.from(
              data['data'].map((item) => item['imageUrl']),
            ),
          );
        }
      }
    } catch (e) {
      // Get.snackbar("Error", "Failed to load banners: $e");
    } finally {
      isLoading.value = false;
      _startAutoScroll();
    }
  }

  /// Auto scroll setup
  void _startAutoScroll() {
    _timer?.cancel(); // Prevent multiple timers
    if (banners.isEmpty) return;

    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        if (pageController.hasClients && banners.isNotEmpty) {
          int nextPage = (currentIndex.value + 1) % banners.length;
          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  void onPageChanged(int index) => currentIndex.value = index;

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
