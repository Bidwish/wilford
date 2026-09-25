// lib/screens/tickets/controller/get_ticket.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/utils/popups/loaders.dart';
import '../widget/ticket_list/model/ticket_model.dart';

class GetTicket extends GetxController {
  var isLoading = false.obs;
  var tickets = <TicketModel>[].obs;

  final total = '0'.obs;
  final processing = '0'.obs;
  final pending = '0'.obs;
  final resolved = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      isLoading.value = true;

      final box = GetStorage();
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('https://api.wilford.ng/v1/support/ticket/get/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List decoded = data['data'];

        tickets.value = decoded.map((e) => TicketModel.fromJson(e)).toList();

        // Extract summary (ensure backend returns these in the top-level "meta" or somewhere)
        if (decoded.isNotEmpty) {
          final firstTicket = decoded.first;
          total.value = firstTicket['total']?.toString() ?? '0';
          pending.value = firstTicket['pending']?.toString() ?? '0';
          resolved.value = firstTicket['resolved']?.toString() ?? '0';
          processing.value = firstTicket['ongoing']?.toString() ?? '0';
        }
      } else {
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'Failed to load tickets',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      TLoaders.errorSnackbar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
