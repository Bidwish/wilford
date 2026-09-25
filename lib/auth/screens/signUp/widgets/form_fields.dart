import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/auth/controllers/signup/signup_controller.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';
import 'package:wilford/utils/validators/validation.dart';

class SignupFormField extends StatelessWidget {
  const SignupFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// First Name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText('First name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: TTexts.firstName,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),

              ///  Middle Name
              Expanded(
                child: TextFormField(
                  controller: controller.middleName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Middle name', value),
                  expands: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: TTexts.middleName,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///  Last Name
          TextFormField(
            controller: controller.lastName,
            validator: (value) =>
                TValidator.validateEmptyText('Last name', value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.user),
              labelText: TTexts.lastName,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///  Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.call),
              labelText: TTexts.phoneNo,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),

          // --- Toggle Referral Field ---
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Obx(
                  () => Checkbox(
                    value: controller.hasReferral.value,
                    onChanged: (val) =>
                        controller.hasReferral.value = val ?? false,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.sm),
              const Text("I have a referral code"),
            ],
          ),

          // --- Referral Code Field (only if toggled on) ---
          Obx(
            () => controller.hasReferral.value
                ? Column(
                    children: [
                      const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                      TextFormField(
                        controller: controller.referral,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.tag),
                          labelText: "Referral Code (optional)",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                    ],
                  )
                : const SizedBox(),
          ),

          /// Privacy Policy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Remember Me
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Obx(
                      () => Checkbox(
                          value: controller.privacyPolicy.value,
                          onChanged: (value) =>
                              controller.privacyPolicy.value = value!),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: '${TTexts.iAgreeTo} ',
                            style: Theme.of(context).textTheme.labelSmall),
                        TextSpan(
                          text: '${TTexts.privacyPolicy} ',
                          style: Theme.of(context).textTheme.labelSmall!.apply(
                                color: dark ? TColors.white : TColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    dark ? TColors.white : TColors.primary,
                              ),
                        ),
                        TextSpan(
                            text: '${TTexts.and} ',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                          text: '${TTexts.termsOfUse} ',
                          style: Theme.of(context).textTheme.labelSmall!.apply(
                                color: dark ? TColors.white : TColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    dark ? TColors.white : TColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Sign In Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
