import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/screens/to_bank/mordel/bank_model.dart';
import 'package:wilford/screens/to_bank/widget/rate_monitor.dart';
import 'package:wilford/screens/to_bank/widget/recent_transfer_account.dart';
import 'package:wilford/screens/to_bank/widget/transfar_form.dart';
import 'package:wilford/utils/constants/sizes.dart';

class ToBankScreen extends StatelessWidget {
  final ValueNotifier<GetBank?> selectedBank = ValueNotifier<GetBank?>(null);

  ToBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Transfer To Bank"),
        showBackArrow: true,
        leadingOnPressed: () => Get.offAllNamed(AppRoutes.home),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              TContainer(
                chlid: Padding(
                  padding: const EdgeInsets.all(TSizes.sm * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recipient Account',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(fontWeightDelta: 2, fontSizeFactor: 1)),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      // -- Account Number --
                      BankTransfarForm()
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),

              // -- Rate Monitor --
              RateMonitor(),
              const SizedBox(height: TSizes.spaceBtwSections / 2),

              // -- Recents Transfer Account --
              RecentsTransferAccount(),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
