import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/amount/amoutn.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/pin/pin_input.dart';
import 'package:wilford/commom/widgets/processScreen/process_butom_container.dart';
import 'package:wilford/commom/widgets/processScreen/rowcontet.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import '../controller/gift_card_controller.dart';

class GiftProcessScreen extends StatelessWidget {
  const GiftProcessScreen({
    super.key,
  });

  // --- Pin ---
  void showBeautifulPinSheet(BuildContext context, String amount, String email,
      String senderName, String message) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => BeautifulPinInput(
        onCompleted: (enteredPin) {
          submitGiftCard(
            pin: enteredPin,
            amount: amount,
            email: email,
            message: message,
            senderName: senderName,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments
    final args = Get.arguments;

    final amount = args['amount'];
    final email = args['email'];
    final senderName = args['name'];
    final message = args['message'];

    return Scaffold(
      appBar: TAppBar(
        title: Text("Process Gift Card"),
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
                      subtitle: formatCurrency(double.tryParse(amount) ?? 0.0),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    ProcessRowContent(
                      title: 'Fee:',
                      subtitle: '10',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    ProcessRowContent(
                      title: 'Sender Name:',
                      subtitle: senderName,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    ProcessRowContent(
                      title: 'To:',
                      subtitle: email,
                    ),
                  ],
                ),
              )),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProcessBottomContainerWithImage(
                provider: 'Wilford',
                number: 'Gift Card',
                image: TImages.logo,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Submit Button --
              Center(
                child: SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => showBeautifulPinSheet(
                        context, amount, email, senderName, message),
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
