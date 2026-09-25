String normalizeNigeriaPhone(String value) {
  final digits = value.replaceAll(RegExp(r'[^0-9+]'), '');
  if (digits.startsWith('+234') && digits.length == 14) return digits;
  if (digits.startsWith('234') && digits.length == 13) return '+$digits';
  if (digits.startsWith('0') && digits.length == 11) return '+234${digits.substring(1)}';
  throw const FormatException('Enter a valid Nigerian phone number');
}
