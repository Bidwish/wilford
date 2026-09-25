// lib/screens/tickets/screen/ticket_list.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/utils/constants/sizes.dart';
import '../../controller/get_ticket_controller.dart';
import 'widget/ticket_grid_count.dart';
import 'widget/ticket_list_contaner.dart';

class TicketList extends StatelessWidget {
  const TicketList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetTicket());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => TicketCountGrid(
                  total: controller.total.value,
                  processing: controller.processing.value,
                  pending: controller.pending.value,
                  resloved: controller.resolved.value,
                )),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text('Ticket lists',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: TSizes.sm),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.tickets.isEmpty) {
                  return const Center(child: Text('No tickets found'));
                }

                return ListView.separated(
                  itemCount: controller.tickets.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: TSizes.spaceBtwItems),
                  itemBuilder: (context, index) {
                    final ticket = controller.tickets[index];
                    return TicketListContaner(ticket: ticket);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
