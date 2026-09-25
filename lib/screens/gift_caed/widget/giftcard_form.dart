import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';
import 'package:wilford/utils/validators/validation.dart';

class TGiftCardForm extends StatelessWidget {
  TGiftCardForm({super.key});

  final _giftCardFormKey = GlobalKey<FormState>();
  final amount = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final message =
      TextEditingController(text: 'Hope you enjoy this Wilford Gift Card!');

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Form(
      key: _giftCardFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Amount ---
          Text(
            'Amount',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontWeightDelta: 2, color: TColors.darkerGrey),
          ),
          const SizedBox(height: TSizes.xs),
          TextFormField(
            controller: amount,
            validator: (value) => TValidator.validateEmptyText('Amount', value),
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
              contentPadding: const EdgeInsets.all(TSizes.md),
              hintText: 'Amount',
              hintStyle: const TextStyle(color: TColors.darkGrey, fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.gray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.primary),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // --- Sender Name ---
          Text(
            'Your Name',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontWeightDelta: 2, color: TColors.darkerGrey),
          ),
          const SizedBox(height: TSizes.xs),
          TextFormField(
            controller: name,
            validator: (value) =>
                TValidator.validateEmptyText('Your Name', value),
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
              contentPadding: const EdgeInsets.all(TSizes.md),
              hintText: 'Your Name',
              hintStyle: const TextStyle(color: TColors.darkGrey, fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.gray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.primary),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // --- Email ---
          Text(
            'E-mail',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontWeightDelta: 2, color: TColors.darkerGrey),
          ),
          const SizedBox(height: TSizes.xs),
          TextFormField(
            controller: email,
            validator: (value) => TValidator.validateEmail(value),
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
              contentPadding: const EdgeInsets.all(TSizes.md),
              hintText: 'Enter email',
              hintStyle: const TextStyle(color: TColors.darkGrey, fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.gray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.primary),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // --- Message Box ---
          Text(
            'Message',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(fontWeightDelta: 2, color: TColors.darkerGrey),
          ),
          const SizedBox(height: TSizes.xs),
          TextFormField(
            controller: message,
            maxLines: 4,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
              contentPadding: const EdgeInsets.all(TSizes.md),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.gray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: const BorderSide(color: TColors.primary),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // --- Submit Button ---
          Center(
            child: SizedBox(
              width: 170,
              child: ElevatedButton(
                onPressed: () {
                  if (_giftCardFormKey.currentState!.validate()) {
                    Get.toNamed(AppRoutes.giftcardProcess, arguments: {
                      'amount': amount.text.trim(),
                      'name': name.text.trim(),
                      'email': email.text.trim(),
                      'message': message.text.trim(),
                    });
                  }
                },
                child: const Text('Buy'),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections * 2),
        ],
      ),
    );
  }
}
