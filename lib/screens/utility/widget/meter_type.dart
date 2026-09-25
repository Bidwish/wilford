import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart' show TColors;
import 'package:wilford/utils/constants/sizes.dart' show TSizes;
import 'package:wilford/utils/helpers/helper_functions.dart'
    show THelperFunctions;

class MeterTypeWidget extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onChanged;

  const MeterTypeWidget({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    Widget buildOption(String label) {
      final isSelected = selectedType == label;

      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(label),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
            decoration: BoxDecoration(
              color: isDark ? TColors.black : TColors.white,
              border: isSelected
                  ? Border.all(color: TColors.primary, width: 1.5)
                  : Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
            ),
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: isDark ? TColors.white : TColors.black,
                      fontWeightDelta: 2,
                    ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildOption('Prepaid'),
        const SizedBox(width: TSizes.sm),
        buildOption('Postpaid'),
      ],
    );
  }
}
