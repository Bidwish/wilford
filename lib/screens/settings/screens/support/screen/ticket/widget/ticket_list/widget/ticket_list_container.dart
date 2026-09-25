import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class TTicketContainer extends StatelessWidget {
  const TTicketContainer({
    super.key,
    required this.titel,
    required this.subtitel,
  });

  final String titel, subtitel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          border: Border.all(color: TColors.gray),
          borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titel,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .apply(fontWeightDelta: 3),
            ),
            const SizedBox(height: TSizes.sm),
            Text(
              subtitel,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
