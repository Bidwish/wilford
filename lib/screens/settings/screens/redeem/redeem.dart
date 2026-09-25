import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/redeem/widget/redeem_form.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class RedeemGiftCardScreen extends StatelessWidget {
  const RedeemGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("Redeem card"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Redeem a gift card',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(fontWeightDelta: 2),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // --- Redeem form ---
              const TRedeemForm(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // --- Buttom Text ---
              Text(
                'The entire gift amount will be added to your account balance',
                style: TextStyle(fontSize: 12, color: TColors.darkGrey),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: TSizes.sm),

              RichText(
                text: TextSpan(
                  style: TextStyle(color: TColors.darkGrey, fontSize: 11),
                  children: [
                    TextSpan(
                      text: 'Gift Card Usage: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? TColors.white : TColors.black),
                    ),
                    TextSpan(text: TTexts.giftCardSubtitle)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
