import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/screens/settings/screens/security/phone/change_phone.dart'
    show TChangePhone;
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class ChangeNumberNotice extends StatelessWidget {
  const ChangeNumberNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final user = userController.user.value;

    final String phone = user?.phone ?? '';

    final maskedPhone = TPrivacyMasker.hidePhoneNumber(phone);

    return Scaffold(
      appBar: TAppBar(actions: [
        IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(height: 200, 'assets/icons/change_number.png'),
            const SizedBox(height: TSizes.spaceBtwSections / 3),
            Text(
              'Change Phone Number!',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'You may update your phone number. if you no longer use this number ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: maskedPhone,
                      style: TextStyle(
                        color: TColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' or have access to it.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Additional Information Container
            TContainer(
                chlid: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(TSizes.xs),
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(70),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone_disabled,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'After updating your phone number, the previous number will no longer grant access to this account.',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(TSizes.xs),
                        decoration: BoxDecoration(
                          color: TColors.amber.withAlpha(70),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.exposure_zero,
                          size: 20,
                          color: TColors.amber,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Your ${TTexts.appName} account number (10 digits) will be updated to match your new phone number. excluding this first zero.',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(TSizes.xs),
                        decoration: BoxDecoration(
                          color: TColors.success.withAlpha(70),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone_android,
                          size: 20,
                          color: TColors.success,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'The new phone will serve as:',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: TSizes.xl + TSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• Your login credential.',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '• Verification for payment.',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '• Other account related purposes.',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// Confirm Button

            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.off(() => const TChangePhone()),
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text('I Understand'),
        ),
      ),
    );
  }
}
