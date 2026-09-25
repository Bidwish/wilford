import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/to_bank/controller/get_bank_controller.dart';
import 'package:wilford/screens/to_bank/mordel/bank_model.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';

void showBankBottomSheet({
  required BuildContext context,
  required Function(GetBank) onSelect,
}) {
  final controller = Get.find<GetBankController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(TSizes.borderRadiusLg),
      ),
    ),
    builder: (context) {
      return Obx(() {
        if (controller.isLoading.value) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.banks.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: Text("No Bank available.")),
          );
        }

        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.8,
          minChildSize: 0.3,
          initialChildSize: 0.5,
          builder: (context, scrollController) => ListView.separated(
            controller: scrollController,
            padding: const EdgeInsets.all(TSizes.md),
            itemCount: controller.banks.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final bank = controller.banks[index];
              return ListTile(
                leading: ClipRRect(
                  child: TCirculerImage(
                    width: 45,
                    height: 45,
                    padding: 0,
                    image: TImages.receiptLogo, // bank.image.toString(),
                  ),
                ),
                title: Text(bank.name),
                onTap: () {
                  onSelect(bank);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      });
    },
  );
}
