import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class DataAmount extends StatelessWidget {
  const DataAmount({
    super.key,
    required this.amount,
    required this.pts,
    required this.onTap,
    required this.name,
    required this.time,
    required this.note,
  });

  final String amount, name, pts, time, note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? TColors.dark : TColors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
        ),
        child: Stack(
          children: [
            /// --- Main Content ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.md,
                vertical: TSizes.md,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                        color: isDark ? TColors.white : TColors.black,
                        fontWeightDelta: 2),
                  ),
                  const SizedBox(height: TSizes.xs),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: TColors.darkGrey,
                        ),
                  ),
                  const SizedBox(height: TSizes.xs),
                  Center(
                    child: Text(
                      amount,
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: TColors.darkGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    pts,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: TColors.success,
                    ),
                  ),
                ],
              ),
            ),

            /// --- Note at the Bottom ---
            if (note.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: TColors.warning.withAlpha(50),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(TSizes.cardRadiusSm),
                      bottomRight: Radius.circular(TSizes.cardRadiusSm),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      note,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: TColors.warning,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
