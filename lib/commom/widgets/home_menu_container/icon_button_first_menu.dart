import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

import '../../../utils/helpers/helper_functions.dart';

class IconFirstMenu extends StatelessWidget {
  const IconFirstMenu({
    super.key,
    required this.isDark,
    required this.icon,
    required this.title,
    this.onTop,
  });

  final bool isDark;
  final IconData icon;
  final String title;
  final VoidCallback? onTop;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Container(
          height: 45,
          width: 50,
          decoration: BoxDecoration(
            color: isDark ? TColors.primary : TColors.secondary,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
          ),
          child: IconButton(
            icon: Icon(icon, size: 25, color: TColors.white),
            onPressed: onTop,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge!,
        )
      ],
    );
  }
}
