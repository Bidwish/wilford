import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/screens/exam/waec/screen/process_waec.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class WaecFormFiled extends StatelessWidget {
  const WaecFormFiled({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service Type',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(fontWeightDelta: 2, color: TColors.darkerGrey)),
            const SizedBox(height: TSizes.xs),
            TextFormField(
              style: TextStyle(fontSize: 16),
              readOnly: true,
              initialValue: 'WASSCE/GCE', // Default value
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
                contentPadding: EdgeInsets.all(TSizes.md),
                hintText: 'Typre of service',
                hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.gray)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.primary)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text('Phone Number',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(fontWeightDelta: 2, color: TColors.darkerGrey)),
            const SizedBox(height: TSizes.xs),
            TextFormField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
                contentPadding: EdgeInsets.all(TSizes.md),
                hintText: 'Eneer candidate\'s phone number',
                hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.gray)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.primary)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text('Amount',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(fontWeightDelta: 2, color: TColors.darkerGrey)),
            const SizedBox(height: TSizes.xs),
            TextFormField(
              style: TextStyle(fontSize: 16),
              readOnly: true,
              initialValue: '₦900.00', // Default value
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
                contentPadding: EdgeInsets.all(TSizes.md),
                hintText: 'Amount',
                hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.gray)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.primary)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text('Quantity',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(fontWeightDelta: 2, color: TColors.darkerGrey)),
            const SizedBox(height: TSizes.xs),
            TextFormField(
              style: TextStyle(fontSize: 16),
              initialValue: '1', // Default value
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? TColors.darkerGrey : TColors.lightGrey,
                contentPadding: EdgeInsets.all(TSizes.md),
                hintText: 'Enter quantity your want to purchase',
                hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.gray)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                    borderSide: BorderSide(color: TColors.primary)),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Center(
              child: SizedBox(
                width: 170,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const WaecProcessScreen(
                        amount: '900.00',
                        serivce: 'WASSCE/GCE',
                        phoneNumber: '07025744517',
                        quantity: '1',
                      )),
                  child: Text('Get Detils'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
