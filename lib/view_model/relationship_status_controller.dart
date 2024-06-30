import 'package:get/get.dart';

class RelationshipStatusController extends GetxController {
  var selectedStatus = ''.obs;

  void updateStatus(String status) {
    selectedStatus.value = status;
  }
}
