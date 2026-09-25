import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class ExamSearchBar extends StatelessWidget {
  const ExamSearchBar({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? TColors.darkContainer : TColors.lightContainer,
      padding: const EdgeInsets.all(TSizes.lg),
      child: TextFormField(
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(TSizes.sm),
          prefixIcon: Icon(Iconsax.search_normal),
          filled: true,
          fillColor: isDark ? TColors.dark : TColors.white,
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(TSizes.borderRadiusLg),
              borderSide: BorderSide(color: TColors.darkContainer)),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(TSizes.borderRadiusLg),
              borderSide: BorderSide(color: TColors.primary)),
        ),
      ),
    );
  }
}
