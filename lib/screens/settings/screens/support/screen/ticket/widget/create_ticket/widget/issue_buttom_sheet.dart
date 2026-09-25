import 'package:flutter/material.dart';

class TTopicBottomSheet extends StatelessWidget {
  const TTopicBottomSheet({super.key, required this.onSelect});

  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    final topics = [
      'Deposit',
      'Transfer',
      'Mobile Data',
      'AirTime',
      'TV',
      'Utility Bill',
      'Exams',
      'Betting',
      'Gift Card'
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.94,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            // color: isDark TColors.Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Row(
                children: [
                  const Text(
                    'Please select the Issue type',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const Divider(),

              // --- Scrollable List ---
              Expanded(
                  child: ListView.separated(
                controller: scrollController,
                itemCount: topics.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      topics[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      onSelect(topics[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ))
            ],
          ),
        );
      },
    );
  }
}
