import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// final formatter = NumberFormart.currency(symbol: '', decimalDigits: 0);
String formatCurrency(double amount) {
  final formatter = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 0, // removes the .00
  );
  return formatter.format(amount);
}

/// Returns a widget with a smaller ₦ and larger amount.
Widget formatCurrencyText(
  double amount, {
  Color color = Colors.black,
  double symbolSize = 16,
  double amountSize = 24,
  FontWeight symbolWeight = FontWeight.w500,
  FontWeight amountWeight = FontWeight.bold,
}) {
  final formattedAmount = NumberFormat('#,##0.00', 'en_NG').format(amount);

  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '₦',
          style: GoogleFonts.inter(
            fontSize: symbolSize,
            fontWeight: symbolWeight,
            color: color,
          ),
        ),
        TextSpan(
          text: formattedAmount,
          style: TextStyle(
            fontSize: amountSize,
            fontWeight: amountWeight,
            color: color,
          ),
        ),
      ],
    ),
  );
}

///
Widget formatCurrencyWithOutZero(
  double amount, {
  Color color = Colors.black,
  double symbolSize = 16,
  double amountSize = 24,
  FontWeight symbolWeight = FontWeight.w500,
  FontWeight amountWeight = FontWeight.bold,
}) {
  // Check if the amount has meaningful decimals
  final hasCents = amount % 1 != 0;

  // Format number (with or without decimals)
  final formattedAmount = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '',
    decimalDigits: hasCents ? 2 : 0,
  ).format(amount);

  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '₦',
          style: GoogleFonts.inter(
            fontSize: symbolSize,
            fontWeight: symbolWeight,
            color: color,
          ),
        ),
        TextSpan(
          text: formattedAmount,
          style: TextStyle(
            fontSize: amountSize,
            fontWeight: amountWeight,
            color: color,
          ),
        ),
      ],
    ),
  );
}
