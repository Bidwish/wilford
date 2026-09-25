import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TvSubscription extends StatelessWidget {
  const TvSubscription({
    super.key,
    required this.title,
    required this.amount,
    required this.onTap,
  });

  final String title, amount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: isDark ? TColors.black : TColors.white,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusSm)),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                      color: isDark ? TColors.white : TColors.darkerGrey),
                ),
                const SizedBox(height: TSizes.xs),
                formatCurrencyWithOutZero(
                  double.tryParse(
                          amount.trim().isEmpty ? '0' : amount.trim()) ??
                      0.0,
                  symbolSize: 16,
                  amountSize: 16,
                  symbolWeight: FontWeight.w700,
                  amountWeight: FontWeight.w700,
                  color: isDark ? TColors.white : TColors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
