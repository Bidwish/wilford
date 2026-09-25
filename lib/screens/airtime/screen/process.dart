import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilford/commom/widgets/amount/amoutn.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/pin/pin_input.dart';
import 'package:wilford/commom/widgets/processScreen/process_butom_container.dart';
import 'package:wilford/commom/widgets/processScreen/rowcontet.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import '../controller/airtime_controller.dart';

class ProcessAirtime extends StatelessWidget {
  const ProcessAirtime(
      {super.key,
      required this.amount,
      required this.pts,
      required this.phone,
      required this.network,
      required this.networkImage});

  void showBeautifulPinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => BeautifulPinInput(
        onCompleted: (enteredPin) {
          submitAirTime(
            pin: enteredPin,
            amount: amount,
            network: network,
            phone: phone,
          );
        },
      ),
    );
  }

  final String amount, pts, phone, network, networkImage;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("Airtime"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bonus to Earn:',
                            style:
                                Theme.of(context).textTheme.labelLarge!.apply(
                                      color: isDark
                                          ? TColors.white
                                          : TColors.darkerGrey,
                                    ),
                          ),
                          Text(
                            pts,
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDark ? TColors.white : TColors.darkerGrey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              ProcessBottomContainerWithImage(
                provider: 'AirTime',
                number: phone,
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
