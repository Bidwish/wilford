import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/utils/constants/colors.dart';

class FeeAndEarningRow extends StatelessWidget {
  const FeeAndEarningRow({
    super.key,
    required this.rightText,
    required this.leftText,
    this.color = TColors.darkGrey,
  });

  final String rightText, leftText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(color: TColors.darkGrey),
        ),
        Text(
          rightText,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(color: color, fontFamily: GoogleFonts.inter().fontFamily),
        ),
      ],
    );
  }
}
