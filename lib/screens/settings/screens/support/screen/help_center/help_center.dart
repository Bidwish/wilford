import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/acc-limits/limits.dart';
import 'package:wilford/screens/settings/screens/security/password/manage_password.dart';
import 'package:wilford/screens/settings/screens/security/pin/screens/change_pin.dart';
import 'package:wilford/screens/settings/screens/security/pin/screens/reset_pin.dart';
import 'package:wilford/screens/settings/screens/support/screen/help_center/widget/help_options.dart';
import 'package:wilford/utils/constants/sizes.dart';

import '../../../security/phone/notice.dart';

class THelpCenterScreen extends StatelessWidget {
  const THelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Help Center"),
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
                'Self-Service',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.md),

              // --- Option Box ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  THelpCenterOptions(
                    text: 'Change Loing Password',
                    icon: Iconsax.unlock,
                    onTap: () => Get.to(() => const ChangePasswordScreen()),
                  ),
                  SizedBox(width: TSizes.md),
                  THelpCenterOptions(
                    text: 'Change Transaction Pin',
                    icon: Iconsax.card_edit,
                    onTap: () => Get.to(() => const TChangePin()),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  THelpCenterOptions(
                    text: 'Reset Transaction Pin',
                    icon: Icons.password,
                    onTap: () => Get.to(() => const TResetPin()),
                  ),
                  SizedBox(width: TSizes.md),
                  THelpCenterOptions(
                    text: 'Account Upgrade',
                    icon: Icons.upload,
                    onTap: () => Get.to(() => const AccountLimitScreen()),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  THelpCenterOptions(
                    text: 'Change Phone Number',
                    icon: Iconsax.mobile,
                    onTap: () => Get.to(() => ChangeNumberNotice()),
                  ),
                  SizedBox(width: TSizes.md),
                  Expanded(child: SizedBox(width: double.infinity))
                ],
              ),

              const SizedBox(height: TSizes.lg),

              Text(
                'FAQ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Center(
                  child: Text(
                '-- Not Available at the moment --',
                style: Theme.of(context).textTheme.labelMedium,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
