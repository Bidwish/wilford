import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/validators/validation.dart';

import '../controller/input_function.dart';
import '../controller/redeem_controller.dart';

class TRedeemForm extends StatelessWidget {
  const TRedeemForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RedeemController());

    return Form(
      key: controller.redeemFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.cardCode,
            validator: (value) =>
                TValidator.validateEmptyText('Card Code', value),
            inputFormatters: [CardCodeFormatter()], // Add the formatter here
            decoration: InputDecoration(
              filled: true,
              fillColor: TColors.gray.withAlpha(70),
              contentPadding: EdgeInsets.all(TSizes.md),
              hintText: 'XXXX-XXXX-XXXX-XXXX',
              hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: BorderSide(color: TColors.gray, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                borderSide: BorderSide(color: TColors.primary, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: TSizes.defaultSpace),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.redeemCard(),
              child: Text(
                'Redeem',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: TColors.white, fontWeightDelta: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
