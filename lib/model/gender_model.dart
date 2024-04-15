import 'package:get/get.dart';

enum Gender {
  male,
  female,
  others,
}

class GenderSelectionController extends GetxController {
  var selectedGender = Gender.male.obs;

  void updateSelectedGender(Gender gender) {
    selectedGender.value = gender;
  }
}
