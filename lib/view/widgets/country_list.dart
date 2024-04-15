import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/constants/typography.dart';

// Define your country names and corresponding flag images
List<String> countryNames = [
  "Pakistan",
  "USA",
  "Canada",
  "France",
  "Ukraine",
];

List<String> countryImages = [
  AppImagePath.pakistanFlag,
  "assets/svg/america_flags.svg",
  AppImagePath.canadaFlag,
  AppImagePath.franceFlag,
  AppImagePath.ukraineFlag,
];

class CountryPickerFormField extends StatefulWidget {
  var validator;
  CountryPickerFormField({this.validator});
  @override
  _CountryPickerFormFieldState createState() => _CountryPickerFormFieldState();
}

class _CountryPickerFormFieldState extends State<CountryPickerFormField> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.disabled,
      readOnly: true,
      controller: TextEditingController(text: selectedCountry),
      onTap: _showCountryPicker,
      style: sfProDisplayMedium.copyWith(fontSize: 12.sp, color: Colors.white.withOpacity(0.7)),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.0),
          hintText: "Select your Country",
          hintStyle:sfProDisplayMedium.copyWith(fontSize: 12.sp, color: Colors.white.withOpacity(0.3)),
          border: InputBorder.none,
          suffixIcon: selectedCountry != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SvgPicture.asset(
                    countryImages[countryNames.indexOf(selectedCountry!)],
                    width: 32,
                    height: 32,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.red),
          )),
    );
  }

  void _showCountryPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Country'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < countryNames.length; i++)
                ListTile(
                  onTap: () {
                    setState(() {
                      selectedCountry = countryNames[i];
                    });
                    Navigator.pop(context);
                  },
                  title: Row(
                    children: [
                      SvgPicture.asset(
                        countryImages[i], // Use the corresponding SVG image
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(countryNames[i]), // Display the country name
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
