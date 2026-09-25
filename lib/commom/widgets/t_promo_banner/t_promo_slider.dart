import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'promo_slider_controller.dart';

class TPromoSlider extends StatelessWidget {
  final String screen;

  const TPromoSlider({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromoSliderController());

    // Fetch banners for this screen
    controller.fetchBanners(screen);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.banners.isEmpty) {
        return const Center(child: Text("No banners available"));
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.banners.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (_, index) {
                final image = controller.banners[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                              child: Icon(Icons.broken_image, size: 40)),
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          /// Dot Indicator
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.banners.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: controller.currentIndex.value == index ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == index
                        ? TColors.primary
                        : TColors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
