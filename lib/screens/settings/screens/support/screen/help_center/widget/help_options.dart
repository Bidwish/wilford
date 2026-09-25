import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class THelpCenterOptions extends StatelessWidget {
  const THelpCenterOptions({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: TSizes.md, bottom: TSizes.md),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: isDark ? TColors.darkerGrey : TColors.gray),
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              SizedBox(height: TSizes.sm),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: isDark ? TColors.white : TColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
