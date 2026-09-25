import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'controller/notification_controller.dart';
import 'widget/notification_container.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller once
    final controller = Get.put(NotificationController());
    controller.fetchNotifications();
    controller.updateNotificationStatus();

    return Scaffold(
      appBar: TAppBar(
        title: Text('Notifications'),
        actions: [
          GestureDetector(
              onTap: () => controller.markAllAsRead(), child: Text('Read All')),
          SizedBox(width: TSizes.md)
        ],
        centerTitle: true,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Obx(() {
          // Handle loading state
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: TColors.primary),
            );
          }

          // Handle empty state
          if (controller.notifications.isEmpty) {
            return Center(
              child: Text(
                'No Notifications',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }

          // Display notifications
          return ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: TSizes.md),
                child: NotificationContainer(notification: notification),
              );
            },
          );
        }),
      ),
    );
  }
}
