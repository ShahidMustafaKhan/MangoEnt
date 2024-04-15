import 'package:flutter/material.dart';

import '../../utils/theme/colors_constant.dart';

class DateOfBirth extends StatefulWidget {
  final String? Function(String?)? validator;

  const DateOfBirth({Key? key, this.validator}) : super(key: key);

  @override
  _DateOfBirthState createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  final TextEditingController _dateController = TextEditingController();
  String? _errorText;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.yellow,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      final formattedDate = pickedDate
          .toLocal()
          .toString()
          .split(' ')[0]; // Format date without time
      setState(() {
        _dateController.text = formattedDate;
        _errorText = widget.validator != null
            ? widget.validator!(_dateController.text)
            : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: _dateController,
      onTap: () {
        _selectDate(context);
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Date of birth",
        errorText: _errorText,
        suffixIcon: const Icon(Icons.calendar_today),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            //<-- SEE HERE
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
