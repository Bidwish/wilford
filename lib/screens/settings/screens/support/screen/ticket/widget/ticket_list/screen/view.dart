import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/support/screen/ticket/widget/ticket_list/model/ticket_model.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import '../../../controller/message_controller.dart';
import 'widget/view_ticket_header.dart';

class TTicketDetails extends StatelessWidget {
  const TTicketDetails({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final ticketChatController = Get.put(TicketChatController());
    ticketChatController.fetchMessages(ticket.ticketId);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TAppBar(
        title: const Text("Submit a Ticket"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: Column(
        children: [
          // Ticket header or details (optional)
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: TicketHeaderWidget(
                ticket: ticket), // You can replace with your own
          ),

          // Chat List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace,
                  right: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.grey),
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                ),
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                    itemCount: ticketChatController.messages.length,
                    itemBuilder: (_, index) {
                      final msg = ticketChatController.messages[index];
                      final isSupport = msg.sender == 'support';

                      return Align(
                        alignment: isSupport
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                isSupport ? TColors.darkGrey : TColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.message,
                                style: TextStyle(
                                  color:
                                      isSupport ? Colors.black87 : Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                msg.timestamp,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Input field
          if (ticket.status != 'closed')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: ticketChatController.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusSm),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: TSizes.md,
                          vertical: TSizes.xs,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.sm),
                  GestureDetector(
                    onTap: () =>
                        ticketChatController.sendMessage(ticket.ticketId),
                    child: Container(
                      padding: const EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusSm),
                      ),
                      child: const Icon(Icons.send, color: TColors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
