import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/commom/widgets/appber/appber.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/screens/settings/screens/history/model/history_model.dart';
import 'package:wilford/screens/settings/screens/history/screen/widget/row.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/date&time_formatting.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

import 'share_receipt.dart';
import 'widget/fee_and_earning_row.dart';
import 'widget/status_row.dart';

class TViewHistory extends StatelessWidget {
  const TViewHistory({
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

    return Scaffold(
      appBar: TAppBar(
        title: Text("Transaction Detiles"),
        showBackArrow: true,
        leadingOnPressed: () => Get.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  TContainer(
                    chlid: Padding(
                      padding: EdgeInsets.all(TSizes.md),
                      child: Column(
                        children: [
                          SizedBox(height: TSizes.sm * 2),
                          formatCurrencyText(
                            double.tryParse(tx.amount.trim().isEmpty
                                    ? '0'
                                    : tx.amount.trim()) ??
                                0.0,
                            symbolSize: 24,
                            amountSize: 24,
                            symbolWeight: FontWeight.bold,
                            amountWeight: FontWeight.bold,
                            color: isDark ? TColors.white : TColors.textPrimary,
                          ),

                          if (tx.status == 'successful')
                            StatusRowWithIcon(
                              icon: Icons.check_circle,
                              text: 'Successful',
                              color: TColors.success,
                            )
                          else if (tx.status == 'pending')
                            StatusRowWithIcon(
                              icon: Icons.warning_amber,
                              text: 'Pending',
                              color: TColors.amber,
                            )
                          else if (tx.status == 'failed')
                            StatusRowWithIcon(
                              icon: Icons.cancel,
                              text: 'Failed',
                              color: Colors.red,
                            )
                          else if (tx.status == 'reverse')
                            StatusRowWithIcon(
                              icon: Icons.warning_amber,
                              text: 'Reverse',
                              color: Colors.amber,
                            ),
                          const SizedBox(height: TSizes.md),

                          /// Fee or Earnings
                          if (tx.method == '2' ||
                              tx.method == '9' ||
                              tx.method == '10')
                            FeeAndEarningRow(
                              leftText: 'Fee',
                              rightText: '₦${tx.fee}',
                            )
                          else
                            FeeAndEarningRow(
                              leftText: 'Point Earned',
                              rightText: '₦${tx.pts}',
                              color: TColors.success,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -23,
                    child: Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: TColors.primary.withAlpha(90),
                        border: Border.all(
                          width: 2,
                          color: TColors.primary,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: TColors.primary,
                        size: 38,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              /// --- Transaction Details ---
              TContainer(
                chlid: Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Treansaction Details',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            fontWeightDelta: 2,
                            color: isDark ? TColors.white : TColors.darkerGrey),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                      if (tx.method == '4')
                        TTransactionRow(
                          title: 'Profile Code',
                          subtitle: tx.mtNumber,
                        )
                      else if (tx.method == '6' || tx.method == '7')
                        TTransactionRow(
                          title: 'Account Number',
                          subtitle: tx.mtNumber,
                        ),
                      SizedBox(height: TSizes.sm),

                      /// Seconde Line
                      if (tx.method == '0')
                        TTransactionRow(
                          title: 'Sender Details',
                          subtitle:
                              '${tx.senderAccName} \n ${tx.senderBank} | ${tx.senderAccNumber}',
                        )
                      else if (tx.method == '1' && tx.userId == loginUser)
                        TTransactionRow(
                          title: 'Recipient Details',
                          subtitle:
                              '${tx.recAccName} \n ${tx.recBank} | ${tx.recAccNumber}',
                        )
                      else if (tx.method == '1' && tx.recId == loginUser ||
                          tx.method == '2')
                        TTransactionRow(
                          title: 'Sender Details',
                          subtitle:
                              '${tx.senderAccName} \n ${tx.senderBank} | ${tx.senderAccNumber}',
                        )
                      else if (tx.method == '3' ||
                          tx.method == '5' ||
                          tx.method == '8')
                        TTransactionRow(
                          title: 'Recipient Mobile',
                          subtitle: tx.phone,
                        )
                      else if (tx.method == '4')
                        TTransactionRow(
                          title: 'Candidate Name',
                          subtitle: tx.accName,
                        )
                      else if (tx.method == '6' || tx.method == '7')
                        TTransactionRow(
                          title: 'Account Name',
                          subtitle: tx.accName,
                        )
                      else if (tx.method == '9')
                        TTransactionRow(
                          title: 'Recipient Email',
                          subtitle: tx.email,
                        )
                      else if (tx.method == '10')
                        TTransactionRow(
                          title: 'Card Code',
                          subtitle: tx.remark,
                        ),
                      SizedBox(height: TSizes.sm),

                      /// 3rd Line
                      if (tx.remark.isEmpty && tx.method == '1' ||
                          tx.remark.isEmpty && tx.method == '2')
                        TTransactionRow(
                          title: 'Remark',
                          subtitle: tx.remark,
                        )
                      else if (tx.method == '4')
                        TTransactionRow(
                          title: 'Service Type',
                          subtitle: tx.pin,
                        )
                      else if (tx.method == '5')
                        TTransactionRow(
                          title: 'Serial',
                          subtitle: tx.pin,
                        )
                      else if (tx.method == '6')
                        TTransactionRow(
                          title: 'Package',
                          subtitle: tx.serial,
                        )
                      else if (tx.method == '7')
                        TTransactionRow(
                          title: 'Meter Type',
                          subtitle: tx.serial,
                        )
                      else if (tx.method == '8')
                        TTransactionRow(
                          title: 'Data Bundle',
                          subtitle: tx.dataName,
                        ),
                      SizedBox(height: TSizes.sm),

                      /// 4th line
                      if (tx.method == '0')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer from ${tx.senderBank} Account',
                        )
                      else if (tx.method == '1' && tx.userId == loginUser)
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer to ${tx.recBank} Account',
                        )
                      else if (tx.method == '1' && tx.recId == loginUser)
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer from ${tx.senderBank} Account',
                        )
                      else if (tx.method == '2')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer from ${tx.senderBank} Account',
                        )
                      else if (tx.method == '3')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Airtime',
                        )
                      else if (tx.method == '4')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Education',
                        )
                      else if (tx.method == '5')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'WASSCE/GCE',
                        )
                      else if (tx.method == '6')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'TV',
                        )
                      else if (tx.method == '7')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Electricity Bills',
                        )
                      else if (tx.method == '8')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Mobile Data',
                        )
                      else if (tx.method == '9')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Gift Card',
                        )
                      else if (tx.method == '10')
                        TTransactionRow(
                          title: 'Transaction Type',
                          subtitle: 'Gift Card Redeemed',
                        ),
                      SizedBox(height: TSizes.sm),

                      /// 5th line
                      if (tx.method == '1' || tx.method == '10')
                        TTransactionRow(
                          title: 'Credited to',
                          subtitle: 'Wallet',
                        )
                      else if (tx.method == '2' ||
                          tx.method == '3' ||
                          tx.method == '4' ||
                          tx.method == '5' ||
                          tx.method == '6' ||
                          tx.method == '7' ||
                          tx.method == '8' ||
                          tx.method == '9')
                        TTransactionRow(
                          title: 'Payment Method',
                          subtitle: 'Wallet',
                        ),
                      SizedBox(height: TSizes.sm),

                      /// 6th Line
                      TTransactionRow(
                        title: 'Transaction No.',
                        subtitle: tx.paymentId,
                      ),
                      SizedBox(height: TSizes.sm),

                      TTransactionRow(
                        title: 'Transaction Date',
                        subtitle: formatDateAndTime(tx.timeDate),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// --- Share Botting ---
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => TShareReceiptScreen(tx: tx)),
          child: Text(
            'Share Receipt',
            style: Theme.of(context).textTheme.bodyLarge!.apply(
                  fontWeightDelta: 2,
                  color: TColors.white,
                ),
          ),
        ),
      ),
    );
  }
}
