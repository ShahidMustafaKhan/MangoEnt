import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraLiveController extends GetxController {

  late final CameraController cameraController;

  RxBool cameraReady=false.obs;


  Future<void> initializeCamera() async {
    final cameras =  await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    cameraController.initialize().whenComplete((){
      cameraReady.value = true;
    });
  }

  @override
  void onInit() {
    initializeCamera();
    super.onInit();
  }

}
