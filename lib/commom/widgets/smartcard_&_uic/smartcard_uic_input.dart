import 'package:flutter/material.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class UicAndMeterInPut extends StatelessWidget {
  final TextEditingController controller;
  final String title, hinttext;
  final VoidCallback onVerify;
  final String statusText;
  final Color statusColor;
  final bool isVerifying;

  const UicAndMeterInPut({
    super.key,
    required this.title,
    required this.hinttext,
    required this.controller,
    required this.onVerify,
    required this.statusText,
    required this.statusColor,
    required this.isVerifying,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TContainer(
      chlid: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Label
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? TColors.white : TColors.black,
                    fontSizeDelta: 1,
                    fontWeightDelta: 2,
                  ),
            ),
            const SizedBox(height: TSizes.sm),

            /// Field and Verify Button
            Container(
              height: 68,
              padding: const EdgeInsets.only(right: TSizes.sm),
              decoration: BoxDecoration(
                color: isDark ? TColors.black : TColors.white,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                border:
                    Border.all(color: isDark ? TColors.darkGrey : TColors.gray),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(TSizes.md),
                        hintText: hinttext,
                        hintStyle: TextStyle(
                          color: isDark ? TColors.grey : TColors.darkGrey,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onVerify,
                    child: Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusLg),
                      ),
                      child: Center(
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            color: TColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Status message or loader
            const SizedBox(height: TSizes.xs),
            if (isVerifying)
              Row(
                children: [
                  const SizedBox(
                    height: 14,
                    width: 14,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Verifying...',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  )
                ],
              ),
            if (statusText.isNotEmpty)
              Row(
                children: [
                  Icon(
                    statusColor == Colors.green
                        ? Icons.check_circle
                        : Icons.error,
                    color: statusColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      statusText,
                      style: TextStyle(color: statusColor, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
