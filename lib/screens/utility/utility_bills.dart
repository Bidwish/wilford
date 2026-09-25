import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/meter_&_bank_sheet/electric_meter_sheet.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/commom/widgets/smartcard_&_uic/smartcard_uic_input.dart';
import 'package:wilford/screens/airtime/widget/input_amount.dart';
import 'package:wilford/screens/utility/controller/get_meters_controller.dart';
import 'package:wilford/screens/utility/controller/verify_meter_controller.dart';
import 'package:wilford/screens/utility/model/meter_model.dart';
import 'package:wilford/screens/utility/widget/amount_container.dart';
import 'package:wilford/screens/utility/widget/meter_type.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';
import 'screen/process.dart';

class UtilityScreen extends StatefulWidget {
  const UtilityScreen({super.key});

  @override
  State<UtilityScreen> createState() => _UtilityScreenState();
}

class _UtilityScreenState extends State<UtilityScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController meterController = TextEditingController();
  final selectedMeter = ValueNotifier<GetMeter?>(null);
  final verifyMeterController = Get.put(VerifyMeterController());
  final meterListController = Get.put(GetMetersController());
  String _selectedMeterType = 'Prepaid';
  String selectedMeterImage = TImages.user;
  String amountErrorMessage = '';
  String meterErrorMessage = '';
  String meterNumErrorMessage = '';

  @override
  void initState() {
    super.initState();
    meterListController.fatchMeters();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Electricity"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Form(
            child: Column(
              children: [
                /// --- Meter Selection ---
                TContainer(
                  chlid: Padding(
                    padding: const EdgeInsets.all(TSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Meter',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                                fontWeightDelta: 2,
                              ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        ValueListenableBuilder<GetMeter?>(
                          valueListenable: selectedMeter,
                          builder: (context, meter, _) {
                            return GestureDetector(
                              onTap: () {
                                showMeterBottomSheet(
                                  context: context,
                                  onSelect: (selected) =>
                                      selectedMeter.value = selected,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    if (meter != null) ...[
                                      ClipRRect(
                                        child: TCirculerImage(
                                          width: 50,
                                          height: 50,
                                          padding: 0,
                                          image: TImages
                                              .receiptLogo, //meter.image.toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          meter.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ] else
                                      Expanded(
                                        child: const Text("Select Meter",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey)),
                                      ),
                                    const Icon(Icons.keyboard_arrow_right_sharp,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        if (meterErrorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              meterErrorMessage,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 13),
                            ),
                          ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        /// --- Meter Type Display ---
                        MeterTypeWidget(
                          selectedType: _selectedMeterType,
                          onChanged: (type) {
                            setState(() {
                              _selectedMeterType = type;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections / 2),

                /// --- Meter Number ---
                Obx(
                  () => UicAndMeterInPut(
                    title: 'Meter Number',
                    hinttext: 'Enter your Meter Number',
                    controller: verifyMeterController.meterNumController,
                    statusText: verifyMeterController.statusText.value,
                    statusColor: verifyMeterController.statusColor.value,
                    isVerifying: verifyMeterController.isVerifying.value,
                    onVerify: () {
                      verifyMeterController.selectedMeter.value =
                          selectedMeter.value?.validity ?? '';
                      verifyMeterController.meterType.value =
                          _selectedMeterType;
                      verifyMeterController.verifyMeter();
                    },
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwSections / 2),

                /// --- Amount Grid ---
                TContainer(
                  chlid: Padding(
                    padding: const EdgeInsets.all(TSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select Amount',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(fontWeightDelta: 3)),

                        const SizedBox(height: TSizes.md),

                        /// --- Grid of preset amounts ---
                        GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: TSizes.spaceBtwItems,
                          crossAxisSpacing: TSizes.spaceBtwItems,
                          shrinkWrap: true,
                          childAspectRatio: 1.3,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            for (final amount in [
                              '2000',
                              '3000',
                              '5000',
                              '10000',
                              '20000',
                              '30000'
                            ])
                              UtilityAmountSection(
                                isDark: isDark,
                                amount: formatCurrency(
                                    double.tryParse(amount) ?? 0.0),
                                pay: formatCurrency(
                                    double.tryParse(amount) ?? 0.0),
                                onTap: () {
                                  final meter = selectedMeter.value;
                                  final customer =
                                      verifyMeterController.customerName;
                                  final meterNum = verifyMeterController
                                      .meterNumController.text;
                                  final meterName =
                                      selectedMeter.value?.name ?? '';

                                  bool hasError = false;

                                  if (meterName.isEmpty) {
                                    setState(() {
                                      meterErrorMessage =
                                          'Please Select Meter.';
                                    });
                                    hasError = true;
                                  } else {
                                    setState(() {
                                      meterErrorMessage = '';
                                    });
                                  }

                                  if (meterNum.isEmpty) {
                                    verifyMeterController.statusText.value =
                                        "Meter number is required";
                                    verifyMeterController.statusColor.value =
                                        Colors.red;
                                    return;
                                  }

                                  if (customer.isEmpty) {
                                    verifyMeterController.statusText.value =
                                        "Please verify Meter first";
                                    verifyMeterController.statusColor.value =
                                        Colors.red;
                                    return;
                                  }

                                  if (meter == null || hasError) return;

                                  Get.to(() => UtilityBillProcessScreen(
                                        amount: amount,
                                        meterName:
                                            verifyMeterController.customerName,
                                        meterNumber: verifyMeterController
                                            .meterNumController.text,
                                        meterType: _selectedMeterType,
                                        provider: meter.name,
                                        code: meter.validity,
                                        image: selectedMeterImage,
                                      ));
                                },
                              ),
                          ],
                        ),

                        const SizedBox(height: TSizes.spaceBtwItems),

                        /// --- Custom Amount ---
                        InputAnountContainer(
                          hint: '₦1,000 - ₦50,000',
                          controller: amountController,
                          onPressed: () {
                            final amount = amountController.text;
                            final meter = selectedMeter.value;
                            final meterName = selectedMeter.value?.name ?? '';
                            final customer = verifyMeterController.customerName;
                            final meterNum =
                                verifyMeterController.meterNumController.text;
                            bool hasError = false;

                            if (meterName.isEmpty) {
                              setState(() {
                                meterErrorMessage = 'Please Select Meter.';
                              });
                              hasError = true;
                            } else {
                              setState(() {
                                meterErrorMessage = '';
                              });
                            }

                            if (meterNum.isEmpty) {
                              verifyMeterController.statusText.value =
                                  "Meter number is required";
                              verifyMeterController.statusColor.value =
                                  Colors.red;
                              return;
                            }

                            if (customer.isEmpty) {
                              verifyMeterController.statusText.value =
                                  "Please verify Meter first";
                              verifyMeterController.statusColor.value =
                                  Colors.red;
                              return;
                            }

                            // Validate amount
                            if (amount.isNotEmpty) {
                              final amountValue = double.tryParse(amount);
                              if (amountValue == null ||
                                  amountValue < 1000 ||
                                  amountValue > 50000) {
                                setState(() {
                                  amountErrorMessage =
                                      'Please enter a valid amount (₦1,000 - ₦50,000)';
                                });
                                hasError = true;
                              } else {
                                setState(() {
                                  amountErrorMessage = '';
                                });
                              }
                            } else if (amount.isEmpty) {
                              setState(() {
                                amountErrorMessage = 'Please enatr the amount';
                              });
                              hasError = true;
                            } else {
                              setState(() {
                                amountErrorMessage = '';
                              });
                            }

                            if (hasError) {
                              // 🚫 Stop here if there's any error
                              return;
                            }

                            if (meter == null) return;

                            Get.to(() {
                              UtilityBillProcessScreen(
                                amount: amountController.text,
                                code: meter.validity,
                                meterName: verifyMeterController.customerName,
                                meterNumber: verifyMeterController
                                    .meterNumController.text,
                                meterType: _selectedMeterType,
                                provider: meter.name,
                                image: meter.image.toString(),
                              );
                            });
                          },
                        ),
                        if (amountErrorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              amountErrorMessage,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 13),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
