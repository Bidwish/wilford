
import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: TColors.primary.withAlpha(50),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
