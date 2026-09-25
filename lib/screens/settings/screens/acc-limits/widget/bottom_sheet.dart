import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/screens/settings/screens/acc-limits/widget/date_input.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import '../controller/account_upgrade.dart';

class TUpgradeButtomSheet extends StatelessWidget {
  TUpgradeButtomSheet({super.key});

  final controller = Get.put(UpgradeController());

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? TColors.black : TColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Upgrade Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Get.back,
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
            SizedBox(height: 10),
            DateOfBirthPicker(
              controller: controller.dobController,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            DropdownButtonFormField<String>(
              initialValue: controller.gender.value.isNotEmpty
                  ? controller.gender.value
                  : null,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: ['Male', 'Female']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => controller.gender.value = value!,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitUpgradeForm,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Upgrade'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
