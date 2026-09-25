import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart'
    show UserController;
import 'package:wilford/utils/constants/colors.dart' show TColors;
import 'package:wilford/utils/constants/sizes.dart' show TSizes;
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/date&time_formatting.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import '../model/history_model.dart';
import '../screen/view_history.dart';

class HistroyList extends StatelessWidget {
  const HistroyList({
    super.key,
    required this.tx,
  });

  final HistoryModel tx;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    final userController = Get.put(UserController());
    final user = userController.user.value;
    final loginUser = user?.id;

    return InkWell(
      onTap: () => Get.to(() => TViewHistory(tx: tx)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Circular Icon ---
          if (tx.method == '0') IconsContainer(icon: Icons.arrow_downward),
          if (tx.method == '1' && tx.userId == loginUser)
            IconsContainer(icon: Icons.arrow_upward),
          if (tx.method == '1' && tx.recId == loginUser)
            IconsContainer(icon: Icons.arrow_downward),
          if (tx.method == '2') IconsContainer(icon: Icons.arrow_upward),
          if (tx.method == '3') IconsContainer(icon: Icons.signal_cellular_alt),
          if (tx.method == '4') IconsContainer(icon: Icons.menu_book),
          if (tx.method == '5') IconsContainer(icon: Icons.menu_book),
          if (tx.method == '6') IconsContainer(icon: Icons.tv),
          if (tx.method == '7') IconsContainer(icon: Icons.lightbulb_outline),
          if (tx.method == '8') IconsContainer(icon: Icons.public),
          if (tx.method == '9') IconsContainer(icon: Icons.card_giftcard),
          if (tx.method == '10') IconsContainer(icon: Icons.payments),
          const SizedBox(width: TSizes.sm),

          /// --- Transaction Info ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tx.method == '0')
                  Header(text: 'Transfer fron ${tx.senderAccName}')
                else if (tx.method == '1' && tx.userId == loginUser)
                  Header(text: 'Transfer to ${tx.recAccName}')
                else if (tx.method == '1' && tx.recId == loginUser)
                  Header(text: 'Transfer from ${tx.senderAccName}')
                else if (tx.method == '2')
                  Header(text: 'Transfer to ${tx.recAccName}')
                else if (tx.method == '3')
                  Header(text: 'Airtime')
                else if (tx.method == '4')
                  Header(text: 'Jamb')
                else if (tx.method == '5')
                  Header(text: 'WAEC Result Checker PIN')
                else if (tx.method == '6')
                  Header(text: 'Tv Subscription')
                else if (tx.method == '7')
                  Header(text: 'Electricity Bills')
                else if (tx.method == '8')
                  Header(text: 'Mobile Data')
                else if (tx.method == '9')
                  Header(text: 'Gift Card')
                else if (tx.method == '10')
                  Header(text: 'Gift Card Redeemed'),
                const SizedBox(height: 4),
                Text(
                  formatDateTime(tx.timeDate),
                  style: Theme.of(context).textTheme.labelSmall!.apply(
                        color: TColors.darkGrey,
                      ),
                ),
              ],
            ),
          ),

          /// --- Amount & Status ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              formatCurrencyText(
                double.tryParse(
                        tx.amount.trim().isEmpty ? '0' : tx.amount.trim()) ??
                    0.0,
                symbolSize: 14,
                amountSize: 14,
                symbolWeight: FontWeight.w600,
                amountWeight: FontWeight.w600,
                color: isDark ? TColors.white : TColors.black,
              ),
              const SizedBox(height: TSizes.sm),
              if (tx.status == 'successful')
                Container(
                  padding: const EdgeInsets.only(
                      left: TSizes.sm, right: TSizes.sm, bottom: 1, top: 1),
                  decoration: BoxDecoration(
                    color: TColors.success.withAlpha(40),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Successful',
                    style: TextStyle(color: TColors.success, fontSize: 8),
                  ),
                )
              else if (tx.status == 'failed')
                Container(
                  padding: const EdgeInsets.only(
                      left: TSizes.sm, right: TSizes.sm, bottom: 1, top: 1),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(40),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Failed',
                    style: TextStyle(color: Colors.red, fontSize: 8),
                  ),
                )
              else if (tx.status == 'pending')
                Container(
                  padding: const EdgeInsets.only(
                      left: TSizes.sm, right: TSizes.sm, bottom: 1, top: 1),
                  decoration: BoxDecoration(
                    color: Colors.amber.withAlpha(40),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tx.status,
                    style: TextStyle(color: TColors.amber, fontSize: 8),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconsContainer extends StatelessWidget {
  const IconsContainer({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TColors.success.withAlpha(50),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 15,
        color: TColors.success,
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
