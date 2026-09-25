import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wilford/commom/styles/spacing_styles.dart';
import 'package:wilford/screens/settings/screens/history/history.dart';
import 'package:wilford/utils/constants/sizes.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final title = args['title'];
    final subtitle = args['subtitle'];
    final image = args['image'];
    final onPressed = args['onPressed'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingwithAppBar * 2,
          child: Column(
            children: [
              // Lottie animation
              Lottie.asset(
                image,
                width: 200,
                height: 200,
                repeat: false,
                animate: true,
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & Sub title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwItems / 2),

              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Done'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// --- View History
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.to(() => HistoryScreen()),
                  child: Text('View History'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
