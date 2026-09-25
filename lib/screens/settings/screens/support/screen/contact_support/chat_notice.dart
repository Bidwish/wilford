import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/support/screen/contact_support/controller/chat_controller.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class CustomSupportNotice extends StatelessWidget {
  const CustomSupportNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      appBar: TAppBar(actions: [
        IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(height: 200, 'assets/icons/customer_services.png'),
            const SizedBox(height: TSizes.spaceBtwSections / 3),
            Text(
              'Customer Support',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                  'Start a live chat with our Customer Support specialists.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => controller.startChat(),
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text('Start Conversation'),
        ),
      ),
    );
  }
}
