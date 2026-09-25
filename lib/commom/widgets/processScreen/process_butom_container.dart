import 'package:flutter/material.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ProcessBottomContainerWithImage extends StatelessWidget {
  const ProcessBottomContainerWithImage({
    super.key,
    required this.provider,
    required this.number,
    required this.image,
  });

  final String provider;
  final String number, image;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TContainer(
      chlid: Padding(
        padding: EdgeInsets.all(TSizes.md),
        child: Row(
          children: [
            TCirculerImage(width: 40, height: 40, padding: 0, image: image),
            const SizedBox(width: TSizes.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider,
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: isDark ? TColors.white : TColors.darkerGrey,
                      fontWeightDelta: 1),
                ),
                Text(
                  number,
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: isDark ? TColors.white : TColors.darkerGrey,
                      fontWeightDelta: 1),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
