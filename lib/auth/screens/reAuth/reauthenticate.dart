import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/auth/controllers/reAuth/reAuthenticate_controller.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';
import 'package:wilford/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReauthenticateController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Phone Number
                TextFormField(
                  controller: controller.verifyPhone,
                  validator: (value) =>
                      TValidator.validateEmptyText('Phone Nnumber', value),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: TTexts.phoneNo,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Password
                Obx(
                  () => TextFormField(
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        TValidator.validateEmptyText('Password', value),
                    keyboardType: TextInputType.number,
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: TTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                /// Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.deleteUserAccount(),
                    child: Text('Authenticate'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
