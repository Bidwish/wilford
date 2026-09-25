import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/sizes.dart';

class StatusRowWithIcon extends StatelessWidget {
  const StatusRowWithIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: TSizes.iconSm,
          color: color,
        ),
        const SizedBox(width: TSizes.xs),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.apply(color: color),
        ),
      ],
    );
  }
}
