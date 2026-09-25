import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

class ReferralActions extends StatelessWidget {
  final String referralCode;

  const ReferralActions({super.key, required this.referralCode});

  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Referral code copied')),
    );
  }

  void shareReferral(BuildContext context) {
    if (referralCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Referral code is empty')),
      );
      return;
    }

    final String message =
        'Join me on Wilford and get a discount on your first purchase! Use my referral code: $referralCode';

    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: TSizes.lg, right: TSizes.lg),
            decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(30)),
            child: TextButton.icon(
              onPressed: () => shareReferral(context),
              label: Text(
                'Invite a friend',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: TColors.white),
              ),
              icon: Icon(
                Icons.person_add,
                color: TColors.white,
              ),
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwItems),
          CircleAvatar(
            backgroundColor: TColors.primary,
            child: IconButton(
              onPressed: () => copyToClipboard(context),
              icon: Icon(Icons.copy, color: TColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
