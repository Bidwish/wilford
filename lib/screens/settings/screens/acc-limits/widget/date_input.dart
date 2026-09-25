import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfBirthPicker extends StatefulWidget {
  final TextEditingController controller;

  const DateOfBirthPicker({super.key, required this.controller});

  @override
  State<DateOfBirthPicker> createState() => _DateOfBirthPickerState();
}

class _DateOfBirthPickerState extends State<DateOfBirthPicker> {
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(pickedDate);
      widget.controller.text = formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: _pickDate,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        hintText: 'YYYY-MM-DD',
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
    );
  }
}
