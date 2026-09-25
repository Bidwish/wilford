import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/support/screen/help_center/help_center.dart';
import 'package:wilford/screens/settings/screens/support/screen/ticket/ticket.dart';
import 'package:wilford/screens/settings/screens/support/widget/list_menu.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

import 'screen/contact_support/chat_notice.dart';
import 'screen/contact_support/contact_support.dart' show TContactSupportScreen;

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get user data from controller
    final userController = Get.put(UserController());
    final user = userController.user.value;

    final String fname = user?.fName ?? '';
    final String username = user?.username ?? '';

    final box = GetStorage();
    final chatId = box.read('chat_id');

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Help & Customer Support"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (username.isNotEmpty) ? username : fname,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: TSizes.sm),
              Text(
                'Hi! How can we help you?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// --- Help Center ---
              TSupportMenu(
                onTap: () => Get.to(() => const THelpCenterScreen()),
                icon: Iconsax.info_circle,
                title: 'Help Center',
                subtitle: 'Check out our FAQ, articles, and guides',
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: TColors.darkGrey,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// --- Contact Support ---
              TSupportMenu(
                onTap: () {
                  if (chatId != null && chatId.toString().isNotEmpty) {
                    // If user already has a chat, go directly to chat screen
                    Get.to(() => TContactSupportScreen());
                  } else {
                    // Otherwise, show notice screen (which starts new chat)
                    Get.to(() => const CustomSupportNotice());
                  }
                },
                icon: Icons.headphones_outlined,
                title: 'Contact Support',
                subtitle:
                    'Start or continue a live chat with our Customer Support team',
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: TColors.darkGrey,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// --- Submit a Ticket ---
              TSupportMenu(
                onTap: () => Get.to(() => const TTicketScreen()),
                icon: Iconsax.message_edit,
                title: 'Submit a Ticket',
                subtitle:
                    'Encountered a problem? Submit a ticket and we’ll assist you.',
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: TColors.darkGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
