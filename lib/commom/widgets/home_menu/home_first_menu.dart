import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/commom/widgets/home_menu_container/icon_button_first_menu.dart';
import 'package:wilford/screens/deposit/deposit_screen.dart';
import 'package:wilford/screens/to_bank/bank.dart';
import 'package:wilford/screens/to_user/user_to_user.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';

class HomeFirstMenu extends StatelessWidget {
  const HomeFirstMenu({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: Container(
        decoration: BoxDecoration(
            color: isDark ? TColors.black.withAlpha(200) : TColors.white,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: TSizes.defaultSpace / 2,
            top: TSizes.defaultSpace / 1.5,
            left: TSizes.defaultSpace / 2,
            right: TSizes.defaultSpace / 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconFirstMenu(
                isDark: isDark,
                icon: Iconsax.user,
                title: 'To ${TTexts.appName}',
                onTop: () => Get.to(() => ToUserkScreen()),
              ),
              IconFirstMenu(
                isDark: isDark,
                icon: Iconsax.bank,
                title: 'To Bank',
                onTop: () => Get.to(() => ToBankScreen()),
              ),
              IconFirstMenu(
                isDark: isDark,
                icon: Iconsax.money_add,
                title: 'Deposit',
                onTop: () => Get.to(() => const DepositScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
