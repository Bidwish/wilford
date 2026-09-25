import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/to_user/controller/get_recent_account_controller.dart';
import 'package:wilford/screens/to_user/screens/process/process.dart';
import 'package:wilford/screens/to_user/screens/recents/view_recents.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class WilfordRecentsTransferAccount extends StatelessWidget {
  const WilfordRecentsTransferAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(GetWilfordRecentTrasactionAccountController());

    return Obx(() {
      if (controller.isLoading.value) {
        return TContainer(
          chlid: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: List.generate(
                3,
                (index) {
                  return Shimmer.fromColors(
                    baseColor: isDark ? TColors.dark : TColors.grey,
                    highlightColor: isDark ? TColors.darkerGrey : TColors.white,
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: TColors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      title: Container(
                        height: 10,
                        width: 170,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: TColors.grey,
                        ),
                      ),
                      subtitle: Container(
                        height: 10,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: TColors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }

      if (controller.accounts.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: Text("-- No Account available --")),
        );
      }

      return TContainer(
        chlid: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: TSizes.md, right: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recents',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(fontWeightDelta: 2, fontSizeFactor: 1),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.search_normal,
                        size: TSizes.iconMd, color: TColors.primary),
                  ),
                ],
              ),
            ),
            Divider(
              color: isDark ? TColors.dark : TColors.white,
              thickness: 1,
              height: 10,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.accounts.take(3).length,
              separatorBuilder: (context, index) => Divider(
                color: isDark ? TColors.dark : TColors.white,
                thickness: 1,
                height: 10,
              ),
              itemBuilder: (context, index) {
                final account = controller.accounts[index];
                return ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: TColors.grey,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isDark ? TColors.darkGrey : TColors.grey,
                        width: 1.5,
                      ),
                    ),
                    child: TCirculerImage(
                      isNetworkImage: true,
                      image: account.image.toString(),
                      width: 43,
                      height: 43,
                      padding: 0,
                    ),
                  ),
                  title: Text(account.accountName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(fontWeightDelta: 1, fontSizeFactor: 1)),
                  subtitle: Text(
                    account.accountNumber,
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: TColors.darkGrey,
                          fontSizeDelta: 1,
                        ),
                  ),
                  onTap: () => Get.to(() => ProcessToUserScreen(
                        accountNumber: account.accountNumber.trim(),
                        bankCode: account.bankCode,
                        bankImage: account.image.toString(),
                        bankName: account.bankName,
                        accountName: account.accountName,
                      )),
                );
              },
            ),
            Divider(
              color: isDark ? TColors.dark : TColors.white,
              thickness: 1,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.sm * 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Get.to(() => const RecentScreen()),
                    style: TextButton.styleFrom(
                      backgroundColor: isDark ? TColors.dark : TColors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusLg * 2),
                      ),
                    ),
                    child: Text('view',
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
