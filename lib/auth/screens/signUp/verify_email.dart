import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/auth/controllers/signup/otp_controller.dart';

import 'package:wilford/utils/helpers/helper_functions.dart';

import '../../../utils/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyOtpController());

    final args = Get.arguments;
    final phone = args['phone'] ?? '';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                image: AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & Sub title
              Text(TTexts.confirmPhone,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwItems / 2),
              Text('+234 $phone',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwInputFields),

              /// --- Pin Code Text Field ---
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                autoFocus: true,
                onChanged: (value) {},
                onCompleted: (code) {
                  debugPrint("Entered OTP: $code");
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: Colors.grey,
                  selectedColor: TColors.primary,
                  inactiveColor: Colors.grey,
                ),
              ),

              Text(TTexts.confirmPhoneSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isSubmitting.value
                      ? null
                      : controller.submitOtp,
                  child: Obx(() {
                    return controller.isSubmitting.value
                        ? const CircularProgressIndicator()
                        : const Text("Verify");
                  }),

                  // onPressed: () => Get.to(
                  //   () => SuccessScreen(
                  //      image: TImages.staticSuccessIllustration,
                  //     title: TTexts.yourAccountCreatedTitle,
                  //     subtitle: TTexts.yourAccountCreatedSubTitle,
                  //     onPressed: () => Get.to(() => const LoginScreen()),
                  //  ),
                  // ),
                  //child: const Text(TTexts.tContinue),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Obx(() {
                return TextButton(
                  onPressed: controller.isResendAvailable.value
                      ? controller.resendOtp
                      : null,
                  child: controller.isResendAvailable.value
                      ? const Text("Resend OTP")
                      : Text(
                          "Resend OTP in 00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
