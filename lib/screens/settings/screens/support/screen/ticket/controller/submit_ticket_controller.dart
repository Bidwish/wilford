import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/routes/app_routes.dart';
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';
import '../widget/ticket_list/ticket_list.dart';
import 'get_ticket_controller.dart';

class SubmitTicketController extends GetxController {
  final controller = Get.put(GetTicket());
  final transactionId = TextEditingController();
  final issueDescription = TextEditingController();

  final issueType = ''.obs;
  final issueTypeError = ''.obs;

  final GlobalKey<FormState> ticketFormKey = GlobalKey<FormState>();

  void updateIssueType(String value) {
    issueType.value = value;
    issueTypeError.value = ''; // Clear error when user selects
  }

  Future<void> submitTicket() async {
    // Reset previous error
    issueTypeError.value = '';

    // Validate issue type
    if (issueType.value.isEmpty ||
        issueType.value == 'Please select the issue type') {
      issueTypeError.value = 'Please select a valid issue type.';
      return;
    }

    // Validate form
    if (!ticketFormKey.currentState!.validate()) return;

    TFullScreenLoader.show();

    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.hide();
        TLoaders.warningSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      // Get user Token
      final box = GetStorage();
      final token = box.read('token');

      if (token == null) {
        Get.offAllNamed(AppRoutes.login);
        TFullScreenLoader.hide();
        return;
      }

      final requestBody = {
        'transaction_id': transactionId.text.trim(),
        'issue_type': issueType.value,
        'issue_description': issueDescription.text.trim(),
      };

      final response = await http.post(
        Uri.parse("https://api.wilford.ng/v1/support/ticket/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      final jsonStart = response.body.indexOf('{');
      final result = jsonStart != -1
          ? jsonDecode(response.body.substring(jsonStart))
          : null;

      TFullScreenLoader.hide();

      if (response.statusCode == 200) {
        TLoaders.successSnackbar(
          title: "Success",
          message: result['message'] ?? 'Ticket submitted successfully',
        );

        transactionId.clear();
        issueDescription.clear();
        issueType.value = '';

        await controller.fetchTickets();
        TicketList();
      } else {
        TLoaders.errorSnackbar(
          title: "Error",
          message: result['message'] ?? 'An error occurred',
        );
      }
    } catch (e) {
      TFullScreenLoader.hide();
      TLoaders.errorSnackbar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  @override
  void onClose() {
    transactionId.dispose();
    issueDescription.dispose();
    super.onClose();
  }
}
