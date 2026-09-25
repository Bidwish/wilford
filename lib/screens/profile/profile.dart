import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wilford/auth/controllers/reAuth/reAuthenticate_controller.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/auth/screens/change_username/change_username.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/profile/controller/profile_image_controller.dart';
import 'package:wilford/screens/profile/widget/profile_menu.dart';
import 'package:wilford/screens/settings/screens/security/phone/change_phone.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImageController = Get.put(ProfileImageController());
    final userController = Get.put(UserController());
    final isLoading = profileImageController.isLoading;
    final controller = Get.put(ReauthenticateController());

    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Profile"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- Profile Picture --
              Obx(() {
                if (isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Center(
                      child: const TCirculerImage(
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        image: TImages.user,
                        padding: 0,
                      ),
                    ),
                  );
                }

                final user = userController.user.value;
                final profile = user?.profile ?? '';
                final profileUrl = profile.isNotEmpty ? profile : null;

                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: isDark ? TColors.darkGrey : TColors.grey,
                          ),
                          color:
                              isDark ? TColors.darkerGrey : TColors.lightGrey,
                        ),
                        child: TCirculerImage(
                          isNetworkImage: profileUrl != null,
                          image: profileUrl ?? TImages.user,
                          width: 80,
                          height: 80,
                          padding: 0,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: TSizes.sm),
              Center(
                child: TextButton(
                  onPressed: () =>
                      profileImageController.pickerImageAndUpload(),
                  child: const Text('Change Profile Picture'),
                ),
              ),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Profile Info Header
              Text('Profile Info',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Profile Info Fields
              Obx(() {
                final user = userController.user.value;
                final fullName =
                    '${user?.lName ?? ''} ${user?.fName ?? ''} ${user?.mName ?? ''}';

                return Column(
                  children: [
                    TProfileMenu(
                      title: 'Name',
                      value: fullName,
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Username',
                      value: '${user?.username}', // hardcoded or replace
                      onPressed: () => Get.to(() => const ChangeUsername()),
                    ),
                  ],
                );
              }),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Personal Info
              Text('Profile Information',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() {
                final user = userController.user.value;

                return Column(
                  children: [
                    TProfileMenu(
                      title: 'User ID',
                      value: user?.id ?? '',
                      icon: Iconsax.copy,
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'E-Mail',
                      value: TPrivacyMasker.hideEmail('${user?.email}'),
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Phone Number',
                      value: TPrivacyMasker.hidePhone('${user?.phone}'),
                      onPressed: () => Get.to(() => const TChangePhone()),
                    ),
                    TProfileMenu(
                      title: 'Gender',
                      value: user?.gender ?? '',
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Date of Birth',
                      value: TPrivacyMasker.hideDate('${user?.dob}'),
                      onPressed: () {},
                    ),
                  ],
                );
              }),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
