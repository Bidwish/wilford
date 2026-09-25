import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/amount/amoutn.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/pin/pin_input.dart';
import 'package:wilford/commom/widgets/processScreen/process_butom_container.dart';
import 'package:wilford/commom/widgets/processScreen/rowcontet.dart';
import 'package:wilford/screens/data/controller/submit_data_controller.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ProcessData extends StatelessWidget {
  const ProcessData({
    super.key,
    required this.amount,
    required this.pts,
    required this.time,
    required this.phoneNumber,
    required this.network,
    required this.networkImage,
    required this.code,
    required this.name,
  });

  void showBeautifulPinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => BeautifulPinInput(
        onCompleted: (enteredPin) {
          submitData(
            pin: enteredPin,
            amount: amount,
            network: network,
            phoneNumber: phoneNumber,
            code: code,
            pts: pts,
            name: ' $name ($time)',
          );
        },
      ),
    );
  }

  final String amount,
      pts,
      time,
      phoneNumber,
      network,
      networkImage,
      code,
      name;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("Mobile Data"),
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
                        title: 'Data Bundle:',
                        subtitle: '$name ($time)',
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bonus to Earn:',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(
                                    color: isDark
                                        ? TColors.white
                                        : TColors.darkerGrey),
                          ),
                          Text(
                            '$pts cashback',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: TColors.success),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              ProcessBottomContainerWithImage(
                provider: 'Mobile Data',
                number: phoneNumber,
                image: networkImage,
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
