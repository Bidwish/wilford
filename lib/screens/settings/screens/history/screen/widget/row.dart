import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TTransactionRow extends StatelessWidget {
  const TTransactionRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(color: TColors.darkGrey),
        ),
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(color: isDark ? TColors.white : TColors.dark),
        ),
      ],
    );
  }
}
