import 'package:flutter/material.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/sizes.dart';

class TManagePinMenu extends StatelessWidget {
  const TManagePinMenu({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: TContainer(
          chlid: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: TSizes.spaceBtwInputFields, horizontal: TSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 1),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: TSizes.iconMd,
                )
              ],
            ),
          ),
        ));
  }
}
