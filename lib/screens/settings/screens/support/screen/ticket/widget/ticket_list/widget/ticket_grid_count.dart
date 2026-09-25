import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/sizes.dart';

import 'ticket_list_container.dart';

class TicketCountGrid extends StatelessWidget {
  const TicketCountGrid({
    super.key, required this.total, required this.pending, required this.processing, required this.resloved,
  });

  final String total, pending, processing, resloved;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TTicketContainer(
              titel: total,
              subtitel: 'All ticket',
            ),
            const SizedBox(width: TSizes.sm),
            TTicketContainer(
              titel: pending,
              subtitel: 'Pending',
            ),
          ],
        ),
        const SizedBox(height: TSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TTicketContainer(
              titel: processing,
              subtitel: 'Processing',
            ),
            const SizedBox(width: TSizes.sm),
            TTicketContainer(
              titel: resloved,
              subtitel: 'Closed',
            ),
          ],
        ),
      ],
    );
  }
}
