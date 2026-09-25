import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';

class TCirculerContainer extends StatelessWidget {
  const TCirculerContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.redius = 400,
    this.padding = 0,
    this.child,
    this.backgroundColor = TColors.white,
  });

  final double? width;
  final double? height;
  final double redius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(redius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
