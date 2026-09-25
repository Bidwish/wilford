import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/primary_header_container.dart';
import 'package:wilford/commom/widgets/paybills_card/paybills_card.dart';
import 'package:wilford/screens/airtime/airtime.dart';
import 'package:wilford/screens/data/data.dart';
import 'package:wilford/screens/exam/exams.dart';
import 'package:wilford/screens/gift_caed/gift_card.dart';
import 'package:wilford/screens/tv/cable_tv.dart';
import 'package:wilford/screens/utility/utility_bills.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class PayBillsScreen extends StatelessWidget {
  const PayBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Column(
        children: [
          /// --- Header
          TPrimaryHeader(
            child: Column(
              children: [
                TAppBar(
                  title: Text(
                    'PayBills',
                    style: Theme.of(context).textTheme.headlineMedium!.apply(
                          color: TColors.black,
                        ),
                  ),
                  centerTitle: false,
                ),
                SizedBox(height: TSizes.spaceBtwItems),
              ],
            ),
          ),

          /// --- Body
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PayBillsWidgth(
                            title: 'Airtime',
                            subtitle:
                                'Recharge your airtime to your preferred network.',
                            bgColor: TColors.skyBlue,
                            icon: Iconsax.call_calling,
                            onTap: () => Get.to(() => const AirTimeScreen()),
                            isDark: isDark),
                        PayBillsWidgth(
                            title: 'Data Plan',
                            subtitle:
                                'Buy cheap bundle for all networks instantly.',
                            bgColor: TColors.amber,
                            icon: Iconsax.global,
                            onTap: () => Get.to(() => const DataScreen()),
                            isDark: isDark),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PayBillsWidgth(
                            title: 'Cable Subscription',
                            subtitle: 'Subscribe your DSTV, GOTV, & STARTIMES.',
                            bgColor: TColors.violet,
                            icon: Iconsax.monitor,
                            onTap: () => Get.to(() => const TvScreen()),
                            isDark: isDark),
                        PayBillsWidgth(
                            title: 'Gift Card',
                            subtitle:
                                'Wishing your love ones with joy and happiness.',
                            bgColor: TColors.info,
                            icon: Iconsax.gift,
                            onTap: () => Get.to(() => const GiftCardScreen()),
                            isDark: isDark),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PayBillsWidgth(
                            title: 'Utility',
                            subtitle:
                                'Buy your token for EEDC, IKEDC, ABA & more.',
                            bgColor: TColors.darkGrey,
                            icon: Iconsax.lamp_on,
                            onTap: () => Get.to(() => UtilityScreen()),
                            isDark: isDark),
                        PayBillsWidgth(
                            title: 'Education',
                            subtitle: 'Buy your JAMB, WAEC, NECO Exam.',
                            bgColor: TColors.red,
                            icon: Iconsax.clipboard_text,
                            onTap: () => Get.to(() => const ExamScreen()),
                            isDark: isDark),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                   
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
