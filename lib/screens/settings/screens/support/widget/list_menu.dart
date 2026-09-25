import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TSupportMenu extends StatelessWidget {
  const TSupportMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        border: Border.all(
            color: isDark ? TColors.darkerGrey : TColors.grey, width: 1),
      ),
      child: ListTile(
        leading:
            Icon(icon, size: 25, color: isDark ? TColors.white : TColors.black),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .apply(color: TColors.darkGrey)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
