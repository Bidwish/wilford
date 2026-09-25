import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wilford/utils/network/network_manager.dart';
import 'package:wilford/utils/popups/full_screen_loder.dart';
import 'package:wilford/utils/popups/loaders.dart';
import '../chat_notice.dart';
import '../contact_support.dart';
import '../model/chart_model.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  final messageController = TextEditingController();
  final box = GetStorage();
  var isSending = false.obs;
  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();

    //  Automatically refresh chat every 5 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchMessages();
    });
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  /// --- Start Chat ---
  Future<void> startChat() async {
    try {
      TFullScreenLoader.show();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.hide();
        TLoaders.warningSnackbar(
          title: "No Internet",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      final token = box.read('token');

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/support/supportChat/start/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true && data['chatId'] != null) {
          // Save chatId locally
          box.write('chat_id', data['chatId']);

          // Navigate to chat screen
          Get.off(() => const TContactSupportScreen());
        } else {
          TLoaders.errorSnackbar(
            title: "Error",
            message: data['message'] ?? 'Unexpected response from server.',
          );
        }
      } else {
        TLoaders.errorSnackbar(
          title: "Error",
          message: "Unable to start chat. Please try again later.",
        );
      }
    } catch (e) {
      debugPrint('Error starting chat: $e');
      TLoaders.errorSnackbar(
        title: "Error",
        message: e.toString(),
      );
    } finally {
      TFullScreenLoader.hide();
    }
  }

  /// --- Fetch Messages ---
  Future<void> fetchMessages() async {
    final chatId = box.read('chat_id');
    if (chatId == null) return;

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.wilford.ng/v1/support/supportChat/messages/?chatId=$chatId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> messageList = data['data'];
          messages.value = messageList
              .map((e) => ChatMessage.fromJson(e))
              .toList()
              .reversed
              .toList();
        }
      } else {
        debugPrint('Failed to fetch messages: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching messages: $e');
    }
  }

  /// --- Send Message ---
  Future<void> sendMessage() async {
    if (isSending.value) return; // prevent double-tap
    isSending.value = true;

    final chatId = box.read('chat_id');
    final token = box.read('token');
    final message = messageController.text.trim();

    if (message.isEmpty || chatId == null) {
      isSending.value = false;
      return;
    }

    final tempMessage = ChatMessage(
      senderId: 'user',
      message: message,
      timestamp: DateTime.now(),
    );
    messages.insert(0, tempMessage);
    messageController.clear();

    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackbar(
          title: "No Internet",
          message: "Please check your connection and try again.",
        );
        messages.remove(tempMessage);
        return;
      }

      final response = await http.post(
        Uri.parse('https://api.wilford.ng/v1/support/supportChat/send/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'chatId': chatId, 'message': message}),
      );

      if (response.statusCode == 200) {
        await fetchMessages(); // refresh with server messages
      } else {
        messages.remove(tempMessage); // rollback if failed
        TLoaders.errorSnackbar(
          title: 'Failed to send',
          message: 'Please try again.',
        );
      }
    } catch (e) {
      messages.remove(tempMessage);
      debugPrint('Error sending message: $e');
      TLoaders.errorSnackbar(title: "Error", message: e.toString());
    } finally {
      isSending.value = false;
    }
  }

  /// --- Close Chat ---
  Future<void> closeChat(chatId) async {
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

      final box = GetStorage();
      final token = box.read('token');

      if (token == null) {
        TFullScreenLoader.hide();
        TLoaders.errorSnackbar(
          title: "Error",
          message: "Authentication required. Please log in again.",
        );
        return;
      }

      final response = await http.get(
        Uri.parse(
            'https://api.wilford.ng/v1/support/supportChat/close/?chatId=$chatId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Close chat response: ${response.body}');

      if (response.statusCode == 200) {
        // Remove the stored chat ID
        box.remove('chat_id');

        // Redirect to Support Notice screen
        Get.off(() => CustomSupportNotice());

        TLoaders.successSnackbar(
          title: "Chat Closed",
          message: "Your chat session has been successfully closed.",
        );
      } else {
        TLoaders.errorSnackbar(
          title: "Error",
          message: "Failed to close chat. Please try again.",
        );
      }
    } catch (e) {
      debugPrint('Error closing chat: $e');
      TLoaders.errorSnackbar(
        title: "Error",
        message: e.toString(),
      );
    } finally {
      TFullScreenLoader.hide();
    }
  }
}
