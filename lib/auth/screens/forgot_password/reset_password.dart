import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/forgotten_password/resen_forgotton_email_controller.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    final args = Get.arguments;
    final email = args['email'] ?? '';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(AppRoutes.login),
              icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                image: AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & Sub title
              Text(TTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwItems / 2),
              Text(email,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwItems / 2),
              Text(TTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offNamed(AppRoutes.login),
                  child: const Text(TTexts.done),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              Obx(() {
                return TextButton(
                  onPressed: controller.isResendAvailable.value
                      ? controller.resendEmail
                      : null,
                  child: controller.isResendAvailable.value
                      ? const Text(TTexts.resendEmail)
                      : Text(
                          "Resend Email in 00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
