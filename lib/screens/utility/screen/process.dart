import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/amount/amoutn.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/pin/pin_input.dart';
import 'package:wilford/commom/widgets/processScreen/process_butom_container.dart';
import 'package:wilford/commom/widgets/processScreen/rowcontet.dart';
import 'package:wilford/screens/utility/controller/submit_controller.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';

import '../../../commom/widgets/appber/appber.dart';

class UtilityBillProcessScreen extends StatelessWidget {
  const UtilityBillProcessScreen({
    super.key,
    required this.amount,
    required this.meterName,
    required this.meterNumber,
    required this.meterType,
    required this.provider,
    required this.code,
    required this.image,
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
          submitUtility(
            pin: enteredPin,
            amount: amount,
            provider: provider,
            costomerName: meterName,
            meterNumber: meterNumber,
            meterType: meterType,
            code: code,
          );
        },
      ),
    );
  }

  final String amount, meterName, meterNumber, meterType, provider, image, code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Electricity"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              // --- Amount ---
              AmountWidget(amount: amount),

              const SizedBox(height: TSizes.spaceBtwSections),
              TContainer(
                chlid: Padding(
                  padding: EdgeInsets.all(TSizes.md),
                  child: Column(
                    children: [
                      ProcessRowContent(
                        title: 'Amount:',
                        subtitle:
                            formatCurrency(double.tryParse(amount) ?? 0.0),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Meter Name:',
                        subtitle: meterName,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Meter Type:',
                        subtitle: meterType,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Bouns to Earn:',
                        subtitle: '+£0.00 cashback',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProcessBottomContainerWithImage(
                provider: provider,
                number: meterNumber,
                image: image,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Submit Button --
              Center(
                child: SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => showBeautifulPinSheet(context),
                    child: Text('Confirm'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
