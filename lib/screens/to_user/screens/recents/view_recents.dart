import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/to_bank/controller/get_recent_trasaction_account_controller.dart';
import 'package:wilford/screens/to_bank/screen/bank_transfer_process.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(GetRecentTrasactionAccountController());

    return Scaffold(
      appBar: TAppBar(
        title: Text("Beneficiaries"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.accounts.length,
                separatorBuilder: (context, index) => Divider(
                  color: isDark ? TColors.darkerGrey : TColors.white,
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
                    subtitle: Row(
                      children: [
                        Text(
                          account.accountNumber,
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                                color: TColors.darkGrey,
                                fontSizeDelta: 1,
                              ),
                        ),
                        const SizedBox(width: TSizes.sm),
                        Text(
                          account.bankName,
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                                color: TColors.darkGrey,
                                fontSizeDelta: 1,
                              ),
                        ),
                      ],
                    ),
                    onTap: () => Get.to(() => BankTransferProcessScreen(
                          accountNumber: account.accountNumber.trim(),
                          bankCode: account.bankCode,
                          bankImage: account.image.toString(),
                          bankName: account.bankName,
                          accountName: account.accountName,
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
