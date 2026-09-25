import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';
import 'get_ticket_controller.dart';

class CloseTicketController extends GetxController {
  final controller = Get.put(GetTicket());

  Future<void> closeTicket(String ticketId) async {
    // Show a loading indicator
    TFullScreenLoader.show();

    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.hide();
        TLoaders.warningSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      final requestBody = {
        'ticketId': ticketId,
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/support/ticket/close/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      final jsonStart = response.body.indexOf('{');
      final result = jsonStart != -1
          ? jsonDecode(response.body.substring(jsonStart))
          : null;

      if (response.statusCode == 200) {
        await controller.fetchTickets();
      } else {
        TLoaders.errorSnackbar(
          title: "Error",
          message: result['message'] ?? 'An error occurred',
        );
      }
    } catch (e) {
      debugPrint('Error closing ticket: $e');
    } finally {
      // Hide the loading indicator
      TFullScreenLoader.hide();
    }
  }
}
