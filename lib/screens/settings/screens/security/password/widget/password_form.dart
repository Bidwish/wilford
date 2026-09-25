import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/send_otp/send_top.dart';
import 'package:wilford/screens/settings/screens/security/password/controller/change_password_controller.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/validators/validation.dart';

class TChangePasswordForm extends StatelessWidget {
  const TChangePasswordForm({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    final sendController = Get.put(EmailTopController());

    return Form(
      key: controller.changePasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Password',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontWeightDelta: 1),
          ),
          const SizedBox(height: TSizes.xs),
          TextFormField(
            controller: controller.cPassword,
            maxLength: 6,
            obscureText: true,
            validator: controller.validateCurrentPassword,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? TColors.dark : TColors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: BorderSide(color: TColors.primary, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text(
            'New Password',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontWeightDelta: 1),
          ),
          const SizedBox(height: TSizes.xs),
          TextFormField(
            controller: controller.nPassword,
            maxLength: 6,
            obscureText: true,
            validator: controller.validateNewPassword,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? TColors.dark : TColors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: BorderSide(color: TColors.primary, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text(
            'New Password Again',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontWeightDelta: 1),
          ),
          const SizedBox(height: TSizes.xs),
          TextFormField(
            controller: controller.rPassword,
            maxLength: 6,
            obscureText: true,
            validator: controller.validateRepeatPassword,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? TColors.dark : TColors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: BorderSide(color: TColors.primary, width: 1.5),
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
            maxLength: 6,
            validator: (value) =>
                TValidator.validateEmptyText('Google Code', value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              filled: true,
              fillColor: isDark ? TColors.dark : TColors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: BorderSide(color: TColors.primary, width: 1.5),
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
              onPressed: () => controller.changePassword(),
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
