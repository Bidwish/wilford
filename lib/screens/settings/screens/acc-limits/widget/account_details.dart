import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';

class TLimitsAccountDetails extends StatelessWidget {
  const TLimitsAccountDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final user = userController.user.value;
    final fullName =
        '${user?.lName ?? ''} ${user?.fName ?? ''} ${user?.mName ?? ''}';
    final phone = user?.phone.toString() ?? '';

    String removeLeadingZero(String phone) {
      return phone.startsWith('0') ? phone.substring(1) : phone;
    }

    String cleaned = removeLeadingZero(phone);

    String formatAs334(String phone) {
      if (phone.length < 10) return phone;
      return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6)}';
    }

    return TContainer(
      chlid: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  TTexts.appName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.darkGrey, fontWeightDelta: 1),
                ),
                Text(
                  ' Account Number',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.darkGrey, fontWeightDelta: 1),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatAs334(cleaned),
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                        fontWeightDelta: 3,
                      ),
                ),
                SizedBox(
                  height: 30,
                  child: TextButton.icon(
                      style: TextButton.styleFrom(
                          backgroundColor: TColors.success.withAlpha(90),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: cleaned),
                        );
                      },
                      label: Text('Copy',
                          style:
                              TextStyle(color: TColors.success, fontSize: 10)),
                      icon: Icon(
                        Icons.copy,
                        color: TColors.success,
                        size: TSizes.iconXs,
                      )),
                ),
              ],
            ),
            const SizedBox(height: TSizes.sm),
            Text('Bank',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(color: TColors.darkGrey, fontWeightDelta: 1)),
            Row(
              children: [
                Text(
                  TTexts.appName,
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                        fontWeightDelta: 3,
                      ),
                ),
                Text(
                  ' Digital Services Limited ',
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                        fontWeightDelta: 3,
                      ),
                ),
                Text(
                  (TTexts.appName),
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                        fontWeightDelta: 3,
                      ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.sm),
            Row(
              children: [
                Text(
                  TTexts.appName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.darkGrey, fontWeightDelta: 1),
                ),
                Text(
                  ' Account Name',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.darkGrey, fontWeightDelta: 1),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                        fontWeightDelta: 3,
                      ),
                ),
                const SizedBox(width: TSizes.xs),
                Icon(
                  Iconsax.info_circle,
                  size: TSizes.iconSm,
                  color: TColors.darkGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
