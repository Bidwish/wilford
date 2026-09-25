import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class BeautifulPinInput extends StatefulWidget {
  final Function(String)? onCompleted; // Added callback here!

  const BeautifulPinInput({super.key, this.onCompleted});

  @override
  State<BeautifulPinInput> createState() => _BeautifulPinInputState();
}

class _BeautifulPinInputState extends State<BeautifulPinInput> {
  List<String> pin = [];

  void onKeyTap(String value) {
    if (pin.length < 4) {
      setState(() => pin.add(value));

      if (pin.length == 4) {
        final enteredPin = pin.join();
        debugPrint("Entered PIN: $enteredPin");

        // Call the provided callback if it's not null
        if (widget.onCompleted != null) {
          widget.onCompleted!(enteredPin);
        }

        // Close the bottom sheet after short delay
        Future.delayed(const Duration(milliseconds: 200), () {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        });
      }
    }
  }

  void onDelete() {
    if (pin.isNotEmpty) {
      setState(() => pin.removeLast());
    }
  }

  Widget buildPinBox({required bool filled, bool isFocused = false}) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocused ? TColors.primary : TColors.darkGrey.withAlpha(90),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(TSizes.cardRadiusXs),
      ),
      child: Center(
        child: Text(
          filled ? '*' : '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? TColors.gray : TColors.darkerGrey,
          ),
        ),
      ),
    );
  }

  Widget buildKey(String text) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => onKeyTap(text),
      child: Container(
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        height: 47,
        decoration: BoxDecoration(
          color: isDark ? TColors.black : TColors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusXs),
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.apply(
                  fontSizeFactor: 1,
                  color: isDark ? TColors.white : TColors.black,
                  fontWeightDelta: 2,
                ),
          ),
        ),
      ),
    );
  }

  Widget buildDeleteKey() {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onDelete,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 100,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
          shape: BoxShape.rectangle,
        ),
        child: Icon(
          Icons.backspace,
          color: isDark ? TColors.white : TColors.black,
          size: TSizes.iconSm,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? TColors.darkContainer : TColors.lightContainer,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark ? TColors.black : TColors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(TSizes.sm),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.cancel_outlined,
                              color: TColors.darkGrey),
                        ),
                        const Expanded(
                          child: Text(
                            'Enter Transaction PIN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(4,
                          (index) => buildPinBox(filled: index < pin.length)),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    'Please introduce the 4-digit PIN',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(fontWeightDelta: 2, color: TColors.darkGrey),
                  ),
                  const SizedBox(height: TSizes.sm),
                ],
              ),
            ),
            // --- Pin KeyPad ---
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.sm, horizontal: TSizes.xs),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: buildKey('1')),
                      Expanded(child: buildKey('2')),
                      Expanded(child: buildKey('3')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: buildKey('4')),
                      Expanded(child: buildKey('5')),
                      Expanded(child: buildKey('6')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: buildKey('7')),
                      Expanded(child: buildKey('8')),
                      Expanded(child: buildKey('9')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                      Expanded(child: buildKey('0')),
                      Expanded(child: buildDeleteKey()),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
