import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';
import 'controller/deposit_controller.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final controller = Get.put(DepositController());

  @override
  void initState() {
    super.initState();
    controller.fatchDepositDetails();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Found Account"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: Obx(() {
        return RefreshIndicator(
          color: isDark ? TColors.primary : TColors.secondary,
          onRefresh: controller.fatchDepositDetails,
          child: controller.isLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Shimmer.fromColors(
                    baseColor: isDark ? TColors.darkContainer : TColors.gray,
                    highlightColor:
                        isDark ? TColors.darkerGrey : TColors.lightContainer,
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: TColors.white,
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusMd),
                      ),
                    ),
                  ),
                )
              : controller.depositAccs.value == null
                  ? const Center(child: Text('No account found.'))
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height),
                        child: Padding(
                          padding: const EdgeInsets.all(TSizes.md),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _buildAccountCard(context),
                          ),
                        ),
                      ),
                    ),
        );
      }),
    );
  }

  Widget _buildAccountCard(BuildContext context) {
    final acc = controller.depositAccs.value!;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm * 2),
        decoration: BoxDecoration(
          color: TColors.primary,
          borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Virtual Account',
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: TColors.textWhite,
                      ),
                ),
                Text(
                  'Nomba MFB',
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                        color: TColors.textWhite,
                        fontWeightDelta: 3,
                      ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.lg),

            // Account Number with copy
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Account Number:',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: TColors.textWhite,
                        )),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: acc.accountNumber));
                    // Get.snackbar('Copied', 'Account number copied to clipboard');
                  },
                  child: Row(
                    children: [
                      Text(acc.accountNumber,
                          style: Theme.of(context).textTheme.bodyLarge!.apply(
                                color: TColors.textWhite,
                                fontWeightDelta: 1,
                              )),
                      const SizedBox(width: 6),
                      const Icon(Icons.copy, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.sm),

            // Account Name
            infoRow('Account Name:', acc.accountName, context),

            const SizedBox(height: TSizes.sm),

            // Bank Name
            infoRow('Bank:', acc.bankName, context),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: TColors.textWhite,
                )),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: TColors.textWhite,
                    fontWeightDelta: 1,
                  )),
        ),
      ],
    );
  }
}
