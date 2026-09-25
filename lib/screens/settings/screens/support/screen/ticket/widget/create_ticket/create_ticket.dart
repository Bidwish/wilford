import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/screens/settings/screens/support/screen/ticket/controller/submit_ticket_controller.dart';
import 'package:wilford/screens/settings/screens/support/screen/ticket/widget/create_ticket/widget/issue_buttom_sheet.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/validators/validation.dart';

class CreateTicket extends StatelessWidget {
  CreateTicket({super.key});

  final controller = Get.put<SubmitTicketController>(SubmitTicketController());

  final ValueNotifier<String> selectedTopic =
      ValueNotifier<String>('Please select the issue type');

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => TTopicBottomSheet(
        onSelect: (value) {
          selectedTopic.value = value;
          controller.updateIssueType(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Form(
            key: controller.ticketFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please select the issue type',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 1, color: TColors.darkerGrey),
                ),
                const SizedBox(height: TSizes.xs),
                ValueListenableBuilder<String>(
                  valueListenable: selectedTopic,
                  builder: (context, value, _) {
                    return GestureDetector(
                      onTap: () => _openBottomSheet(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(value)),
                            const Icon(
                              Icons.keyboard_arrow_right,
                              color: TColors.darkGrey,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Obx(() {
                  if (controller.issueTypeError.value.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.issueTypeError.value,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Transaction ID
                Text(
                  'Please provide the transaction ID',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 1, color: TColors.darkerGrey),
                ),
                const SizedBox(height: TSizes.xs),
                TextFormField(
                  controller: controller.transactionId,
                  validator: (value) => TValidator.validateEmptyText(
                      'Please provide the transaction ID', value),
                  decoration: InputDecoration(
                    hintText: 'Please provide the transaction ID',
                    hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 16),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Issue Description
                Text(
                  'Please describe the issue',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 1, color: TColors.darkerGrey),
                ),
                const SizedBox(height: TSizes.xs),
                TextFormField(
                  controller: controller.issueDescription,
                  validator: (value) => TValidator.validateEmptyText(
                      'Please describe the issue', value),
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Please describe the issue',
                    hintStyle: TextStyle(color: TColors.darkGrey, fontSize: 16),
                    contentPadding: EdgeInsets.all(TSizes.md),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusLg),
                      borderSide: BorderSide(color: TColors.gray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusLg),
                      borderSide: BorderSide(color: TColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.submitTicket,
                    child: const Text('Submit a ticket'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
