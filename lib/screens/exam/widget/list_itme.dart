import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ExamListViewWidget extends StatelessWidget {
  const ExamListViewWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
  });

  final String title, subtitle, imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Make the container take the full width
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          children: [
            Row(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                  child: Image.asset(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: TSizes.sm),

                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                            color: isDark ? TColors.grey : TColors.darkerGrey),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(fontWeightDelta: 2, color: TColors.primary),
                      ),
                    ],
                  ),
                )
              ],
            ),

            // Divider below the row
            Padding(
              padding: const EdgeInsets.only(top: TSizes.sm),
              child: Divider(
                color: isDark ? TColors.darkerGrey : TColors.grey,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
