import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wilford/auth/controllers/user_controller/user_controller.dart';
import 'package:wilford/screens/settings/screens/history/model/history_model.dart';
import 'package:wilford/screens/settings/screens/history/screen/widget/receipt_row.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/image_strings.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/amount_function.dart';
import 'package:wilford/utils/helpers/date&time_formatting.dart';
import 'package:wilford/utils/helpers/formart_account_number.dart'
    show hideAccountNumber;

class TReceipt extends StatelessWidget {
  const TReceipt({
    super.key,
    required this.tx,
  });

  final HistoryModel tx;

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final user = userController.user.value;
    final loginUser = user?.id;

    return Stack(
      children: [
        Container(
          width: 350,
          padding: EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: TColors.primary,
          ),
          child: Container(
            padding: EdgeInsets.all(TSizes.md),
            decoration: BoxDecoration(
              color: TColors.lightContainer,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Logo ---
                Image.asset(
                  TImages.lightAppLogo,
                  height: 35,
                ),
                SizedBox(height: TSizes.md),

                // --- Amount ---
                Center(
                  child: formatCurrencyText(
                    double.tryParse(tx.amount.trim().isEmpty
                            ? '0'
                            : tx.amount.trim()) ??
                        0.0,
                    symbolSize: 24,
                    amountSize: 24,
                    symbolWeight: FontWeight.w500,
                    amountWeight: FontWeight.w600,
                    color: TColors.secondary,
                  ),
                ),
                SizedBox(height: TSizes.sm),

                // --- Transfer Status ---
                if (tx.status == 'successful')
                  Center(
                    child: Text(
                      'Successful Transaction',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          fontWeightDelta: 1, color: TColors.textPrimary),
                    ),
                  )
                else if (tx.status == 'pending')
                  Center(
                    child: Text(
                      'Pending Transaction',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          fontWeightDelta: 1, color: TColors.textPrimary),
                    ),
                  )
                else if (tx.status == 'failed')
                  Center(
                    child: Text(
                      'Failed Transaction',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          fontWeightDelta: 1, color: TColors.textPrimary),
                    ),
                  )
                else if (tx.status == 'reverse')
                  Center(
                    child: Text(
                      'Reverse Transaction',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          fontWeightDelta: 1, color: TColors.textPrimary),
                    ),
                  ),
                SizedBox(height: TSizes.sm),

                // --- time & Date ---
                Center(
                  child: Text(
                    formatDateAndTime(tx.timeDate),
                    style: TextStyle(
                      fontSize: 8.5,
                      color: TColors.darkGrey,
                    ),
                  ),
                ),
                SizedBox(height: TSizes.md),

                Container(
                  padding: EdgeInsets.all(TSizes.md),
                  decoration: BoxDecoration(
                    color: TColors.white,
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                    image: DecorationImage(
                      image: AssetImage(TImages.receiptLogo),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// --- 1st ---
                      if (tx.method == '4')
                        TReceiptRow(
                          title: 'Profile Code',
                          subtitle: tx.mtNumber,
                        )
                      else if (tx.method == '6' || tx.method == '7')
                        TReceiptRow(
                          title: 'Provider',
                          subtitle: tx.provider,
                        ),
                      SizedBox(height: TSizes.sm),

                      /// --- 2nd ---
                      if (tx.method == '0' ||
                          tx.method == '1' ||
                          tx.method == '2')
                        TReceiptRow(
                          title: 'Recipient Details',
                          subtitle:
                              '${tx.recAccName} \n ${tx.recBank} | ${tx.recAccNumber}',
                        )
                      else if (tx.method == '3' ||
                          tx.method == '5' ||
                          tx.method == '8')
                        TReceiptRow(
                          title: 'Recipient Mobile',
                          subtitle: tx.phone,
                        )
                      else if (tx.method == '4')
                        TReceiptRow(
                          title: 'Candidate Name',
                          subtitle: tx.accName,
                        )
                      else if (tx.method == '6' || tx.method == '7')
                        TReceiptRow(
                          title: 'Account Name',
                          subtitle: tx.accName,
                        )
                      else if (tx.method == '9')
                        TReceiptRow(
                          title: 'Recipient Email',
                          subtitle: tx.email,
                        )
                      else if (tx.method == '10')
                        TReceiptRow(
                          title: 'Card Code',
                          subtitle: tx.remark,
                        ),
                      SizedBox(height: TSizes.sm),

                      /// --- 3rd ---
                      if (tx.method == '0' ||
                          tx.method == '1' ||
                          tx.method == '2')
                        TReceiptRow(
                          title: 'Sender Details',
                          subtitle:
                              '${tx.senderAccName} \n ${tx.senderBank} | ${hideAccountNumber(tx.senderAccNumber)}',
                        )
                      else if (tx.method == '3' || tx.method == '8')
                        TReceiptRow(
                          title: 'Mobile Network Operator',
                          subtitle: tx.network,
                        )
                      else if (tx.method == '4')
                        TReceiptRow(
                          title: 'Package',
                          subtitle: tx.network,
                        )
                      else if (tx.method == '6' || tx.method == '7')
                        TReceiptRow(
                          title: 'Account Number',
                          subtitle: tx.mtNumber,
                        )
                      else if (tx.method == '9')
                        TReceiptRow(
                          title: 'Sender Name',
                          subtitle: tx.remark,
                        ),
                      SizedBox(height: TSizes.sm),

                      /// --- 4th ---
                      if (tx.method == '4')
                        TReceiptRow(
                          title: 'Service Type',
                          subtitle: tx.pin,
                        )
                      else if (tx.method == '6')
                        TReceiptRow(
                          title: 'Package',
                          subtitle: tx.pin,
                        )
                      else if (tx.method == '7')
                        TReceiptRow(
                          title: 'Meter Type',
                          subtitle: tx.serial,
                        )
                      else if (tx.method == '8')
                        TReceiptRow(
                          title: 'Data Bundle',
                          subtitle: tx.dataName,
                        ),
                      SizedBox(height: TSizes.md),
                      Text(
                        'Transaction Details:',
                        style: Theme.of(context).textTheme.labelSmall!.apply(
                            fontWeightDelta: 1, color: TColors.textPrimary),
                      ),
                      SizedBox(height: TSizes.md),
                      if (tx.method == '0')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer from ${tx.senderBank} Account',
                        )
                      else if (tx.method == '1' && tx.userId == loginUser)
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer to ${tx.recBank} Account',
                        )
                      else if (tx.method == '1' && tx.recId == loginUser)
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer from ${tx.senderBank} Account',
                        )
                      else if (tx.method == '2')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Transfer from ${tx.senderBank} Account',
                        )
                      else if (tx.method == '3')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Airtime',
                        )
                      else if (tx.method == '4')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Education',
                        )
                      else if (tx.method == '5')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'WASSCE/GCE',
                        )
                      else if (tx.method == '6')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'TV',
                        )
                      else if (tx.method == '7')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Electricity Bills',
                        )
                      else if (tx.method == '8')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Mobile Data',
                        )
                      else if (tx.method == '9')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Gift Card',
                        )
                      else if (tx.method == '10')
                        TReceiptRow(
                          title: 'Transaction Type',
                          subtitle: 'Gift Card Redeemed',
                        ),
                      SizedBox(height: TSizes.sm),
                      TReceiptRow(
                        title: 'Transaction ID',
                        subtitle: tx.paymentId,
                      ),
                      const SizedBox(height: TSizes.sm),
                      const Divider(
                        color: TColors.gray,
                      ),
                      const SizedBox(height: TSizes.sm),
                      Text(
                        'Enjoy instant airtime and data top-ups with amazing cashback rewards! Get exclusive discounts and flexible payment options. Unlock these benefits and more with Wilford VTU!',
                        style: TextStyle(
                          fontSize: 9,
                          color: TColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections * 3),
              ],
            ),
          ),
        ),

        // ---- Row for Design ----
        Positioned(
          left: 0,
          right: 0,
          bottom: 50,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(TSizes.md),
                decoration: BoxDecoration(
                  color: TColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: DottedLine(
                    dashLength: 7,
                    dashGapLength: 3,
                    lineThickness: 3,
                    dashColor: TColors.primary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(TSizes.md),
                decoration: BoxDecoration(
                  color: TColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
