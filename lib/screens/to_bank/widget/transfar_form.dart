import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/meter_&_bank_sheet/bank_sheet.dart';
import 'package:wilford/commom/widgets/profile_Image/circuler_image.dart';
import 'package:wilford/screens/to_bank/controller/get_bank_controller.dart';
import 'package:wilford/screens/to_bank/controller/get_recent_trasaction_account_controller.dart';
import 'package:wilford/screens/to_bank/controller/verifiy_account_controller.dart';
import 'package:wilford/screens/to_bank/mordel/bank_model.dart';
import 'package:wilford/screens/to_bank/screen/bank_transfer_process.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';

class BankTransfarForm extends StatefulWidget {
  const BankTransfarForm({super.key});

  @override
  State<BankTransfarForm> createState() => _BankTransfarFormState();
}

class _BankTransfarFormState extends State<BankTransfarForm> {
  final selectedBank = ValueNotifier<GetBank?>(null);
  final bankListController = Get.put(GetBankController());
  final recentController = Get.put(GetRecentTrasactionAccountController());
  final controller = Get.put(VerifiyAccountController());

  @override
  void initState() {
    super.initState();
    bankListController.fatchBank();
    recentController.fatchAccounts();

    controller.accNumber.addListener(_maybeVerifyAccount);
    selectedBank.addListener(_maybeVerifyAccount);
  }

  void _maybeVerifyAccount() {
    final account = controller.accNumber.text.trim();
    final bank = selectedBank.value;

    if (account.length == 10 && bank != null) {
      controller.verifyAccount(
        accountNumber: account,
        bankCode: bank.validity,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.accountDetailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Account Number Field
          TextFormField(
            controller: controller.accNumber,
            keyboardType: TextInputType.number,
            maxLength: 10,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              hintText: 'Enter 10 digit Account Number',
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColors.darkGrey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColors.primary),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Bank Selector
          ValueListenableBuilder<GetBank?>(
            valueListenable: selectedBank,
            builder: (context, bank, _) {
              return GestureDetector(
                onTap: () {
                  showBankBottomSheet(
                    context: context,
                    onSelect: (selected) {
                      selectedBank.value = selected;
                    },
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.5)),
                  ),
                  child: Row(
                    children: [
                      if (bank != null) ...[
                        TCirculerImage(
                          width: 45,
                          height: 45,
                          padding: 0,
                          isNetworkImage: false,
                          image: TImages.receiptLogo, // bank.image.toString(),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            bank.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ] else ...[
                        const Expanded(
                          child: Text(
                            "Select Bank",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: TColors.darkGrey,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: TSizes.sm),

          /// Status Message
          Obx(() {
            if (controller.isVerifying.value) {
              return const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.green)),
                    SizedBox(width: 8),
                    Text('Verifying...', style: TextStyle(fontSize: 13)),
                  ],
                ),
              );
            }

            if (controller.errorText.value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(95),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        controller.errorText.value,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (controller.accountName.value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(95),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Color.fromARGB(255, 26, 125, 30)),
                      const SizedBox(width: 8),
                      Text(
                        controller.accountName.value,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 26, 125, 30),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          }),

          const SizedBox(height: TSizes.spaceBtwItems),

          /// Next Button
          Obx(() {
            if (controller.accountName.value.isNotEmpty) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add submission logic here if needed
                    Get.to(() => BankTransferProcessScreen(
                          accountNumber: controller.accNumber.text.trim(),
                          bankCode: selectedBank.value!.validity,
                          bankImage: selectedBank.value!.image.toString(),
                          bankName: selectedBank.value!.name,
                          accountName: controller.accountName.value,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Next'),
                ),
              );
            } else {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: null, // <- This disables the button completely
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: TColors.primary.withAlpha(95),
                    disabledBackgroundColor: TColors.primary.withAlpha(95),
                    disabledForegroundColor: Colors.white.withAlpha(95),
                  ),
                  child: const Text('Next'),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
