import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'controller/chat_controller.dart';

class TContactSupportScreen extends StatelessWidget {
  const TContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final box = GetStorage();
    final chatId = box.read('chat_id');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMessages();
    });

    return Scaffold(
      resizeToAvoidBottomInset: true, // let UI move up when keyboard opens
      appBar: TAppBar(
        title: const Text("Customer Support"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),

      body: Column(
        children: [
          // --- Messages List ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: TSizes.defaultSpace,
              ),
              child: Obx(() {
                final messages = controller.messages;
                if (messages.isEmpty) {
                  return const Center(child: Text("No messages yet..."));
                }

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isUser = msg.senderId != 'support';

                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? TColors.primary : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          msg.message,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),

          // --- Input Section ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.lg,
              vertical: TSizes.sm,
            ),
            child: Row(
              children: [
                // --- Close Chat ---
                GestureDetector(
                  onTap: () => controller.closeChat(chatId),
                  child: Container(
                    padding: const EdgeInsets.all(TSizes.sm),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusSm),
                    ),
                    child: const Icon(Icons.power_settings_new,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(width: TSizes.sm),

                // --- Text Input ---
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (_) => controller.sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: TColors.darkGrey),
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

                // --- Send Button ---
                Obx(() {
                  return GestureDetector(
                    onTap: controller.isSending.value
                        ? null
                        : controller.sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                        color: controller.isSending.value
                            ? Colors.grey
                            : TColors.primary,
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusSm),
                      ),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
