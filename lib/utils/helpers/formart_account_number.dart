String hideAccountNumber(String phoneNumber) {
  // Remove all non-digit characters
  String digits = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // If number is 11 digits, remove the first one (like Nigeria's "0")
  if (digits.length == 11) {
    digits = digits.substring(1);
  }

  // If the number is not at least 4 digits, just return it
  if (digits.length < 4) return digits;

  // Get first 2 and last 2 digits
  String firstTwo = digits.substring(0, 2);
  String lastTwo = digits.substring(digits.length - 2);

  // Middle section replaced with asterisks
  String middle = '*' * (digits.length - 4);

  return '$firstTwo$middle$lastTwo';
}
