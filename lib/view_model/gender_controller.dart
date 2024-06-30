import 'package:get/get.dart';

class GenderController extends GetxController {
  var selectedGender = ''.obs;

  void updateGender(String gender) {
    selectedGender.value = gender;
  }
}
