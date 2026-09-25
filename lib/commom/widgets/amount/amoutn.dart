import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({super.key, required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return formatCurrencyText(
      double.tryParse(amount.trim().isEmpty ? '0' : amount.trim()) ?? 0.0,
      symbolSize: 18,
      amountSize: 28,
      symbolWeight: FontWeight.w700,
      amountWeight: FontWeight.w800,
      color: isDark ? TColors.white : TColors.black,
    );
  }
}
