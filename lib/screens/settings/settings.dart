import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/auth/controllers/logout/logout_controller.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/containers/primary_header_container.dart';
import 'package:wilford/commom/widgets/list_tiles/setting_meun_tile.dart';
import 'package:wilford/commom/widgets/list_tiles/user_profile_tile.dart';
import 'package:wilford/commom/widgets/selection_header/section_heading.dart';
import 'package:wilford/screens/settings/screens/acc-limits/limits.dart';
import 'package:wilford/screens/settings/screens/history/history.dart';
import 'package:wilford/screens/settings/screens/redeem/redeem.dart';
import 'package:wilford/screens/settings/screens/refer_and_earn/refer_and_earn.dart';
import 'package:wilford/screens/settings/screens/security/password/manage_password.dart';
import 'package:wilford/screens/settings/screens/security/pin/manage_pin.dart';
import 'package:wilford/screens/settings/screens/support/support.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/theme/controller/theme_swticher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// --- Header
          TPrimaryHeader(
            child: Column(
              children: [
                /// AppBar
                TAppBar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.black),
                  ),
                  centerTitle: false,
                ),

                /// User Profile Card
                const TUserProfileTile(),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),

          /// --- Body
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                child: Column(
                  children: [
                    /// -- Account Settings
                    TSectionHeading(
                      title: 'Account Settings',
                      showActionButton: false,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TContainer(
                      chlid: Column(
                        children: [
                          TSettingMenuTile(
                            icon: Icons.history,
                            title: 'Transaction History',
                            subtitle: 'view all transactions',
                            trailing: Icon(Icons.keyboard_arrow_right,
                                size: 28, color: TColors.primary),
                            onTop: () => Get.to(() => HistoryScreen()),
                          ),
                          TSettingMenuTile(
                            icon: Icons.speed,
                            title: 'Account Limit',
                            subtitle: 'upgrade your account',
                            trailing: Icon(Icons.keyboard_arrow_right,
                                size: 28, color: TColors.primary),
                            onTop: () =>
                                Get.to(() => const AccountLimitScreen()),
                          ),
                          TSettingMenuTile(
                            icon: Icons.card_giftcard_outlined,
                            title: 'Redeem Gift Card',
                            subtitle: 'redeem all your card here',
                            trailing: Icon(Icons.keyboard_arrow_right,
                                size: 28, color: TColors.primary),
                            onTop: () =>
                                Get.to(() => const RedeemGiftCardScreen()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections / 1.3),

                    TContainer(
                      chlid: Column(
                        children: [
                          TSettingMenuTile(
                            icon: Icons.key_outlined,
                            title: 'Manga Security Pin',
                            subtitle: 'set and manage your security pin',
                            trailing: Icon(Icons.keyboard_arrow_right,
                                size: 28, color: TColors.primary),
                            onTop: () => Get.to(() => const ManagePinScreen()),
                          ),
                          TSettingMenuTile(
                            icon: Icons.password_outlined,
                            title: 'Change Password',
                            subtitle: 'manage your password',
                            trailing: Icon(Icons.keyboard_arrow_right,
                                size: 28, color: TColors.primary),
                            onTop: () =>
                                Get.to(() => const ChangePasswordScreen()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections / 1.3),

                    TContainer(
                      chlid: Column(
                        children: [
                          TSettingMenuTile(
                            icon: Iconsax.people,
                            title: 'Refer & Earn',
                            subtitle: 'earn money by referring friends',
                            trailing: Icon(Icons.keyboard_arrow_right,
                                size: 28, color: TColors.primary),
                            onTop: () => Get.to(() => const ReferScreen()),
                          ),
                          TSettingMenuTile(
                            icon: Icons.support_agent,
                            title: 'Help & Support',
                            subtitle: 'get help from our support team',
                            trailing: Icon(Icons.keyboard_arrow_right,
                                size: 28, color: TColors.primary),
                            onTop: () => Get.to(() => const SupportScreen()),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),
                    TSectionHeading(
                      title: 'App Settings',
                      showActionButton: false,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TContainer(
                      chlid: Column(
                        children: [
                          TSettingMenuTile(
                            icon: Icons.brightness_6_outlined,
                            title: 'App Theme',
                            subtitle: 'Light / Dark / System',
                            trailing: const Icon(Icons.keyboard_arrow_right,
                                color: TColors.primary),
                            onTop: () => Get.bottomSheet(
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                child: const ThemeSwitcher(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Logout Button
                    const SizedBox(height: TSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: showLogoutDialog,
                        child: Text('Logout'),
                      ),
                    ),
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
