import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class AirTimeAmount extends StatelessWidget {
  const AirTimeAmount({
    super.key,
    required this.amount,
    required this.pts,
    required this.payAmount,
    required this.onTap,
  });

  final String amount;
  final String payAmount;
  final String pts;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: TSizes.md),
        decoration: BoxDecoration(
          color: isDark ? TColors.dark : TColors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
          child: Column(
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? TColors.white : TColors.black,
                ),
              ),
              const SizedBox(height: TSizes.xs),
              Text(
                payAmount,
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: TColors.darkGrey,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: TSizes.md),
                width: double.infinity,
                color: TColors.success.withAlpha(90),
                child: Center(
                  child: Text(
                    pts,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: TColors.success),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
