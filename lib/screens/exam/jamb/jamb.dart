import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/exam/widget/image_with_heading.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class JambScreen extends StatelessWidget {
  const JambScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("JAMB"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopExamScreenContainer(
              title: 'JAMB',
              subtitle: 'JAMB pin vending',
              imageUrl: TImages.receiptLogo,
            ),
            Divider(
              thickness: 5,
              color: isDark ? TColors.darkerGrey : TColors.grey,
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service type',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            fontWeightDelta: 2, color: TColors.darkerGrey)),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      style: TextStyle(fontSize: 16),
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark ? TColors.darkerGrey : TColors.lightGrey,
                        contentPadding: EdgeInsets.all(TSizes.md),
                        hintText: 'Choose a service type',
                        hintStyle:
                            TextStyle(color: TColors.darkGrey, fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.gray)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.primary)),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Text('Profile Code',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            fontWeightDelta: 2, color: TColors.darkerGrey)),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark ? TColors.darkerGrey : TColors.lightGrey,
                        contentPadding: EdgeInsets.all(TSizes.md),
                        hintText: 'Enter candidate\'s confirmation code',
                        hintStyle:
                            TextStyle(color: TColors.darkGrey, fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.gray)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.primary)),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Text('Phone Number',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            fontWeightDelta: 2, color: TColors.darkerGrey)),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark ? TColors.darkerGrey : TColors.lightGrey,
                        contentPadding: EdgeInsets.all(TSizes.md),
                        hintText: 'Eneer candidate\'s phone number',
                        hintStyle:
                            TextStyle(color: TColors.darkGrey, fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.gray)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.primary)),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Text('Amount',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            fontWeightDelta: 2, color: TColors.darkerGrey)),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      style: TextStyle(fontSize: 16),
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark ? TColors.darkerGrey : TColors.lightGrey,
                        contentPadding: EdgeInsets.all(TSizes.md),
                        hintText: 'Amount',
                        hintStyle:
                            TextStyle(color: TColors.darkGrey, fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.gray)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                            borderSide: BorderSide(color: TColors.primary)),
                      ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    Text(
                      'Note: You can write the word "NIN" then space and add your 11 digit NIN number and send to 55019 or 66019 in this format (NIN 12345678901)',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.warning),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Center(
                      child: SizedBox(
                        width: 170,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Get Detils'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
