import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/date&time_formatting.dart';

import '../../../../controller/close_ticket_controller.dart';
import '../../model/ticket_model.dart';

class TicketHeaderWidget extends StatelessWidget {
  const TicketHeaderWidget({
    super.key,
    required this.ticket,
  });

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final dateTime = formatDate(ticket.dateTime);
    final closeTicketController = Get.put(CloseTicketController());

    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        border: Border.all(color: TColors.grey),
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ticket.issueType,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(fontWeightDelta: 2)),
              if (ticket.status == 'closed')
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.xs),
                  decoration: BoxDecoration(
                      color: Colors.red.withAlpha(100),
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusSm)),
                  child: Text(
                    ticket.status,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Colors.red,
                        ),
                  ),
                ),
              if (ticket.status == 'pending')
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.xs),
                  decoration: BoxDecoration(
                      color: Colors.amber.withAlpha(100),
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusSm)),
                  child: Text(
                    ticket.status,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Colors.amber,
                        ),
                  ),
                ),
              if (ticket.status == 'processing')
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.xs),
                  decoration: BoxDecoration(
                      color: Colors.green.withAlpha(100),
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusSm)),
                  child: Text(
                    'Replied',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Colors.green,
                        ),
                  ),
                ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tcket number',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: TColors.darkGrey),
              ),
              Text(ticket.ticketId),
            ],
          ),
          const SizedBox(height: TSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Created on',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: TColors.darkGrey),
              ),
              Text(dateTime),
            ],
          ),
          const SizedBox(height: TSizes.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: TColors.darkGrey),
              ),
              Text(ticket.issueDescription)
            ],
          ),
          const SizedBox(height: TSizes.sm),
          if (ticket.status != 'closed')
            GestureDetector(
              onTap: () => closeTicketController.closeTicket(ticket.ticketId),
              child: Container(
                width: double.infinity,
                height: 40,
                margin: const EdgeInsets.only(top: TSizes.sm),
                padding: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: TColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    'Close ticket',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: TColors.white,
                        ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
