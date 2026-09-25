import 'package:flutter/material.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/history/model/history_model.dart';
import 'package:wilford/screens/settings/screens/history/screen/widget/receipt.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import '../controller/recepit_share_controller.dart'; // optional if you use TSizes

class TShareReceiptScreen extends StatelessWidget {
  TShareReceiptScreen({super.key, required this.tx});

  final HistoryModel tx;

  final GlobalKey _receiptKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: const Text('Share Receipt'),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: RepaintBoundary(
            key: _receiptKey,
            child: Center(child: TReceipt(tx: tx)),
          ),
        ),
      ),

      /// --- Bottom Buttons (Share as Image or PDF) ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
        color: isDark ? TColors.textPrimary : TColors.lightContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () =>
                  RecepitShareController.shareReceiptAsImage(_receiptKey),
              child: Row(
                children: [
                  const Icon(
                    Icons.image,
                    size: TSizes.iconSm,
                    color: TColors.primary,
                  ),
                  const SizedBox(width: TSizes.sm),
                  const Text(
                    "Share as Image",
                    style: TextStyle(fontSize: 12, color: TColors.secondary),
                  ),
                ],
              ),
            ),
            Text('|', style: TextStyle(color: TColors.darkGrey)),
            GestureDetector(
              onTap: () =>
                  RecepitShareController.shareReceiptAsPDF(_receiptKey),
              child: Row(
                children: [
                  const Icon(
                    Icons.picture_as_pdf,
                    size: TSizes.iconSm,
                    color: TColors.primary,
                  ),
                  const SizedBox(width: TSizes.sm),
                  const Text(
                    "Share as PDF",
                    style: TextStyle(fontSize: 12, color: TColors.secondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
