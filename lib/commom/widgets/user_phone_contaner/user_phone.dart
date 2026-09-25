import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wilford/commom/widgets/containers/container_widget.dart';
import 'package:wilford/utils/constants/colors.dart';
import 'package:wilford/utils/constants/sizes.dart';
import 'package:wilford/utils/helpers/helper_functions.dart';

/// Formatter for 3-4-4 phone number format
class ThreeFourFourInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length && i < 11; i++) {
      if (i == 3 || i == 7) buffer.write(' ');
      buffer.write(digitsOnly[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class UserPhoneNumber extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onErrorChanged;

  const UserPhoneNumber({
    super.key,
    required this.controller,
    required this.onErrorChanged,
  });

  @override
  State<UserPhoneNumber> createState() => _UserPhoneNumberState();
}

class _UserPhoneNumberState extends State<UserPhoneNumber> {
  final FocusNode _focusNode = FocusNode();
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    final box = GetStorage();
    final user = box.read('user') ?? {};
    final phone = user['phone'] ?? '';

    if (widget.controller.text.isEmpty) {
      widget.controller.text = _formatInitialPhone(phone);
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.controller.addListener(_validatePhone);
      } else {
        widget.controller.removeListener(_validatePhone);
        setState(() => errorMessage = '');
        widget.onErrorChanged('');
      }
    });
  }

  /// Formats the stored number on init
  String _formatInitialPhone(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length && i < 11; i++) {
      if (i == 3 || i == 7) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  void _validatePhone() {
    final text = widget.controller.text.replaceAll(' ', '');

    if (text.isEmpty || text.length < 11) {
      setState(() {
        errorMessage = 'Please enter the correct phone number';
      });
      widget.onErrorChanged(errorMessage);
    } else {
      setState(() => errorMessage = '');
      widget.onErrorChanged('');
    }
  }

  /// Pick contact and autofill
  Future<void> _pickContact() async {
    try {
      final contact = await _contactPicker.selectContact();
      final phone = contact?.phoneNumbers?.isNotEmpty == true
          ? contact!.phoneNumbers!.first
          : null;

      if (phone != null) {
        final cleaned = phone.replaceAll(RegExp(r'\D'), '');
        if (cleaned.length == 11) {
          final formatted = ThreeFourFourInputFormatter()
              .formatEditUpdate(
                const TextEditingValue(),
                TextEditingValue(text: cleaned),
              )
              .text;

          setState(() {
            widget.controller.text = formatted;
            errorMessage = '';
          });
          widget.onErrorChanged('');
        } else {
          setState(() {
            errorMessage = 'Invalid contact number';
          });
          widget.onErrorChanged(errorMessage);
        }
      }
    } catch (e) {
      debugPrint("Contact picker error: $e");
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.removeListener(_validatePhone);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TContainer(
      chlid: Padding(
        padding: const EdgeInsets.all(TSizes.md / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: isDark ? TColors.white : TColors.black,
                  size: TSizes.iconMd,
                ),
                const SizedBox(width: TSizes.md),
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.phone,
                    maxLength: 14, // 11 digits + 2 spaces
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ThreeFourFourInputFormatter(),
                    ],
                    style: const TextStyle(
                      fontSize: TSizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0XX XXXX XXXX',
                      hintStyle: TextStyle(
                        color: TColors.darkGrey,
                        fontSize: TSizes.fontSizeMd,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: TColors.darkGrey,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: TColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.md),

                /// 👇 Contact Icon with Tap Handler
                GestureDetector(
                  onTap: _pickContact,
                  child: Icon(
                    Icons.contact_page,
                    color: isDark ? TColors.white : TColors.black,
                    size: TSizes.iconMd,
                  ),
                ),
              ],
            ),

            // Error Message
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
