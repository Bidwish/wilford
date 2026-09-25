import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/screens/settings/screens/history/controller/history_controller.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';

import 'widget/history_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    // Fetch history when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchHistory();
    });

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Transaction History"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
      ),
      body: Obx(() {
        final historyList = controller.history;

        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: TColors.primary));
        }

        if (historyList.isEmpty) {
          return const Center(
            child: Text("No transaction history available."),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          itemCount: historyList.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final tx = historyList[index];

            return HistroyList(tx: tx);
          },
        );
      }),
    );
  }
}
