import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class InputAnountContainer extends StatelessWidget {
   const InputAnountContainer({
    super.key,
    required this.hint, required this.onPressed, required this.controller,
  });

  final String hint;
  final VoidCallback onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            style: TextStyle(
                fontSize: TSizes.fontSizeMd, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              prefixText: '£',
              prefixStyle: TextStyle(
                color: isDark ? TColors.gray : TColors.black,
                fontSize: TSizes.fontSizeMd,
                fontWeight: FontWeight.bold,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: TColors.darkGrey,
                fontSize: TSizes.fontSizeMd,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColors.darkGrey, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColors.primary, width: 1.5),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2)),
          child: Text('Pay'),
        ),
      ],
    );
  }
}
