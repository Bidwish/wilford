import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/models/data/account_balance.dart';
import 'package:wilford/screens/settings/screens/history/history.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';

class TBalanceAndTransaction extends StatelessWidget {
  const TBalanceAndTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, controller),
                _buildBalanceDisplay(context, controller),
              ],
            ),
          ),

          /// History Button
          TextButton(
            onPressed: () => Get.to(() => HistoryScreen()),
            child: Row(
              children: [
                Text(
                  'Transaction History',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black, fontWeightDelta: 1),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.arrow_forward_ios_outlined,
                    size: 12, color: TColors.black),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      );
    });
  }

  /// Header Row (Icon, Label, Visibility Toggle)
  Widget _buildHeader(BuildContext context, AccountController controller) {
    return Row(
      children: [
        const Icon(Icons.shield, size: 15, color: TColors.black),
        const SizedBox(width: 4),
        Text(
          'Account Balance',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.black),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: controller.isLoading.value ? null : controller.toggleHidden,
          child: Icon(
            size: 18,
            color: TColors.black,
            controller.isHidden.value ? Icons.visibility_off_outlined : Icons.visibility,
          ),
        ),
      ],
    );
  }

  /// Balance Display Section
  Widget _buildBalanceDisplay(
      BuildContext context, AccountController controller) {
    if (controller.isLoading.value) {
      return Row(
        children: const [
          Text(
            '******',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: TColors.black,
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    if (controller.isHidden.value) {
      return const Text(
        '******',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: TColors.black,
        ),
      );
    }

    final balance =
        double.tryParse(controller.accountBalance.toString()) ?? 0.0;

    return formatCurrencyText(
      balance,
      color: TColors.black,
      amountSize: 24,
      symbolSize: 18,
    );
  }
}
