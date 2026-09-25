import 'package:flutter/services.dart';

// Updated Formatter: Capitalize + Add dash every 4 letters
class CardCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('-', '').toUpperCase(); // Remove dashes + uppercase
    final newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      newText.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        newText.write('-'); // Insert dash after every 4 characters
      }
    }
    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
