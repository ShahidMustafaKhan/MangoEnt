import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/userViewModel.dart';

class EditController extends GetxController {
  var selectedDate = ''.obs;
  late TextEditingController nameEditingController = TextEditingController(text: Get.find<UserViewModel>().currentUser.getFullName ?? '');
  late TextEditingController genderEditingController= TextEditingController(text: Get.find<UserViewModel>().currentUser.getGender ?? '');
  late TextEditingController birthdayEditingController= TextEditingController(text: selectedDate.value.isNotEmpty
      ? selectedDate.value
      :  '${Get.find<UserViewModel>().currentUser.getBirthday!.year}-${doubleDigit(Get.find<UserViewModel>().currentUser.getBirthday!.month.toString())}-${doubleDigit(Get.find<UserViewModel>().currentUser.getBirthday!.day.toString())}');
  late TextEditingController statusEditingController= TextEditingController(text: Get.find<UserViewModel>().currentUser.getRelationshipStatus ?? "Select");
  late TextEditingController bioEditingController= TextEditingController(text: Get.find<UserViewModel>().currentUser.getBio ?? 'Hi! i am using Mango Ent.');

  void updateDate(String date) {
    selectedDate.value = date;
  }

  String doubleDigit(String value){
    if(int.parse(value)<=9)
      return "0$value";
    else
      return value;
  }
}
