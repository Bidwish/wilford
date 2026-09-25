import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/send_otp/send_top.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';
import 'package:wilford/utils/validators/validation.dart';

import 'controller/change_phone_controller.dart';

class TChangePhone extends StatelessWidget {
  const TChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ChangePhoneController());
    final sendController = Get.put(EmailTopController());

    return Scaffold(
      appBar: TAppBar(
        title: Text("Change Phone Number"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: TContainer(
            chlid: Padding(
              padding: EdgeInsets.all(TSizes.md),
              child: Form(
                key: controller.changePhoneNumber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Phone',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      controller: controller.cPhone,
                      validator: (value) =>
                          TValidator.validatePhoneNumber(value),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? TColors.dark : TColors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                          borderSide:
                              BorderSide(color: TColors.primary, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    Text(
                      'New Phone',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      controller: controller.nPhone,
                      validator: (value) =>
                          TValidator.validatePhoneNumber(value),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? TColors.dark : TColors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                          borderSide:
                              BorderSide(color: TColors.primary, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    Text(
                      'Login Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      controller: controller.passWord,
                      validator: (value) =>
                          TValidator.validateEmptyText('Login Password', value),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? TColors.dark : TColors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                          borderSide:
                              BorderSide(color: TColors.primary, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    Text(
                      'Please Input google code',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      controller: controller.gCode,
                      validator: (value) =>
                          TValidator.validateEmptyText('Google Code', value),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        filled: true,
                        fillColor: isDark ? TColors.dark : TColors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                          borderSide:
                              BorderSide(color: TColors.primary, width: 1.5),
                        ),
                      ),
                    ),

                    // --- Send google Code ---
                    Obx(
                      () {
                        return TextButton(
                          onPressed: sendController.isResendAvailable.value
                              ? sendController.resendEmail
                              : null,
                          child: sendController.isResendAvailable.value
                              ? const Text('Get Google code')
                              : Text(
                                  "Resend Email in 00:${sendController.secondsRemaining.value.toString().padLeft(2, '0')}"),
                        );
                      },
                    ),

                    // --- Submit Button ---
                    const SizedBox(height: TSizes.spaceBtwItems),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.changePhone(),
                        child: Text('Update'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
