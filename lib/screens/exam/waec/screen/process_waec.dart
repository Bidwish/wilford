import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/amount/amoutn.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/pin/pin_input.dart';
import 'package:wilford/commom/widgets/processScreen/process_butom_container.dart';
import 'package:wilford/commom/widgets/processScreen/rowcontet.dart';
import 'package:wilford/utils/constants/sizes.dart';

class WaecProcessScreen extends StatelessWidget {
  const WaecProcessScreen({
    super.key,
    required this.amount,
    required this.phoneNumber,
    required this.quantity,
    required this.serivce,
  });

  void showBeautifulPinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => BeautifulPinInput(),
    );
  }

  final String amount, phoneNumber, quantity, serivce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("WAEC"),
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
                        subtitle: amount,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Quantity:',
                        subtitle: quantity,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Service Type:',
                        subtitle: serivce,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ProcessRowContent(
                        title: 'Mobile Number:',
                        subtitle: phoneNumber,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProcessBottomContainerWithImage(
                  provider: 'WAEC', number: 'Result checker PIN', image: '',),
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
