import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ProcessRowContent extends StatelessWidget {
  const ProcessRowContent({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium!.apply(
              color: isDark ? TColors.white : TColors.darkerGrey,
              fontWeightDelta: 1),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: isDark ? TColors.white : TColors.darkerGrey,
          ),
        )
      ],
    );
  }
}
