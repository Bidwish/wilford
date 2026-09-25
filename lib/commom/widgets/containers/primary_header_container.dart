import 'package:flutter/material.dart';
import 'package:wilford/commom/custom_shapes/circule_container.dart';
import 'package:wilford/commom/widgets/containers/curved_egdes_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TPrimaryHeader extends StatelessWidget {
  const TPrimaryHeader({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TCurvedEdgeWidget(
      child: Container(
        color: isDark ? TColors.primary : TColors.secondary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCirculerContainer(
                backgroundColor: TColors.textWhite.withAlpha(50),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCirculerContainer(
                backgroundColor: TColors.textWhite.withAlpha(50),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
