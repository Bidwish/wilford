import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class IconMenu extends StatelessWidget {
  const IconMenu({
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
    return Column(
      children: [
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
            color: isDark ? TColors.primary : TColors.primary.withAlpha(30),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: Icon(icon,
                size: 15, color: isDark ? TColors.white : TColors.primary),
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
