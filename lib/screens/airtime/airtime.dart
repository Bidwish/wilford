import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/commom/widgets/network_&_cable/network_bar.dart';
import 'package:wilford/commom/widgets/user_phone_contaner/user_phone.dart';
import 'package:wilford/screens/airtime/screen/process.dart';
import 'package:wilford/screens/airtime/widget/amount.dart';
import 'package:wilford/screens/airtime/widget/input_amount.dart';
import 'package:wilford/utils/constants/sizes.dart';

class AirTimeScreen extends StatefulWidget {
  const AirTimeScreen({super.key});

  @override
  State<AirTimeScreen> createState() => _AirTimeScreenState();
}

class _AirTimeScreenState extends State<AirTimeScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedNetwork = '';
  String selectedNetworkImage = '';
  String phoneErrorMessage = '';
  String amountErrorMessage = '';
  String networkErrorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text("Airtime"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Form(
            child: Column(
              children: [
                // --- Network ---
                TContainer(
                  chlid: Padding(
                    padding: const EdgeInsets.all(TSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: NetWorkBer(
                            network: selectedNetwork,
                            onChanged: (name, image) {
                              setState(() {
                                selectedNetwork = name;
                                selectedNetworkImage = image;
                                networkErrorMessage =
                                    ''; // Clear the network error if user selects
                              });
                            },
                          ),
                        ),
                        if (networkErrorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              networkErrorMessage,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 13),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                // --- Phone Number ---
                UserPhoneNumber(
                  controller: phoneController,
                  onErrorChanged: (error) {
                    setState(() {
                      phoneErrorMessage = error;
                    });
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                // -- Top up --
                TContainer(
                    chlid: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Top Up',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(fontWeightDelta: 5, fontSizeFactor: 1)),
                      const SizedBox(height: TSizes.md),

                      // -- AirTime Amount Contaner --
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AirTimeAmount(
                              amount: '₦50',
                              payAmount: 'Pay ₦50',
                              pts: 'earn 0.5pts',
                              onTap: () {
                                final phoneText = phoneController.text.trim();
                                bool hasError = false;

                                // Validate phone number
                                if (phoneText.isEmpty) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else if (phoneText.length < 11) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    phoneErrorMessage = '';
                                  });
                                }

                                // Validate network
                                if (selectedNetwork.isEmpty) {
                                  setState(() {
                                    networkErrorMessage =
                                        'Please select a network';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    networkErrorMessage = '';
                                  });
                                }

                                if (hasError) {
                                  // 🚫 Stop here if there's any error
                                  return;
                                }

                                Get.to(
                                  () => ProcessAirtime(
                                    amount: '50', // Example
                                    pts: '₦0.5 cashback', // Example
                                    phone: phoneController.text.trim(),
                                    network: selectedNetwork,
                                    networkImage: selectedNetworkImage,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: AirTimeAmount(
                              amount: '₦100',
                              payAmount: 'Pay ₦100',
                              pts: 'earn 2pts',
                              onTap: () {
                                final phoneText = phoneController.text.trim();
                                bool hasError = false;

                                // Validate phone number
                                if (phoneText.isEmpty) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else if (phoneText.length < 11) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    phoneErrorMessage = '';
                                  });
                                }

                                // Validate network
                                if (selectedNetwork.isEmpty) {
                                  setState(() {
                                    networkErrorMessage =
                                        'Please select a network';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    networkErrorMessage = '';
                                  });
                                }

                                if (hasError) {
                                  // 🚫 Stop here if there's any error
                                  return;
                                }

                                Get.to(
                                  () => ProcessAirtime(
                                    amount: '100', // Example
                                    pts: '₦2 cashback', // Example
                                    phone: phoneController.text.trim(),
                                    network: selectedNetwork,
                                    networkImage: selectedNetworkImage,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: AirTimeAmount(
                              amount: '₦200',
                              payAmount: 'Pay ₦200',
                              pts: 'earn 4pts',
                              onTap: () {
                                final phoneText = phoneController.text.trim();
                                bool hasError = false;

                                // Validate phone number
                                if (phoneText.isEmpty) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else if (phoneText.length < 11) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    phoneErrorMessage = '';
                                  });
                                }

                                // Validate network
                                if (selectedNetwork.isEmpty) {
                                  setState(() {
                                    networkErrorMessage =
                                        'Please select a network';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    networkErrorMessage = '';
                                  });
                                }

                                if (hasError) {
                                  // 🚫 Stop here if there's any error
                                  return;
                                }

                                Get.to(
                                  () => ProcessAirtime(
                                    amount: '200', // Example
                                    pts: '₦4 cashback', // Example
                                    phone: phoneController.text.trim(),
                                    network: selectedNetwork,
                                    networkImage: selectedNetworkImage,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AirTimeAmount(
                              amount: '₦500',
                              payAmount: 'Pay ₦500',
                              pts: 'earn 5pts',
                              onTap: () {
                                final phoneText = phoneController.text.trim();
                                bool hasError = false;

                                // Validate phone number
                                if (phoneText.isEmpty) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else if (phoneText.length < 11) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    phoneErrorMessage = '';
                                  });
                                }

                                // Validate network
                                if (selectedNetwork.isEmpty) {
                                  setState(() {
                                    networkErrorMessage =
                                        'Please select a network';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    networkErrorMessage = '';
                                  });
                                }

                                if (hasError) {
                                  // 🚫 Stop here if there's any error
                                  return;
                                }

                                Get.to(
                                  () => ProcessAirtime(
                                    amount: '500', // Example
                                    pts: '₦5 cashback', // Example
                                    phone: phoneController.text.trim(),
                                    network: selectedNetwork,
                                    networkImage: selectedNetworkImage,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: AirTimeAmount(
                              amount: '₦1,000',
                              payAmount: 'Pay ₦1,000',
                              pts: 'earn 10pts',
                              onTap: () {
                                final phoneText = phoneController.text.trim();
                                bool hasError = false;

                                // Validate phone number
                                if (phoneText.isEmpty) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else if (phoneText.length < 11) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    phoneErrorMessage = '';
                                  });
                                }

                                // Validate network
                                if (selectedNetwork.isEmpty) {
                                  setState(() {
                                    networkErrorMessage =
                                        'Please select a network';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    networkErrorMessage = '';
                                  });
                                }

                                if (hasError) {
                                  // 🚫 Stop here if there's any error
                                  return;
                                }

                                Get.to(
                                  () => ProcessAirtime(
                                    amount: '1000', // Example
                                    pts: '₦10 cashback', // Example
                                    phone: phoneController.text.trim(),
                                    network: selectedNetwork,
                                    networkImage: selectedNetworkImage,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: AirTimeAmount(
                              amount: '₦2,000',
                              payAmount: 'Pay ₦2,000',
                              pts: 'earn 20pts',
                              onTap: () {
                                final phoneText = phoneController.text.trim();
                                bool hasError = false;

                                // Validate phone number
                                if (phoneText.isEmpty) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else if (phoneText.length < 11) {
                                  setState(() {
                                    phoneErrorMessage =
                                        'Please enter the correct phone number';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    phoneErrorMessage = '';
                                  });
                                }

                                // Validate network
                                if (selectedNetwork.isEmpty) {
                                  setState(() {
                                    networkErrorMessage =
                                        'Please select a network';
                                  });
                                  hasError = true;
                                } else {
                                  setState(() {
                                    networkErrorMessage = '';
                                  });
                                }

                                if (hasError) {
                                  // 🚫 Stop here if there's any error
                                  return;
                                }

                                Get.to(
                                  () => ProcessAirtime(
                                    amount: '2000', // Example
                                    pts: '₦20 cashback', // Example
                                    phone: phoneController.text.trim(),
                                    network: selectedNetwork,
                                    networkImage: selectedNetworkImage,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // -- Enter Amount --
                      InputAnountContainer(
                        controller: amountController,
                        hint: '50 - 50,000',
                        onPressed: () {
                          final phoneText = phoneController.text.trim();
                          final amountText = amountController.text.trim();
                          bool hasError = false;

                          // Validate phone number
                          if (phoneText.isEmpty) {
                            setState(() {
                              phoneErrorMessage =
                                  'Please enter the correct phone number';
                            });
                            hasError = true;
                          } else if (phoneText.length < 11) {
                            setState(() {
                              phoneErrorMessage =
                                  'Please enter the correct phone number';
                            });
                            hasError = true;
                          } else {
                            setState(() {
                              phoneErrorMessage = '';
                            });
                          }

                          // Validate network
                          if (selectedNetwork.isEmpty) {
                            setState(() {
                              networkErrorMessage = 'Please select a network';
                            });
                            hasError = true;
                          } else {
                            setState(() {
                              networkErrorMessage = '';
                            });
                          }

                          // Validate amount
                          if (amountText.isNotEmpty) {
                            final amountValue = double.tryParse(amountText);
                            if (amountValue == null ||
                                amountValue < 50 ||
                                amountValue > 50000) {
                              setState(() {
                                amountErrorMessage =
                                    'Please enter a valid amount (₦50 - ₦50,000)';
                              });
                              hasError = true;
                            } else {
                              setState(() {
                                amountErrorMessage = '';
                              });
                            }
                          } else if (amountText.isEmpty) {
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

                          Get.to(
                            () => ProcessAirtime(
                              amount: amountText,
                              pts:
                                  '₦${(double.parse(amountText) * 0.01).toStringAsFixed(2)} cashback',
                              phone: phoneController.text.trim(),
                              network: selectedNetwork,
                              networkImage: selectedNetworkImage,
                            ),
                          );
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
