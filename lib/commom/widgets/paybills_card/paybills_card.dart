import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class PayBillsWidgth extends StatelessWidget {
  const PayBillsWidgth({
    super.key,
    required this.isDark,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.bgColor,
  });

  final bool isDark;
  final IconData icon;
  final String title, subtitle;
  final VoidCallback? onTap;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:
            MediaQuery.of(context).size.width / 2 - TSizes.defaultSpace * 1.5,
        padding: const EdgeInsets.all(TSizes.defaultSpace / 1.5),
        decoration: BoxDecoration(
          color: bgColor!.withAlpha(60),
          borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(TSizes.defaultSpace / 3),
              decoration: BoxDecoration(
                color: isDark ? TColors.dark : TColors.white,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: bgColor ?? Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Icon(icon, color: bgColor, size: TSizes.iconSm),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: isDark ? TColors.white : TColors.black)),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: isDark ? TColors.textWhite : TColors.darkerGrey),
            ),
            SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
