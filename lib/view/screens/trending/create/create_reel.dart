import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/main.dart';
import 'package:teego/utils/colors_hype.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'dart:async';

import '../../../../helpers/quick_help.dart';
import '../../../../parse/MusicModel.dart';
import '../../../../parse/others/video_editor_model.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/music_controller.dart';
import '../../live/widgets/basic_feature_sheets/local_music.dart';
import '../../reels/video_editor_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final picker = ImagePicker();
  bool isRecording = false;
  int recordingTime = 15;
  Timer? _timer;
  double progressValue = 0.0;
  int selectedCameraIdx = 0;
  List<CameraDescription> cameras = [];
  MusicController musicController= Get.put(MusicController());


  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void toggleCamera() async {
    int newIndex = selectedCameraIdx + 1;
    if (newIndex >= cameras.length) {
      newIndex = 0; // Wrap around to the first camera
    }

    // Dispose current controller before initializing new one
    await _controller.dispose();

    _controller = CameraController(
      cameras[newIndex],
      ResolutionPreset.high,
    );

    // Initialize the controller
    _initializeControllerFuture = _controller.initialize();
    setState(() {
      selectedCameraIdx = newIndex;
    });
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras[selectedCameraIdx],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  _pickVideo() async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets:  1 ,
        requestType: RequestType.video ,
      ),
    );

    if (result != null && result.isNotEmpty) {

        final File? file = await result.first.file;
        if (file != null) {
          Navigator.pop(context, {
            'videoFile': file,
          });
        }
    }
  }

  Future<void> prepareVideo(File file) async {
    VideoEditorModel? videoEditorModel = await QuickHelp.goToNavigatorScreenForResult(
      context,
      VideoEditorScreen(file: file),
    );

    if (videoEditorModel != null) {
      File? videoFile = videoEditorModel.getVideoFile();
      ParseFile parseFileThumbnail = ParseFile(File(videoEditorModel.coverPath!), name: "thumbnail.jpg");

      Navigator.pop(context, {
        'uploadPhoto': videoEditorModel.coverPath,
        'videoFile': videoFile,
        'parseFileThumbnail': parseFileThumbnail,
      });
    }
  }

  Future<void> takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    final image = await _controller.takePicture();
    Navigator.pop(context, image.path);
  }

  void startRecording() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    setState(() {
      isRecording = true;
      progressValue = 0.0; // Reset progress bar
    });

    await _controller.startVideoRecording();
    musicController.playMusic();

    double tick = 0.1; // Adjust tick interval for smooth progress
    _timer = Timer.periodic(Duration(milliseconds: (tick * 1000).toInt()), (timer) {
      setState(() {
        progressValue += tick / recordingTime;
      });

      if (progressValue >= 1.0) {
        stopRecording();
      }
    });
  }

  void stopRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }
    musicController.stopMusic();


    final video = await _controller.stopVideoRecording();
    _timer?.cancel();

    setState(() {
      isRecording = false;
      progressValue = 0.0;
    });

    File file = File(video.path);

    Navigator.pop(context, {
      'videoFile': file,
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(child: CameraPreview(_controller)),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), // Make it rounded
                        border: Border.all(color: AppColors.progressBgColor, width: 1), // Optional: Add a border around progress bar
                      ),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: AppColors.progressBgColor,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellowBtnColor),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 51.h,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: TextButton.icon(
                                  onPressed: () {
                                    musicBottomSheet(context, 200,
                                        200);
                                  },
                                  icon: Image.asset('assets/reels/mingcute_music-line.png'),
                                  label: Text(
                                    musicController.selectedAudioName.value==''?"Select Music":musicController.selectedAudioName.value,
                                    style: sfProDisplayBold.copyWith(
                                      color: AppColors.textWhite,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
                // Positioned(
                //   top: 35,
                //   right: 20,
                //   child: Column(
                //     children: [
                //       IconButton(
                //         icon: Image.asset('assets/reels/camera.png'),
                //         onPressed: toggleCamera,
                //       ),
                //       IconButton(
                //         icon: Image.asset('assets/reels/fluent_flash-off-24-regular.png'),
                //         onPressed: () {},
                //       ),
                //       IconButton(
                //         icon: Image.asset('assets/reels/basil_timer-outline.png'),
                //         onPressed: () {},
                //       ),
                //       IconButton(
                //         icon: Image.asset('assets/reels/icon-park_application-effect.png'),
                //         onPressed: () {},
                //       ),
                //     ],
                //   ),
                // ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoSegmentedControl<int>(
                        selectedColor: AppColors.grey300, // Adjust color as needed
                        unselectedColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        children: {
                          180: Container(
                            padding: EdgeInsets.all(10),
                            child: Text('3m', style: sfProDisplayLight.copyWith(color: AppColors.textWhite, fontSize: 12.h)),
                          ),
                          60: Container(
                            padding: EdgeInsets.all(10),
                            child: Text('60 sec', style: sfProDisplayLight.copyWith(color: AppColors.textWhite, fontSize: 12.h)),
                          ),
                          15: Container(
                            padding: EdgeInsets.all(10),
                            child: Text('15 sec', style: sfProDisplayLight.copyWith(color: AppColors.textWhite, fontSize: 12.h)),
                          ),
                        },
                        groupValue: recordingTime,
                        onValueChanged: (value) {
                          setState(() {
                            recordingTime = value;
                          });
                          // You can add additional logic here based on the selected value
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/reels/star.png",
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                'Effects',
                                style: sfProDisplayRegular.copyWith(
                                    color: AppColors.textWhite, fontSize: 12.h),
                              )
                            ],
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                border: Border.all(color: AppColors.white, width: 2)),
                            child: Center(
                              child: GestureDetector(
                                onTap: isRecording ? stopRecording : startRecording,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(360),
                                      color: AppColors.yellowBtnColor),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.photo,
                              color: Colors.white,
                              size: 35,
                            ),
                            onPressed: (){_pickVideo();},
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void musicBottomSheet(BuildContext context,double height,double width){
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: AppColors.grey500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        )),
        isScrollControlled: false, // Set this property to true
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
                return Container(
                    decoration: BoxDecoration(
                      // color: AppColors.grey500,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, icon: Icon(Icons.close,color: Colors.white,)),

                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Music',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Icon(Icons.keyboard_arrow_down,size: 25,color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(),

                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16 ),
                        //   child: TextField(
                        //
                        //     // controller: _controller,
                        //     onChanged: (text) {
                        //       // setState(() {
                        //       // _searchText = text;
                        //       // });
                        //     },
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        //       fillColor: Colors.grey.shade200,
                        //       filled: true,
                        //       labelText: 'Search',
                        //       hintText: 'Search for something...',
                        //       prefixIcon: Icon(Icons.search),
                        //       border: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Colors.transparent
                        //         ),
                        //         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //
                        //         borderSide: BorderSide(
                        //             color: Colors.transparent
                        //         ),
                        //
                        //         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 25,),
                        Expanded(
                          child: Container(
                              child:FutureBuilder<List<MusicModel>>(
                                future: MusicController.getAudioData(), // Replace with your actual data fetching function
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator()); // Display a loading indicator while waiting for data.
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    final musicModelList = snapshot.data; // Access the loaded data
                                    return ListView.separated(
                                      padding: EdgeInsets.symmetric(horizontal: 19),
                                      itemCount: musicModelList!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final musicModel = musicModelList[index];
                                        return GestureDetector(
                                          onTap: () {

                                            musicController.toggleItemPressed(index);


                                            // toggleItemPressed(index);
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(10.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        musicModel.getThumbnail!.url!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Stack(children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .center,
                                                    child:  Obx(
                                                            () {
                                                          // You can use any other widget here or just an empty SizedBox to hide it.
                                                          return IconButton(
                                                              icon: Icon(
                                                                musicController
                                                                    .isPlaying[index]
                                                                    .value ? Icons
                                                                    .pause : Icons
                                                                    .play_arrow,
                                                                color: Colors
                                                                    .white,),
                                                              onPressed: () {
                                                                if (musicController
                                                                    .isPlaying[index]
                                                                    .value ==
                                                                    false) {
                                                                  musicController.loadAudio2(
                                                                      musicModel
                                                                          .getAudioFile!.url!);
                                                                  musicController.player2.play();
                                                                  musicController
                                                                      .togglePlayItemPressed(
                                                                      index);



                                                                }
                                                                else {
                                                                  musicController.player2.pause();
                                                                  musicController.togglePlayItemPressed(index);
                                                                }
                                                              }


                                                          );}),
                                                  )


                                                ]),

                                              ),


                                              SizedBox(width: 8.0), // Add spacing between image and text
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 62,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      // SizedBox(height: 1,),
                                                      Text(musicModel.getAudioName!, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: AppColors.white)),
                                                      Text(musicModel.getSingerName?? "",style: TextStyle(fontSize: 12, color: AppColors.white),),
                                                      Text(musicModel.getTime!,style: TextStyle(fontSize: 12, color: AppColors.white),),
                                                      // SizedBox(height: 2,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Obx(
                                                    () {
                                                  return musicController.itemPressed[index].value==true?Expanded(child: SizedBox()): SizedBox(); // You can use any other widget here or just an empty SizedBox to hide it.
                                                },
                                              ),


                                              Obx(
                                                    () {
                                                  return musicController.itemPressed[index].value==true?
                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                      });
                                                      Navigator.pop(context);

                                                      musicController.loadAudio(musicModel.getAudioFile!.url!).then((value) {
                                                        musicController.itemPressed[index].value=false;
                                                        musicController.isMusicSelected=true;
                                                        musicController.selectedMusicURL=musicModel.getAudioFile!.url!;
                                                        musicController.selectedAudioName.value= musicModel.getAudioName!;

                                                      });

                                                    },
                                                    child: Container(
                                                      width: 65,
                                                      height: 38,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.yellowBtnColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),

                                                      child: Icon(
                                                        Icons.check,
                                                        size: 22,
                                                        color: Colors.white,
                                                      ),

                                                    ),
                                                  ): SizedBox(); // You can use any other widget here or just an empty SizedBox to hide it.
                                                },
                                              ),




                                            ],
                                          ),
                                        );

                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(height: 8);
                                      },
                                    );
                                  }
                                },
                              )
                          ),
                        ),



                      ],
                    )



                );
              }
          );
        }).then((value) {

      print("dismissed");

      if(musicController.player2.playing){
        musicController.player2.pause();
      }
      musicController.player2.stop();
      musicController.isPlaying= List.generate(15, (index) => false.obs);
      // print(musicController.isPlaying);



    });

  }

}
