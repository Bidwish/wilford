import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class TContainer extends StatelessWidget {
  const TContainer({
    super.key,
    required this.chlid,
  });

  final Widget chlid;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        
        color: isDark ? TColors.darkContainer : TColors.lightContainer,
        borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
      ),
      child: Stack(
        children: [chlid],
      ),
    );
  }
}
