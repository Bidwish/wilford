import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/to_user/controller/verifiy_account_controller.dart';
import 'package:wilford/screens/to_user/controller/get_recent_account_controller.dart';
import 'package:wilford/screens/to_user/screens/process/process.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class RecipantSearchForm extends StatefulWidget {
  const RecipantSearchForm({super.key});

  @override
  State<RecipantSearchForm> createState() => _RecipantSearchFormState();
}

class _RecipantSearchFormState extends State<RecipantSearchForm> {
  final recentController =
      Get.put(GetWilfordRecentTrasactionAccountController());
  final controller = Get.put(VerifiyAccountController());

  @override
  void initState() {
    super.initState();
    recentController.fatchAccounts();

    controller.account.addListener(_maybeVerifiAccoun);
  }

  void _maybeVerifiAccoun() {
    final account = controller.account.text.trim();

    if (RegExp(r'^\d{10}$').hasMatch(account)) {
      // Input is a 10-digit number – likely an account number
      controller.verifyAccount(account: account);
    } else if (RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(account)) {
      // Input looks like an email
      controller.verifyAccount(account: account);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TContainer(
      chlid: Padding(
        padding: const EdgeInsets.all(TSizes.sm * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recipient Account',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(fontWeightDelta: 2, fontSizeFactor: 1)),
            SizedBox(height: TSizes.spaceBtwItems / 2),

            /// -- Searchbar --
            TextField(
              style: TextStyle(fontSize: 16),
              controller: controller.account,
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? TColors.dark : TColors.white,
                contentPadding: EdgeInsets.all(TSizes.md),
                hintText: 'Wilford Account No./Phone no./E-mail',
                hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.gray)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.primary)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 1.5),

            /// Status Message
            Obx(() {
              if (controller.isVerifying.value) {
                return const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.green)),
                      SizedBox(width: 8),
                      Text('Verifying...', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                );
              }

              if (controller.errorText.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withAlpha(95),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          controller.errorText.value,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (controller.accountName.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child:
                      // Searched User Acount
                      GestureDetector(
                    onTap: () => Get.to(ProcessToUserScreen(
                      accountNumber: controller.accountNumber.trim(),
                      bankImage: controller.accountImage.toString(),
                      bankName: 'Wilford Bank',
                      accountName:
                          controller.accountName.toString().toUpperCase(),
                      bankCode: '0000',
                    )),
                    child: Container(
                      padding: const EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                          color: isDark ? TColors.dark : TColors.white,
                          borderRadius:
                              BorderRadius.circular(TSizes.cardRadiusMd)),
                      child: Row(
                        children: [
                          /// -- Account Image --
                          TCirculerImage(
                            isNetworkImage: true,
                            image: controller.accountImage.toString(),
                            width: 40,
                            height: 40,
                            padding: 0,
                          ),
                          const SizedBox(width: TSizes.md),

                          /// --- Account Name --
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.accountName.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(fontSizeFactor: 1),
                              ),
                              Text(
                                controller.accountNumber.string,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(
                                      color: TColors.darkGrey,
                                      fontWeightDelta: 1,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
