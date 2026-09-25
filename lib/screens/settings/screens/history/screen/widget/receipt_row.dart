import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';

class TReceiptRow extends StatelessWidget {
  const TReceiptRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 8.5,
            color: TColors.darkGrey,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: TColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
