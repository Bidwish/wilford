import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart'
    show TContainer;
import 'package:wilford/commom/widgets/network_&_cable/network_bar.dart';
import 'package:wilford/commom/widgets/user_phone_contaner/user_phone.dart';
import 'package:wilford/screens/data/screen/process.dart' show ProcessData;
import 'package:wilford/screens/data/widget/data_price_container.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import 'controller/data_controller.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final TextEditingController phoneController = TextEditingController();
  String selectedNetworkImage = TImages.mtn;
  String phoneErrorMessage = '';
  final controller = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    controller.fatchDataPlans();
    controller.selectedNetwork.value = 'mtn';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Mobile Data"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Form(
          child: Column(
            children: [
              /// --- Network Selection
              TContainer(
                chlid: Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Obx(
                    () => NetWorkBer(
                      network: controller.selectedNetwork.value,
                      onChanged: (name, image) {
                        controller.selectedNetwork.value = name;
                        controller.selectedType.value = '';
                        selectedNetworkImage = image;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// --- Phone Input
              UserPhoneNumber(
                controller: phoneController,
                onErrorChanged: (error) {
                  setState(() => phoneErrorMessage = error);
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// --- Type Filter
              Obx(
                () {
                  final types = controller.availableTypes;
                  if (types.isEmpty) return const SizedBox();

                  return Wrap(
                    spacing: 8,
                    children: [
                      for (final type in types)
                        FilterChip(
                          label: Text(type.capitalizeFirst ?? type),
                          selected: controller.selectedType.value == type,
                          onSelected: (_) =>
                              controller.selectedType.value = type,
                        ),
                      FilterChip(
                        label: const Text('Clear'),
                        selected: controller.selectedType.value.isEmpty,
                        onSelected: (_) => controller.selectedType.value = '',
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// --- Data Plans Grid --
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return TContainer(
                        chlid: Padding(
                          padding: const EdgeInsets.all(TSizes.md),
                          child: GridView.builder(
                            itemCount: 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 1.5),
                            itemBuilder: (_, __) => Shimmer.fromColors(
                              baseColor: isDark ? TColors.dark : TColors.white,
                              highlightColor:
                                  isDark ? TColors.darkerGrey : TColors.gray,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isDark ? TColors.dark : TColors.white,
                                  borderRadius: BorderRadius.circular(
                                      TSizes.cardRadiusSm),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    final filteredPlans = controller.filteredPlans;

                    if (filteredPlans.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No data plans found.'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: controller.fatchDataPlans,
                              child: const Text('Refresh'),
                            ),
                          ],
                        ),
                      );
                    }

                    return TContainer(
                      chlid: Padding(
                        padding: const EdgeInsets.all(TSizes.md),
                        child: GridView.builder(
                          itemCount: filteredPlans.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.758,
                          ),
                          itemBuilder: (context, index) {
                            final plan = filteredPlans[index];

                            return DataAmount(
                              amount: formatCurrency(
                                  double.tryParse(plan.amount) ?? 0.0),
                              pts: '${plan.pts} cashback',
                              name: plan.name,
                              time: plan.duration,
                              note: plan.note,
                              onTap: () {
                                if (phoneController.text.isEmpty) {
                                  phoneErrorMessage =
                                      'Please enter the correct phone number';
                                  return;
                                }

                                Get.to(
                                  () => ProcessData(
                                    code: plan.validity,
                                    name: plan.name,
                                    phoneNumber: phoneController.text,
                                    network: controller.selectedNetwork.value,
                                    networkImage: selectedNetworkImage,
                                    amount: plan.amount,
                                    pts: plan.pts,
                                    time: plan.duration,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
