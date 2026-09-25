import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/security/pin/screens/change_pin.dart';
import 'package:wilford/screens/settings/screens/security/pin/screens/reset_pin.dart';
import 'package:wilford/screens/settings/screens/security/pin/screens/set_pin.dart';
import 'package:wilford/screens/settings/screens/security/pin/widget/menu_container.dart';
import 'package:wilford/utils/constants/sizes.dart';

import 'controller/set/check_pin.dart';

class ManagePinScreen extends StatefulWidget {
  const ManagePinScreen({super.key});

  @override
  State<ManagePinScreen> createState() => _ManagePinScreenState();
}

class _ManagePinScreenState extends State<ManagePinScreen> {
  final box = GetStorage();
  final hasPin = false.obs; // reactive boolean

  @override
  void initState() {
    super.initState();
    _loadHasPin();
  }

  /// Read has_pin value from local storage
  void _loadHasPin() {
    final storedValue = box.read('has_pin');
    hasPin.value = storedValue is bool ? storedValue : false;
  }

  /// Refresh when returning from Set/Reset screen
  Future<void> _refreshOnReturn(Future<void> Function() navigate) async {
    await navigate();
    _loadHasPin(); // reload after returning
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckPinController());
    controller.checkPin();

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Manage Security Pin"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: Obx(() {
        final bool userHasPin = hasPin.value;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Show Set Pin only if user has no pin
                if (!userHasPin)
                  TManagePinMenu(
                    text: 'Set New Pin',
                    onTap: () => _refreshOnReturn(
                      () => Get.to(() => const TSetNewPin())!,
                    ),
                  ),

                /// Show these if user already has a pin
                if (userHasPin) ...[
                  TManagePinMenu(
                    text: 'Change Transaction Pin',
                    onTap: () => _refreshOnReturn(
                      () => Get.to(() => const TChangePin())!,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TManagePinMenu(
                    text: 'Reset Transaction Pin',
                    onTap: () => _refreshOnReturn(
                      () => Get.to(() => const TResetPin())!,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
