import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/pin/pin_input.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/to_user/controller/submit_controller.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ProcessToUserScreen extends StatelessWidget {
  ProcessToUserScreen({
    super.key,
    required this.accountNumber,
    required this.bankCode,
    required this.accountName,
    required this.bankImage,
    required this.bankName,
  });

  void showBeautifulPinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => BeautifulPinInput(
        onCompleted: (enteredPin) {
          // Call your submit function here
          submitUserTransfer(
              pin: enteredPin,
              amount: amount.text,
              remark: remark.text,
              bankCode: bankCode,
              accountNumber: accountNumber,
              accountName: accountName,
              bankName: bankName);
        },
      ),
    );
  }

  final amount = TextEditingController();
  final remark = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String accountNumber, bankImage, bankCode, accountName, bankName;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("Transfer To Wilford Account"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: isDark ? TColors.darkGrey : TColors.grey,
                    ),
                    color: isDark ? TColors.darkerGrey : TColors.lightGrey,
                  ),
                  child: TCirculerImage(
                    isNetworkImage: true,
                    image: bankImage,
                    width: 80,
                    height: 80,
                    padding: 0,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.lg),
              Text(accountName,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: TSizes.sm / 3),
              Text(accountNumber,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: TColors.darkGrey)),
              const SizedBox(height: TSizes.spaceBtwSections),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Amount --
                    Text('Amount',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(fontWeightDelta: 2)),
                    const SizedBox(height: TSizes.xs),
                    TextFormField(
                      style: TextStyle(fontSize: 16),
                      controller: amount,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Amount is required';
                        } else if (double.tryParse(value) == null) {
                          return 'Please enter a valid amount';
                        } else if (double.parse(value) < 50 ||
                            double.parse(value) > 50000) {
                          return 'Amount must be between 50 and 50,000';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark ? TColors.darkerGrey : TColors.lightGrey,
                        contentPadding: EdgeInsets.all(TSizes.md),
                        hintText: '50.00 - 50,000.00',
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

                    // -- Remark input --
                    Text('Remark',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(fontWeightDelta: 2)),
                    const SizedBox(height: TSizes.xs),
                    TextField(
                      style: TextStyle(fontSize: 16),
                      controller: remark,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark ? TColors.darkerGrey : TColors.lightGrey,
                        contentPadding: EdgeInsets.all(TSizes.md),
                        hintText: 'What\'s this for? (Optinal)',
                        hintStyle:
                            TextStyle(color: TColors.darkGrey, fontSize: 15),
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
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Submit Button
                    Center(
                      child: SizedBox(
                        width: 170,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            showBeautifulPinSheet(context);
                          },
                          child: Text('Confirm'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
