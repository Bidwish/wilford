import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class RateMonitor extends StatelessWidget {
  const RateMonitor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: TContainer(
        chlid: Padding(
          padding: const EdgeInsets.all(TSizes.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: isDark
                            ? TColors.primary
                            : TColors.primary.withAlpha(70),
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Iconsax.wifi,
                      size: TSizes.iconSm,
                      color: isDark ? TColors.white : TColors.primary,
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text(
                    'Bank Transfer Success Rate Monitor',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          fontWeightDelta: 1,
                          fontSizeFactor: 1,
                        ),
                  ),
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right_sharp,
                color: TColors.darkGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
