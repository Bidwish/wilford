import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/amount/amoutn.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/pin/pin_input.dart';
import 'package:wilford/commom/widgets/processScreen/process_butom_container.dart';
import 'package:wilford/commom/widgets/processScreen/rowcontet.dart';
import 'package:wilford/screens/tv/controller/submit_controller.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';

class ProcessTv extends StatelessWidget {
  const ProcessTv({
    super.key,
    required this.title,
    required this.amount,
    required this.provider,
    required this.costomerName,
    required this.uic,
    required this.code,
    required this.providerImage,
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
          submitTv(
            pin: enteredPin,
            amount: amount,
            planName: title,
            code: code,
            provider: provider,
            costomerName: costomerName,
            uic: uic,
          );
        },
      ),
    );
  }

  final String title, amount, provider, costomerName, uic, code, providerImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("TV"),
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
                        title: 'Amount',
                        subtitle:
                            formatCurrency(double.tryParse(amount) ?? 0.0),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Account Name:',
                        subtitle: costomerName,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Subscription:',
                        subtitle: title,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Bonus to Earn:',
                        subtitle: '+£0.00 cashback',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProcessBottomContainerWithImage(
                provider: provider.toUpperCase(),
                number: uic,
                image: providerImage,
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
