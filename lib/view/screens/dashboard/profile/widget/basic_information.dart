import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/screens/dashboard/profile/widget/relation_ship_status_sheet.dart';
import 'package:teego/view_model/edit_controller.dart';
import 'package:teego/view_model/gender_controller.dart';
import 'package:teego/view_model/relationship_status_controller.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../utils/theme/colors_constant.dart';
import 'gender_sheet.dart';

class BasicInformationSection extends StatelessWidget {
  final GenderController genderController = Get.find();
  final RelationshipStatusController relationStatusController = Get.find();

  final EditController editController = Get.find();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      editController.updateDate(formattedDate);
    }
  }

  Widget _buildInputField(
    String labelText,
    String hintText,
    String suffixIconPath,
    Color iconColor,
    VoidCallback? onTap,
    TextEditingController textEditingController, {
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: textEditingController,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: false,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: readOnly ? Colors.grey : Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          height: 2.0,
        ),
        suffixIcon: suffixIconPath.isNotEmpty
            ? GestureDetector(
                onTap: onTap != null
                    ? () {
                        onTap();
                        textEditingController.selection =
                            TextSelection.collapsed(
                                offset: textEditingController.text.length);
                      }
                    : null,
                child: Image.asset(
                  suffixIconPath,
                  color: iconColor,
                  width: 24,
                  height: 24,
                ),
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 10.0,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? Colors.black : Colors.white;
    final backgroundColor = isLightTheme ? Colors.white : AppColors.grey500;

    UserViewModel userViewModel = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Information",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            // color: Colors.white,
            color: textColor,
          ),
        ),
        SizedBox(height: 20.h),
        _buildInputField(
            "Name*",
            userViewModel.currentUser.getFullName ?? '',
            AppImagePath.editTextIcon,
            // Colors.white,
            textColor,
            () {},
            editController.nameEditingController),
        SizedBox(height: 20.h),
        Obx(() => _buildInputField(
              "Gender*",
              genderController.selectedGender.value.isNotEmpty
                  ? genderController.selectedGender.value
                  : "Select",
              AppImagePath.dropDownIcon,
              // Colors.white,
              textColor,

              () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  backgroundColor: backgroundColor,
                  builder: (context) => GenderSheet(),
                ).then((value) {
                  editController.genderEditingController.text =
                      genderController.selectedGender.value.isNotEmpty
                          ? genderController.selectedGender.value
                          : "Select";
                });
              },
              editController.genderEditingController,
              readOnly: true,
            )),
        SizedBox(height: 20.h),
        Obx(() => _buildInputField(
              "Birthday*",
              editController.selectedDate.value.isNotEmpty
                  ? editController.selectedDate.value
                  : '${Get.find<UserViewModel>().currentUser.getBirthday!.year}-${doubleDigit(Get.find<UserViewModel>().currentUser.getBirthday!.month.toString())}-${doubleDigit(Get.find<UserViewModel>().currentUser.getBirthday!.day.toString())}',
              AppImagePath.dropDownIcon,
              // Colors.white,
              textColor,

              () {
                _selectDate(context).then((value) => editController
                        .selectedDate.value.isNotEmpty
                    ? editController.birthdayEditingController.text =
                        editController.selectedDate.value
                    : editController.birthdayEditingController.text =
                        '${Get.find<UserViewModel>().currentUser.getBirthday!.year}-${doubleDigit(Get.find<UserViewModel>().currentUser.getBirthday!.month.toString())}-${doubleDigit(Get.find<UserViewModel>().currentUser.getBirthday!.day.toString())}');
                print("Birthday icon tapped");
              },
              editController.birthdayEditingController,
              readOnly: true,
            )),
        SizedBox(height: 20.h),
        Obx(() => _buildInputField(
              "Relationship Status",
              relationStatusController.selectedStatus.value.isNotEmpty
                  ? relationStatusController.selectedStatus.value
                  : userViewModel.currentUser.getRelationshipStatus ?? "Select",
              AppImagePath.dropDownIcon,
              // Colors.white,
              textColor,

              () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  // backgroundColor: AppColors.grey500,
                  backgroundColor: backgroundColor,
                  builder: (context) => RelationshipStatusSheet(),
                ).then((value) =>
                    relationStatusController.selectedStatus.value.isNotEmpty
                        ? editController.statusEditingController.text =
                            relationStatusController.selectedStatus.value
                        : editController.statusEditingController.text =
                            userViewModel.currentUser.getRelationshipStatus ??
                                "Select");
              },
              editController.statusEditingController,
              readOnly: true,
            )),
        SizedBox(height: 20.h),
        _buildInputField(
            "Bio",
            userViewModel.currentUser.getBio ?? 'Hi! i am using Mango Ent.',
            AppImagePath.editTextIcon,
            // Colors.white,
            textColor, () {
          print("Bio icon tapped");
        }, editController.bioEditingController),
        SizedBox(height: 20.h),
      ],
    );
  }

  String doubleDigit(String value) {
    if (int.parse(value) <= 9)
      return "0$value";
    else
      return value;
  }
}
