import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/exam/jamb/jamb.dart';
import 'package:wilford/screens/exam/waec/waec.dart';
import 'package:wilford/screens/exam/widget/list_itme.dart';
import 'package:wilford/screens/exam/widget/search_bar.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("School"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExamSearchBar(isDark: isDark),

            // ListView
            const SizedBox(height: TSizes.sm),
            ExamListViewWidget(
              onTap: () => Get.to(() => const JambScreen()),
              title: 'JAMB',
              subtitle: 'JAMB',
              imageUrl: TImages.receiptLogo,
            ),
            ExamListViewWidget(
              onTap: () => Get.to(() => const WaecScreen()),
              title: 'WAEC',
              subtitle: 'WAEC',
              imageUrl: TImages.receiptLogo,
            ),
          ],
        ),
      ),
    );
  }
}
