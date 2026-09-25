import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class CableBer extends StatefulWidget {
  final String provider;
  final Function(String name, String image) onChanged;

  const CableBer({
    super.key,
    required this.provider,
    required this.onChanged,
  });

  @override
  State<CableBer> createState() => _CableBerState();
}

class _CableBerState extends State<CableBer> {
  late String selectedProvider;

  final List<Map<String, String>> providers = [
    {'name': 'dstv', 'image': TImages.receiptLogo},
    {'name': 'gotv', 'image': TImages.receiptLogo},
    {'name': 'startimes', 'image': TImages.receiptLogo},
    {'name': 'showmax', 'image': TImages.receiptLogo},
  ];

  @override
  void initState() {
    super.initState();
    selectedProvider = widget.provider;
  }

  void selecteProvider(String name, String image) {
    setState(() {
      selectedProvider = name;
    });
    widget.onChanged(name, image); // ✅ Send selected name and image back
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: providers.map((provider) {
        bool isSelected = selectedProvider == provider['name'];

        return GestureDetector(
          onTap: () => selecteProvider(provider['name']!, provider['image']!),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? TColors.primary : TColors.grey,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(provider['image']!),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                provider['name']!.toUpperCase(),
                style: TextStyle(
                  color: isSelected
                      ? TColors.primary
                      : isDark
                          ? TColors.white
                          : TColors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
