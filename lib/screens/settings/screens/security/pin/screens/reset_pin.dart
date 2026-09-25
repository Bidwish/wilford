import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/send_otp/send_top.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/screens/settings/screens/security/pin/controller/reset/reset_pin_controller.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';
import 'package:wilford/utils/validators/validation.dart';

class TResetPin extends StatelessWidget {
  const TResetPin({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ResetPinController());
    final sendController = Get.put(EmailTopController());

    return Scaffold(
      appBar: TAppBar(
        title: Text("Reset Transaction Pin"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.md),
          child: Form(
            key: controller.resetPinFormKey,
            child: TContainer(
              chlid: Padding(
                padding: EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loing Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      controller: controller.password,
                      validator: (value) => TValidator.validateEmptyText(
                          'Loging Password', value),
                      obscureText: true,
                      maxLength: 6,
                      keyboardType: TextInputType.numberWithOptions(),
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
                      maxLength: 6,
                      keyboardType: TextInputType.numberWithOptions(),
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
                        onPressed: () => controller.resetPin(),
                        child: Text('Reset'),
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
