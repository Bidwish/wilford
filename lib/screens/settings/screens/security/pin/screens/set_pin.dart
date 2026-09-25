import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import '../controller/set/set_pin_controller.dart';

class TSetNewPin extends StatelessWidget {
  const TSetNewPin({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SetPinController());

    return Scaffold(
      appBar: TAppBar(
        title: Text("Set Tranaction Pin"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.md),
          child: TContainer(
            chlid: Padding(
              padding: EdgeInsets.all(TSizes.md),
              child: Form(
                key: controller.setPinFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Pin',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      controller: controller.nPin,
                      validator: controller.validatePin,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? TColors.dark : TColors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                          borderSide:
                              BorderSide(color: TColors.primary, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Text(
                      'Re-Enter Pin',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      controller: controller.rPin,
                      validator: controller.validateReenterPin,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        filled: true,
                        fillColor: isDark ? TColors.dark : TColors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                          borderSide:
                              BorderSide(color: TColors.primary, width: 1.5),
                        ),
                      ),
                    ),

                    // --- Submit Button ---
                    const SizedBox(height: TSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.setPin(),
                        child: Text('Set'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
