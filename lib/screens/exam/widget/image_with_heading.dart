import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class TopExamScreenContainer extends StatelessWidget {
  const TopExamScreenContainer(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imageUrl});

  final String title, subtitle, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.md),
      child: Container(
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
              child: Image.asset(
                imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: TSizes.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color: Colors.grey[600],
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        fontWeightDelta: 1,
                        color: TColors.darkGrey,
                      ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
