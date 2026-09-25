import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/utility/controller/get_meters_controller.dart';
import 'package:wilford/screens/utility/model/meter_model.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';

void showMeterBottomSheet({
  required BuildContext context,
  required Function(GetMeter) onSelect,
}) {
  final controller = Get.find<GetMetersController>();

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

        if (controller.meters.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: Text("No meters available.")),
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
            itemCount: controller.meters.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final meter = controller.meters[index];
              return ListTile(
                leading: ClipRRect(
                  child: TCirculerImage(
                    width: 45,
                    height: 45,
                    padding: 0,
                    image: TImages.receiptLogo, //meter.image.toString(),
                  ),
                ),
                title: Text(meter.name),
                onTap: () {
                  onSelect(meter);
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
