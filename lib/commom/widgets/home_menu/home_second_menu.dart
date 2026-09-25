import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/commom/widgets/home_menu_container/icon_button_second_menu.dart';
import 'package:wilford/screens/airtime/airtime.dart';
import 'package:wilford/screens/data/data.dart';
import 'package:wilford/screens/exam/exams.dart';
import 'package:wilford/screens/gift_caed/gift_card.dart';
import 'package:wilford/screens/p2p/p2p.dart';
import 'package:wilford/screens/tv/cable_tv.dart';
import 'package:wilford/screens/utility/utility_bills.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class HomeSecondMenu extends StatelessWidget {
  const HomeSecondMenu({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Iconsax.call_calling,
        'title': 'Airtime',
        'onTap': () => Get.to(() => const AirTimeScreen()),
      },
      {
        'icon': Iconsax.global,
        'title': 'Data',
        'onTap': () => Get.to(() => const DataScreen()),
      },
      {
        'icon': Iconsax.monitor,
        'title': 'TV',
        'onTap': () => Get.to(() => const TvScreen()),
      },
      {
        'icon': Iconsax.lamp_on,
        'title': 'Utility Bills',
        'onTap': () => Get.to(() => UtilityScreen()),
      },
      {
        'icon': Iconsax.clipboard_text,
        'title': 'Exam',
        'onTap': () => Get.to(() => const ExamScreen()),
      },
      {
        'icon': Iconsax.gift,
        'title': 'Gift Card',
        'onTap': () => Get.to(() => const GiftCardScreen()),
      },
      {
        'icon': Iconsax.gift,
        'title': 'P2P',
        'onTap': () => Get.to(() => const p2pScreen()),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? TColors.darkContainer : TColors.lightContainer,
          borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: TSizes.defaultSpace / 2, right: TSizes.defaultSpace / 2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: TSizes.defaultSpace / 2,
              bottom: TSizes.defaultSpace / 2,
            ),
            itemCount: menuItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: TSizes.spaceBtwItems,
              mainAxisSpacing: TSizes.spaceBtwItems,
              childAspectRatio: 0.9, //makes items slightly taller
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return IconMenu(
                isDark: isDark,
                icon: item['icon'],
                title: item['title'],
                onTop: item['onTap'],
              );
            },
          ),
        ),
      ),
    );
  }
}
