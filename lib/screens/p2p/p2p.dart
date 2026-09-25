import 'package:flutter/material.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import '../../utils/constants/sizes.dart';

// ignore: camel_case_types
class p2pScreen extends StatelessWidget {
  const p2pScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text('P2P'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Item in Progress',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: isDark ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
