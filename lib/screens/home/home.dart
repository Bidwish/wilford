import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/primary_header_container.dart';
import 'package:wilford/commom/widgets/home_menu/home_first_menu.dart';
import 'package:wilford/commom/widgets/home_menu/home_second_menu.dart';
import 'package:wilford/screens/home/widget/account_balance.dart';
import 'package:wilford/screens/settings/screens/refer_and_earn/controller/generate_refer_code.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/auth/models/data/account_balance.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import '../../commom/widgets/t_promo_banner/t_promo_slider.dart';
import '../settings/screens/refer_and_earn/controller/get_refer_controller.dart';
import '../settings/screens/security/pin/controller/set/check_pin.dart';
import 'widget/profile.dart' show TUserProfile;
import 'widget/support_and_notification.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _refreshAll() async {
    // Get.find<PromoSlider>().fatchBanners();
    // Get.find<CheckPinController>().checkPin();
    Get.find<GenerateReferCode>().referCode();
    Get.find<AccountController>().fatchAccountBalance();
    Get.find<GetReferController>().fatchReferDetails();
    Get.find<GenerateReferCode>().referCode();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    final userController = Get.put(UserController());
    final user = userController.user.value;

    final generateReferCode = Get.put(GenerateReferCode());
    final checkController = Get.put(CheckPinController());
    final accountController = Get.put(AccountController());

    // final sliderController = Get.put(PromoSlider());

    // Initial fetch
    // sliderController.fatchBanners();
    generateReferCode.referCode();
    checkController.checkPin();
    accountController.fatchAccountBalance();

    return Scaffold(
      body: Column(
        children: [
          /// Fixed Header - Never scrolls
          TPrimaryHeader(
            child: Column(
              children: [
                TAppBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: TSizes.sm),
                      TUserProfile(user: user),
                    ],
                  ),
                  actions: [TSupportAndNotification()],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TBalanceAndTransaction(),
                const SizedBox(height: TSizes.spaceBtwItems),
                HomeFirstMenu(isDark: isDark),
                const SizedBox(height: TSizes.spaceBtwSections * 1.3),
              ],
            ),
          ),

          /// Scrollable + Pull-to-Refresh Section
          Expanded(
            child: RefreshIndicator(
              color: isDark ? TColors.primary : TColors.secondary,
              onRefresh: _refreshAll,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TPromoSlider(screen: "home"),
                    HomeSecondMenu(isDark: isDark),
                    const SizedBox(height: TSizes.spaceBtwSections * 2.5),
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
