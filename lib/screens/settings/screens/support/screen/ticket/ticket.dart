import 'package:flutter/material.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'widget/create_ticket/create_ticket.dart';
import 'widget/ticket_list/ticket_list.dart';

class TTicketScreen extends StatelessWidget {
  const TTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text('Submit a Ticket'),
          bottom: const TabBar(
            indicatorColor: TColors.primary,
            labelColor: TColors.primary,
            tabs: [
              Tab(text: 'Create a ticket'),
              Tab(text: 'Ticket Lists'),
            ],
          ),
        ),
        body: TabBarView(children: [
          CreateTicket(),
          TicketList(),
        ]),
      ),
    );
  }
}
