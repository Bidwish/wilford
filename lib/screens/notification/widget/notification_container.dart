import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/screens/notification/model/notification_model.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/date&time_formatting.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key,
    required this.notification,
  });

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TContainer(
      chlid: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        padding: const EdgeInsets.all(TSizes.xs),
                        decoration: BoxDecoration(
                            color: isDark ? TColors.dark : TColors.white),
                        child: Image.asset(
                          height: 30,
                          width: 30,
                          TImages.logo,
                        ),
                      ),
                    ),

                    /// Red Dot
                    if (notification.status == '2' ||
                        notification.status == '1')
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? TColors.dark : TColors.white,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: TSizes.sm),
                Expanded(
                  child: Text(
                    'Incoming Transfer Successful',
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Description
            RichText(
              text: TextSpan(
                text: notification.senderName,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      fontWeightDelta: 1,
                      fontSizeDelta: 2,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      color: TColors.darkGrey,
                    ),
                children: [
                  TextSpan(
                    text:
                        ' has sent you ${formatCurrency(double.tryParse(notification.amount) ?? 0.0)}. Get 6% bonus on ${TTexts.appName} Airtime.',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(fontFamily: GoogleFonts.inter().fontFamily),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.md),
            Divider(
              height: TSizes.dividerHeight,
              color: isDark ? TColors.darkGrey : TColors.gray,
            ),
            const SizedBox(height: TSizes.md),

            /// Time & Action Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(formatDateAndTime(notification.time.toString()),
                        style: Theme.of(context).textTheme.bodySmall)),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'View',
                        style: TextStyle(
                          color: isDark ? TColors.secondary : TColors.primary,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: TSizes.iconSm,
                        color: isDark ? TColors.secondary : TColors.primary,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
