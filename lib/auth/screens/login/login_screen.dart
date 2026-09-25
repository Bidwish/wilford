import 'package:flutter/material.dart';
import 'package:wilford/auth/screens/login/widget/login_form.dart';
import 'package:wilford/commom/styles/spacing_styles.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingwithAppBar,
          child: Column(
            children: [
              /// Logo
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 70,
                    image: AssetImage(TImages.logo),
                  ),
                  const SizedBox(height: 20),
                  Text(TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.sm),
                  Text(TTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),

              /// Form
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
