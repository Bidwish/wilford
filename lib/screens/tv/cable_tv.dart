import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/network_&_cable/cable.dart';
import 'package:wilford/commom/widgets/smartcard_&_uic/smartcard_uic_input.dart';
import 'package:wilford/screens/tv/controller/tv_plan_controller.dart';
import 'package:wilford/screens/tv/controller/verify_uic_controllet.dart';
import 'package:wilford/screens/tv/screen/process.dart';
import 'package:wilford/screens/tv/widget/tv_plan_container.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  final controller = Get.put(TvPlanController());
  final verifyUicController = Get.put(VerifyUicController());
  final ScrollController _scrollController = ScrollController();
  String selectedProviderImage = TImages.dstv;

  @override
  void initState() {
    super.initState();
    controller.fatchTvPlans();
    controller.selectedProvider.value = 'dstv';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text("TV"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: RefreshIndicator(
        color: TColors.primary,
        onRefresh: controller.fatchTvPlans,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Cable Providers
                  TContainer(
                    chlid: Padding(
                      padding: const EdgeInsets.all(TSizes.md),
                      child: Obx(() => CableBer(
                            provider: controller.selectedProvider.value,
                            onChanged: (name, image) {
                              controller.selectedProvider.value = name;
                              selectedProviderImage = image;
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          )),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// SmartCard Input with validation and loading spinner
                  Obx(() => UicAndMeterInPut(
                        title: 'SmartCard Number',
                        hinttext: 'Enter your SmartCard Number',
                        controller: verifyUicController.uicController,
                        statusText: verifyUicController.statusText.value,
                        statusColor: verifyUicController.statusColor.value,
                        isVerifying: verifyUicController.isVerifying.value,
                        onVerify: () {
                          verifyUicController.selectedProvider.value =
                              controller.selectedProvider.value;
                          verifyUicController.verifyUic();
                        },
                      )),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// TV Plans
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: TColors.primary,
                          ),
                        );
                      }

                      final plans = controller.tvPlans
                          .where((plan) =>
                              plan.provider.toLowerCase() ==
                              controller.selectedProvider.value.toLowerCase())
                          .toList();

                      if (plans.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Text('No Subscription Plan Found'),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: controller.fatchTvPlans,
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder()),
                                child: const Text('Refresh'),
                              ),
                            ],
                          ),
                        );
                      }

                      return TContainer(
                        chlid: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: TSizes.md,
                            horizontal: TSizes.md,
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: plans.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              final tvPlan = plans[index];

                              return TvSubscription(
                                title: tvPlan.name,
                                amount: tvPlan.amount,
                                onTap: () {
                                  final uic = verifyUicController
                                      .uicController.text
                                      .trim();
                                  final customer =
                                      verifyUicController.customerName;

                                  if (uic.isEmpty) {
                                    verifyUicController.statusText.value =
                                        "SmartCard number is required";
                                    verifyUicController.statusColor.value =
                                        Colors.red;
                                    return;
                                  }

                                  if (customer.isEmpty) {
                                    verifyUicController.statusText.value =
                                        "Please verify SmartCard first";
                                    verifyUicController.statusColor.value =
                                        Colors.red;
                                    return;
                                  }

                                  Get.to(
                                    () => ProcessTv(
                                      title: tvPlan.name,
                                      amount: tvPlan.amount,
                                      code: tvPlan.validity,
                                      provider:
                                          controller.selectedProvider.value,
                                      providerImage: selectedProviderImage,
                                      costomerName:
                                          verifyUicController.customerName,
                                      uic: verifyUicController
                                          .uicController.text,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
