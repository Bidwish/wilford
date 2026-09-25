import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class UtilityAmountSection extends StatelessWidget {
  const UtilityAmountSection({
    super.key,
    required this.isDark,
    required this.amount,
    required this.pay,
    required this.onTap,
  });

  final bool isDark;
  final String amount, pay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          color: isDark ? TColors.black : TColors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
        ),
        child: Center(
          child: Column(
            children: [
              // Display the formatted amount
              Text(
                amount,
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pay $pay',
                style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: TColors.darkGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
