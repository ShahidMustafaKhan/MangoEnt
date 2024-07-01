// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:path_provider/path_provider.dart';
//
// class RecordingController extends GetxController {
//   // EdScreenRecorder? screenRecorder ;
//   // RecordOutput? response;
//   bool inProgress = false;
//
//   Future<void> startRecord({required String fileName, required int width, required int height}) async {
//     Directory? tempDir = await getApplicationDocumentsDirectory();
//     String? tempPath = tempDir.path;
//     print(tempDir);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     print(tempPath);
//     try {
//       var startResponse = await screenRecorder?.startRecordScreen(
//         fileName: "Eren",
//         //Optional. It will save the video there when you give the file path with whatever you want.
//         //If you leave it blank, the Android operating system will save it to the gallery.
//         // dirPathToSave: tempPath,
//         audioEnable: true,
//         width: width,
//         height: height,
//       );
//
//         response = startResponse;
//
//     Timer.periodic(Duration(seconds: 4), (Timer timer) {
//     print("File: ${startResponse?.success}");
//     print("Status: ${response?.success.toString()}");
//     print("Event: ${response?.eventName}");
//     print("Progress: ${response?.isProgress.toString()}");
//     print("Message: ${response?.message}");
//     print("Video Hash: ${response?.videoHash}");
//     print("Start Date: ${(response?.startDate).toString()}");
//     print("End Date: ${(response?.endDate).toString()}");    });
//
//         update();
//
//
//     }
//
//     on PlatformException {
//       kDebugMode ? debugPrint("Error: An error occurred while starting the recording!") : null;
//     }
//   }
//
//   Future<void> stopRecord() async {
//     try {
//       var stopResponse = await screenRecorder?.stopRecord();
//         response = stopResponse;
//         update();
//
//     } on PlatformException {
//       kDebugMode ? debugPrint("Error: An error occurred while stopping recording.") : null;
//     }
//   }
//
//
//   RecordingController();
//
//   @override
//   void onInit() {
//     screenRecorder = EdScreenRecorder();
//     super.onInit();
//   }
//
//
//
//
// }
//
//
