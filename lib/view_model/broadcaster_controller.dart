import 'package:get/get.dart';

class BroadCastersController extends GetxController {
  final selectedIndices = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  bool isSelected(int index) {
    return selectedIndices.contains(index);
  }
}
