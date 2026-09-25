import 'package:flutter/material.dart';
import 'package:wilford/auth/screens/signUp/widgets/form_fields.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Logo
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(TTexts.signupTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Form
                  const SignupFormField(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
