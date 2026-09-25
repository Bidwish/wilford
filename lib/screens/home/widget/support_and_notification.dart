import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/screens/notification/controller/notification_controller.dart';
import 'package:wilford/screens/notification/notification.dart';
import 'package:wilford/screens/settings/screens/support/support.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TSupportAndNotification extends StatelessWidget {
  const TSupportAndNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NotificationController(), permanent: true);
    controller.fetchNotifications();

    return Row(
      children: [
        /// Notification Button
        GestureDetector(
          onTap: () async {
            await Get.to(() => const NotificationScreen());
            controller.updateNotificationStatus(); // mark as read when opened
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: isDark ? TColors.dark : TColors.light,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.notification,
                  color: isDark
                      ? TColors.primary.withAlpha(200)
                      : TColors.secondary,
                ),
              ),

              /// Red Dot when hasUnread == true
              Obx(() {
                if (!controller.hasUnread.value) {
                  return const SizedBox.shrink();
                }
                return Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? TColors.dark : TColors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        const SizedBox(width: 10),

        /// Support Button
        GestureDetector(
          onTap: () => Get.to(() => const SupportScreen()),
          child: Container(
            padding: const EdgeInsets.all(TSizes.sm),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: isDark ? TColors.dark : TColors.light,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.headset_mic,
              color:
                  isDark ? TColors.primary.withAlpha(200) : TColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
