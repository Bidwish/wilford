import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/models/auth_user_model.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/profile/profile.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';

class TUserProfile extends StatelessWidget {
  const TUserProfile({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const ProfileScreen()),
      child: Row(
        children: [
          TCirculerImage(
            isNetworkImage: true,
            image: user?.profile ?? TImages.user,
            width: 43,
            height: 43,
            padding: 0,
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (user?.username != null && user!.username.isNotEmpty)
                    ? user!.username
                    : (user?.fName ?? ''),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.black),
              ),
              Text(
                TTexts.homeAppbarSubTitle,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: TColors.lightGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
