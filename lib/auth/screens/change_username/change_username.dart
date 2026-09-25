import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/profile/controller/update_username.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/validators/validation.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsername());

    return Scaffold(
      appBar: TAppBar(
        title: Text('Edit Username'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Form(
          key: controller.updateUserNameForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.userName,
                validator: (value) =>
                    TValidator.validateEmptyText('User Name', value),
                expands: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: 'Enter your Username',
                ),
              ),
              SizedBox(height: TSizes.xs),
              Text(
                'Enter within 20 characters',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(fontWeightDelta: 1),
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: Text('Comfirm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
