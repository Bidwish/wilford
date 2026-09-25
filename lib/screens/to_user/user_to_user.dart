import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/to_user/widget/get_recepiant_account.dart';
import 'package:wilford/screens/to_user/widget/recent_transfer_user.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class ToUserkScreen extends StatelessWidget {
  const ToUserkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Transfer To Wilford Account"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(TSizes.defaultSpace / 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                  color: TColors.success.withAlpha(60),
                ),
                child: Text('Instant, Zero Issues, Free',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: const Color.fromARGB(255, 20, 131, 26))),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Recipant Account
              RecipantSearchForm(),
              SizedBox(height: TSizes.spaceBtwSections / 2),

              // Recents Accounts
              WilfordRecentsTransferAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
