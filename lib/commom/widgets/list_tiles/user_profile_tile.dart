import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/profile/profile.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the user data from the storage
    final userController = Get.put(UserController());
    final user = userController.user.value;
    final profile = user?.profile ?? '';
    final profileUrl = profile.isNotEmpty ? profile : null;

    final String fname = user?.fName ?? '';
    final String lname = user?.lName ?? '';
    final String mname = user?.mName ?? '';
    final String email = user?.email ?? '';
    final String username = user?.username ?? '';
    final String fullName = '$lname $fname $mname';

    return ListTile(
      leading: TCirculerImage(
        isNetworkImage: profileUrl != null,
        image: profileUrl ?? TImages.user,
        width: 43,
        height: 43,
        padding: 0,
      ),
      title: Text(((username.isNotEmpty) ? username : fullName),
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.black)),
      subtitle: Text(TPrivacyMasker.hideEmailAddress(email),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.lightGrey)),
      trailing: IconButton(
        icon: const Icon(Iconsax.edit, size: 20, color: TColors.white),
        onPressed: () => Get.to(() => const ProfileScreen()),
      ),
    );
  }
}
