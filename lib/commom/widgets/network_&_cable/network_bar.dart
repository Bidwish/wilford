import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

class NetWorkBer extends StatefulWidget {
  final String network;
  final Function(String name, String image) onChanged;

  const NetWorkBer({super.key, required this.network, required this.onChanged});

  @override
  State<NetWorkBer> createState() => _NetWorkBerState();
}

class _NetWorkBerState extends State<NetWorkBer> {
  late String selectedNetwork;

  final List<Map<String, String>> networks = [
    {'name': 'mtn', 'image': TImages.receiptLogo},
    {'name': 'glo', 'image': TImages.receiptLogo},
    {'name': 'airtel', 'image': TImages.receiptLogo},
    {'name': '9mobile', 'image': TImages.receiptLogo},
  ];

  @override
  void initState() {
    super.initState();
    selectedNetwork = widget.network;
  }

  void selectNetwork(String name, String image) {
    setState(() {
      selectedNetwork = name;
    });
    widget.onChanged(name, image); // Send selected name and image back
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: networks.map((network) {
        bool isSelected = selectedNetwork == network['name'];

        return GestureDetector(
          onTap: () => selectNetwork(network['name']!, network['image']!),
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
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(network['image']!),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                network['name']!.toUpperCase(),
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
