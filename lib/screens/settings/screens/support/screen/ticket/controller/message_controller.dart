import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/routes/app_routes.dart';
import 'dart:convert';
import '../widget/ticket_list/model/chat_model.dart';

class TicketChatController extends GetxController {
  var isLoading = true.obs;
  var messages = <TicketMessage>[].obs;
  final TextEditingController messageController = TextEditingController();

  Future<void> fetchMessages(String ticketId) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.wilford.ng/v1/support/ticket/messages/?ticketId=$ticketId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        messages.value = data.map((e) => TicketMessage.fromJson(e)).toList();
      } else {
        messages.clear();
      }
    } catch (e) {
      messages.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String ticketId) async {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    try {
      // Get user Token
      final box = GetStorage();
      final token = box.read('token');

      if (token == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/support/ticket/send/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ticketId': ticketId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        messageController.clear();
        await fetchMessages(ticketId); // Refresh chat
      } else {
        Get.snackbar("Error", "Failed to send message");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
