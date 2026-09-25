import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/acc-limits/widget/account_details.dart';
import 'package:wilford/screens/settings/screens/acc-limits/widget/bottom_sheet.dart';
import 'package:wilford/screens/settings/screens/acc-limits/widget/limite_amount.dart';
import 'package:wilford/utils/constants/sizes.dart';

class AccountLimitScreen extends StatelessWidget {
  const AccountLimitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Scaffold(
      appBar: TAppBar(
        title: Text("Account Limits"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              TLimitsAccountDetails(),
              const SizedBox(height: TSizes.spaceBtwSections / 2),

              // --- Sconde Container ---
              TTierContainer(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // --- Third Container ---
              Text(
                'More Tire coming soon...',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(fontSizeDelta: 1),
              ),
            ],
          ),
        ),
      ),

      // --- Bottom Button
      bottomNavigationBar: Obx(() {
        final user = userController.user.value;
        final tier = user?.tier ?? '';

        if (tier == '') {
          return Padding(
            padding: EdgeInsets.all(TSizes.sm),
            child: ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  TUpgradeButtomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              child: Text('Upgrade to Tier 1'),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(TSizes.sm),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Tier 2 Coming Soon'),
          ),
        );
      }),
    );
  }
}
