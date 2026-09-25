import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/exam/waec/widget/formfiled.dart';
import 'package:wilford/screens/exam/widget/image_with_heading.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class WaecScreen extends StatelessWidget {
  const WaecScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);


    return Scaffold(
      appBar: TAppBar(
        title: Text("WAEC"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopExamScreenContainer(
              title: 'WAEC',
              subtitle: 'WAEC Result checker PIN',
              imageUrl: TImages.receiptLogo,
            ),
            Divider(
              thickness: 5,
              color: isDark ? TColors.darkerGrey : TColors.grey,
            ),

            // Form Field
            const WaecFormFiled(),
          ],
        ),
      ),
    );
  }
}
