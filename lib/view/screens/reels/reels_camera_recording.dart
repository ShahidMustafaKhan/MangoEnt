import 'dart:async';
import 'dart:io' ;
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_cropper/image_cropper.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mime/mime.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teego/utils/Utils.dart';
import 'package:teego/view/screens/reels/video_editor_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../helpers/quick_help.dart';
import '../../../parse/MusicModel.dart';
import '../../../parse/UserModel.dart';
import '../../../parse/others/video_editor_model.dart';
import '../../../utils/colors_hype.dart';
import '../../../view_model/music_controller.dart';



class CustomVideoRecordingScreen extends StatefulWidget {
  late final UserModel? currentUser;
  final SharedPreferences? preferences;
  final bool isVideo;
  CustomVideoRecordingScreen({this.currentUser, this.preferences, this.isVideo=false});

  @override
  _CustomVideoRecordingScreenState createState() =>
      _CustomVideoRecordingScreenState();
}

class _CustomVideoRecordingScreenState
    extends State<CustomVideoRecordingScreen>  with SingleTickerProviderStateMixin,WidgetsBindingObserver {
  late final CameraController cameraController;
  bool _isFlashOn=false;

  bool _isRecording = false;
  late VideoPlayerController _videoPlayerController;
  bool _videoPlayerInitialized = false;
  UserModel? user;
  int? videoCount = 0;
  bool following = false;
  TextEditingController postContent = TextEditingController();
  bool isMusicSelected=false;
  String selectedMusicURL='';




  MusicController musicController= Get.put(MusicController());
  String? uploadPhoto;
  ParseFileBase? parseFile;
  ParseFileBase? parseFileThumbnail;
  bool? isVideo = false;
  File? videoFile;
  int selectedDuration = 30; // Default selected duration in seconds
  final AudioPlayer player = AudioPlayer();
  final AudioPlayer player2 = AudioPlayer();
  final List<int> durations = [15, 30, 60];
  late final List<String> _filterList ;
  late TabController tabController;
  final String _assetEffectsPath = 'assets/effects/';
  final String _assetEffectsImagePath = 'assets/effects/effect_image/';
  Utils utils= Utils();
  late final cameras ;
  bool isIntialized=false;
  bool isImageReady=false;
  bool isVideoChosen=false;
  num _selectedCameraIdx = 0;
  List<File> imageList=[];// You can change this index to select a different camera







  Future<void>  intializeVideoPlayer()   async {

  await _videoPlayerController.initialize();
  // _videoPlayerController.setVolume(9.8);

}

  Future<void> _toggleCamera() async {
    if (cameraController != null) {
      isIntialized=false;

      await cameraController.dispose().then((value) {
        setState(() {
          _selectedCameraIdx = (_selectedCameraIdx + 1) % cameras.length;
          _initializeCamera();
        });

      });
    }


  }


  @override
  void initState() {
    super.initState();
    isVideoChosen=widget.isVideo;
    WidgetsBinding.instance.addObserver(this);


    _getAvailableCameras();
    intializeVideoPlayer();
    tabController=TabController(length: 4, vsync: this);

  }

  @override
  void dispose() {
    musicController.progressValue.value=0.0;
    musicController.selectedAudioName.value='';
    tabController.dispose();
    cameraController.dispose();
    // _videoPlayerController.pause();
    if(_videoPlayerInitialized){
      _videoPlayerController.dispose();
    }
    player.stop();
    player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    player2.dispose();
    postContent.dispose();

    _timer?.cancel();
    _timer2?.cancel();
    _timer3?.cancel();


    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // final CameraController? controller = cameraController;
    // final CameraController? controller = cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }


  Future<void> _loadAudio(String url) async {
     await player.setUrl(url);  //load a url in audio player
  }

  Future<void> _loadAudio2(String url) async {
     await player2.setUrl(url);  //load a url in audio player
  }

  Future<void> _getAvailableCameras() async {
    cameras = await availableCameras();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // cameras =  await availableCameras();
    cameraController = CameraController( cameras[_selectedCameraIdx], ResolutionPreset.medium);


    cameraController.initialize().whenComplete((){

      setState(() {
        isIntialized=true;

      });


    });
  }




  Future<void> _playMusic()  async {

    await player.setLoopMode(LoopMode.all);
    await player.play();
  }

  Future<void> _stopMusic()  async {
        await player.stop();
  }

  Future<void> takePhoto() async {
    try {
      final photoPath= await cameraController.takePicture();
     _pickFile(setState, File(photoPath.path));
    }
    catch(e){

        }
  }

  Future<void> _startRecording() async {

    try {
      await cameraController.startVideoRecording();
      _playMusic();
      setState(() {
        _isRecording = true;
      });
      _startProgressAnimation(selectedDuration==15? 15000: selectedDuration== 30 ? 30000 : 60000);
      startTimer(selectedDuration== 15? 15: selectedDuration== 30 ? 30 : 60);
      Timer.periodic(Duration(seconds: selectedDuration== 15? 15: selectedDuration== 30 ? 30 : 60), (timer) {
        _stopRecording();
        timer.cancel();
      });
    } catch (e) {
      print("Error starting video recording: $e");
    }
  }

  Future<void> _stopRecording() async {

    _timer2?.cancel();
    _timer3?.cancel();
    // musicController.progressValue.value=0.0;
    _stopMusic();

    print('_stopRecording 1');

    try {
      final videoPath = await cameraController.stopVideoRecording();

      setState(() {
        _isRecording = false;
        _videoPlayerController =
            VideoPlayerController.file(File(videoPath.path));
        _videoPlayerController.initialize().then((_) {
          setState(() {
            _videoPlayerInitialized = true;
            _pickFile(setState, File(videoPath.path));
            // _videoPlayerController.play();
          });
        }).onError((error, stackTrace) {
          print("error$error");

        });
      });

      print('_stopRecording 2');

    } catch (e) {
      print("Error stopping video recording: $e");
    }
  }
  _pickFile2(StateSetter setState) async {

    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: isVideoChosen ? 1 : 4,
        //gridCount: 3,
        requestType: isVideoChosen ? RequestType.video : RequestType.image ,
        //pickerTheme: themeDataPicker(kPrimaryColor, light: !QuickHelp.isDarkModeNoContext()),
      ),
    );

    if (result != null && result.length > 0) {

      if(isVideoChosen){
        final File? file = await result.first.file;
        final preview = await result.first.thumbnailData;
        isVideo = true;
        print('Selected file is video $isVideo');
        //uploadVideo(file.path, preview!, setState);
        prepareVideo(file!,  setState);
      }
      else{
        await Future.forEach(result, (AssetEntity item) async {
          File? fileImage = await item.file ;
          imageList.add(fileImage!);
        });
        isVideo = false;
        imageList.length==1? cropPhoto(imageList.first.path, false):
        prepareImage(imageList, setState,usingCrop: false);
        print('Selected file is video $isVideo');
      }


    }
  }

  prepareVideo(File file,  StateSetter setState) async {
    VideoEditorModel? videoEditorModel =
    await QuickHelp.goToNavigatorScreenForResult(
        context, VideoEditorScreen(file: file));

    if (videoEditorModel != null) {

      videoFile = videoEditorModel.getVideoFile();

      parseFileThumbnail =
          ParseFile(File(videoEditorModel.coverPath!), name: "thumbnail.jpg");
      setState(() {
        uploadPhoto = videoEditorModel.coverPath!;
      });


      Navigator.pop(context, {'uploadPhoto': uploadPhoto, 'videoFile':videoFile, 'parseFileThumbnail':parseFileThumbnail, "isVideo": true});

    }
  }



  _pickFile(StateSetter setState, File? file,) async {


      String? mimeStr = lookupMimeType(file!.path);   // tell computer what kind of file is inside
      var fileType = mimeStr!.split('/'); //After this line of code, fileType will contain a list of strings with two elements, where fileType[0] will represent the primary type (e.g., "image") and fileType[1] will represent the subtype (e.g., "jpeg") of the MIME type.

      print('Selected file type $fileType');

      if (fileType.contains("video")) {
        isVideo = true;
        print('Selected file is video $isVideo');
        prepareVideo(file, setState);
      } else if (fileType.contains("image")) {
        isVideo = false;
        cropPhoto(file.path, false);

        print('Selected file is video $isVideo');

      }

  }


  prepareImage(List<File> file,  StateSetter setState,{bool usingCrop=true}){
    print('prepareImage');

    List<ParseFileBase> parseFileThumbnailList=[];

    file.forEach((File item) {
      parseFileThumbnailList.add(ParseFile(item, name: "image.jpg"));
    });

    List filePath=[];

    file.forEach((File item) {
      filePath.add(item.path);
    });

    if(usingCrop){
      Navigator.pop(context);
    }
    Navigator.pop(context, { 'uploadPhotoList': filePath ,'parseFileThumbnailList':parseFileThumbnailList, "isVideo": false, });


  }

  void cropPhoto(String path, bool isAvatar) async {
    QuickHelp.showLoadingDialog(context);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatioPresets: [
          isAvatar == true ? CropAspectRatioPreset.square : CropAspectRatioPreset.ratio16x9,
        ],
        //maxHeight: 480,
        //maxWidth: 740,
        aspectRatio: isAvatar == true ? CropAspectRatio(ratioX: 4, ratioY: 4) : CropAspectRatio(ratioX: 3, ratioY: 3),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "edit_photo",
              toolbarColor: hPrimaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio:  CropAspectRatioPreset.ratio3x2 ,
              lockAspectRatio: false),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ]);

    if (croppedFile != null) {


      compressImage(croppedFile.path, isAvatar);

    } else {
      QuickHelp.hideLoadingDialog(context);

      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "crop_image_scree.cancelled_by_user".tr(),
        message: "crop_image_scree.image_not_cropped_error".tr(),
      );

      return;
    }
  }

  void compressImage(String path, bool isAvatar) {

    QuickHelp.showLoadingAnimation();

    Future.delayed(Duration(seconds: 1), () async{
      var result = await QuickHelp.compressImage(path);

      if(result != null){


        File parseFile= File(result.absolute.path);

        List<File> fileList=[];
        fileList.add(parseFile);
        prepareImage(fileList, setState);





      } else {

        QuickHelp.hideLoadingDialog(context);

        QuickHelp.showAppNotificationAdvanced(
          context: context,
          title: "crop_image_scree.cancelled_by_user".tr(),
          message: "crop_image_scree.image_not_cropped_error".tr(),
        );
      }
    });

  }




  double _progressValue=0;
  int _elapsedTime = 0;


  int _secondsRemaining = 0;
  Timer? _timer;
  Timer? _timer2;
  Timer? _timer3;

  void startTimer(int seconds) {
    musicController.secondsRemaining.value = seconds;
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (musicController.secondsRemaining.value  > 0) {
          musicController.secondsRemaining.value --;
        } else {
          _timer!.cancel();
        }

    });
  }

  void _startProgressAnimation(double totalTime) {
    const double updateInterval = 16;
    musicController.progressValue.value=0.0;// Update interval in milliseconds (60 FPS)

    double progressIncrement = updateInterval /
        totalTime;


    int updates = (totalTime / updateInterval)
        .ceil(); // Calculate the number of updates needed

    int currentUpdate = 0;

    _timer3 =
        Timer.periodic(Duration(milliseconds: updateInterval.toInt()), (timer) {
          currentUpdate++;

            if (currentUpdate <= updates) {
              musicController.progressValue.value += progressIncrement;

            } else {
              musicController.progressValue.value =
              1.0; // Ensure the progress reaches 1.0 at the end
              timer.cancel();
              _timer3!.cancel();
            }

        });
  }

  Future<void> _toggleFlashlight() async {
    try {
      if (_isFlashOn) {
        await cameraController.setFlashMode(FlashMode.off);
      } else {
        await cameraController.setFlashMode(FlashMode.torch);
      }
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      print('Error toggling flashlight: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarBrightness: Brightness.light
    ));
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;


    if (!isIntialized) {
      return QuickHelp.appLoadingDino(context,showText: false);
    }
    else{
      return SafeArea(
        child: Scaffold(
            body:  Container(
              color: Colors.black,
              height: Adaptive.h(100),
              width: Adaptive.w(100),
              child: Stack(
                children: [

                  Container(
                    height: Adaptive.h(100),
                    width: Adaptive.w(100),
                    child: AspectRatio(
                      aspectRatio: cameraController.value.aspectRatio,
                      child: _videoPlayerInitialized
                          ? Stack(
                        children: [

                          Center(
                            child: AspectRatio(
                                aspectRatio: 0.55,
                                child: VideoPlayer(_videoPlayerController)),
                          ),


                        ],
                      )
                          :  CameraPreview(cameraController),
                    ),
                  ),
                  _videoPlayerInitialized
                      ? Container()
                      : Container(
                    width: Adaptive.w(100),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(height: 17*fem,),
                      Visibility(
                        visible: isVideoChosen,
                        child: Obx((){
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 16*fem),
                              child: LinearProgressIndicator(
                              value: musicController.progressValue.value,
                              minHeight: 7.5,
                              backgroundColor: Colors.white.withOpacity(0.25),
                              valueColor: AlwaysStoppedAnimation<Color>(hPrimaryColor),
                    ),
                            );
                          }
                        ),
                      ),
                        SizedBox(height: 41-17*fem,),
                        Container(
                          // frame53011sbw (5:17222)
                          margin: EdgeInsets.fromLTRB(16*fem, 0*fem, 16*fem, 25.99*fem),
                          padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 2.25*fem, 0*fem),
                          height: 32*fem,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child:  Container(
                                  // frame52960Aqw (5:17223)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 87.5*fem, 0*fem),
                                  width: 15*fem,
                                  height: 15*fem,
                                  child: Image.asset(
                                    'assets/reels/frame-52960.png',
                                    width: 15*fem,
                                    height: 15*fem,
                                  ),
                                ),
                              ),
                              !isVideoChosen? Expanded(child: SizedBox()): SizedBox(),
                              Visibility(
                                visible: isVideoChosen,
                                child: InkWell(
                                  onTap:(){
                                    musicBottomSheet(context,tabController, 200,
                                        200);
                                  },
                                  child: Container(
                                    // frame53010Ge5 (5:17225)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 85.25*fem, 0*fem),
                                    padding: EdgeInsets.fromLTRB(10*fem, 6*fem, 10*fem, 6*fem),
                                    width: 129*fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration (
                                      color: Color(0x3fffffff),
                                      borderRadius: BorderRadius.circular(100*fem),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // mingcutemusiclinej1s (5:17227)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                            width: 20*fem,
                                            height: 20*fem,
                                            child: Image.asset(
                                              'assets/reels/mingcute-music-line.png',
                                              width: 20*fem,
                                              height: 20*fem,
                                            ),
                                          ),
                                          Text(
                                            musicController.selectedAudioName.value==''?"Select Music":musicController.selectedAudioName.value,
                                            style: SafeGoogleFont (
                                              'DM Sans',
                                              fontSize: 14*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2857142857*ffem/fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !_isRecording,
                                child: InkWell(
                                  onTap: _toggleFlashlight,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.75*fem),
                                    width: 19.99*fem,
                                    height: 20.01*fem,
                                    child: Image.asset(
                                      'assets/reels/fluent-flash-off-24-regular.png',
                                      width: 19.99*fem,
                                      height: 20.01*fem,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _isRecording,
                                child: Container(
                                  // phcamerarotateYED (5:17232)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.75*fem),
                                  width: 19.5*fem,
                                  height: 17.25*fem,

                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(child: SizedBox()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            _isRecording ? Visibility(
                              visible: isVideoChosen,
                              child: Obx(() {
                                  return Text(
                                    "00 : ${musicController.secondsRemaining.value}",
                                    style: TextStyle(fontSize: 13,color: Color(0xfffffffb),fontWeight: FontWeight.bold),
                                  );
                                }
                              ),
                            ): Visibility(
                                visible: isVideoChosen,
                                child: slider(fem,ffem)) ,
                            SizedBox(height: 14,),
                            GestureDetector(
                              onTap: (){isVideoChosen ? _isRecording ? _stopRecording() : _startRecording(): takePhoto();},
                              child:
                              Container(
                                // autogroupywahM77 (QruunyV8Kmk36xkg7jywaH)
                                margin: EdgeInsets.fromLTRB(28*fem, 0*fem, 27*fem, 0*fem),
                                width: double.infinity,
                                height: 62*fem,
                                child: Row(
                                  mainAxisAlignment: _isRecording? MainAxisAlignment.center :MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: !_isRecording,
                                      child: InkWell(
                                        onTap: _toggleCamera,
                                        child: Container(
                                          // frame53015USd (5:17252)
                                          padding: EdgeInsets.fromLTRB(17*fem, 4.03*fem, 1*fem, 0*fem),
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconparkoutlineeffectsQLH (5:17253)
                                                margin: EdgeInsets.fromLTRB(0.45*fem, 0*fem, 0*fem, 7.48*fem),
                                                width: 34.87*fem,
                                                height: 34.48*fem,
                                                child: Image.asset(
                                                  // 'assets/reels/icon-park-outline-effects.png',
                                                  'assets/reels/ph-camera-rotate.png',
                                                  width: 34.87*fem,
                                                  height: 34.48*fem,
                                                ),
                                              ),
                                              Text(
                                                // effectsuXw (5:17255)
                                                'Flip',
                                                style: SafeGoogleFont (
                                                  'DM Sans',
                                                  fontSize: 12*ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.3333333333*ffem/fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _isRecording? 70*fem:72*fem,
                                    ),
                                    Container(
                                      // group52958diq (5:17246)
                                      width: 60*fem,
                                      height: 60*fem,
                                      child: Image.asset(
                                        'assets/reels/group-52958.png',
                                        width: 60*fem,
                                        height: 60*fem,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 72*fem,
                                    ),
                                    Visibility(
                                      visible: !_isRecording,
                                      child: InkWell(
                                        onTap: () async {
                                          await utils.checkPermission(context,_pickFile2(setState),setState);
                                        },
                                        child: Container(
                                          // frame53014Z6h (5:17249)
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // rectangle19659WXj (5:17250)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                                width: 42*fem,
                                                height: 42*fem,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(4*fem),
                                                  child: Image.asset(
                                                    'assets/reels/rectangle-19659.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // uploadDww (5:17251)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
                                                child: Text(
                                                  'Upload',
                                                  style: SafeGoogleFont (
                                                    'DM Sans',
                                                    fontSize: 12*ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3333333333*ffem/fem,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 65,),
                          ],
                        ),
                      ],
                    ),
                  )

                ],
              ),
            )
        ),
      );
    }




    }


  Widget slider(double fem, double ffem){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          items: durations.map((duration) {
            return Builder(
              builder: (BuildContext context) {
                final isSelected = duration == selectedDuration;
                print(selectedDuration);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDuration = duration;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    width: isSelected ? 55.0 : 51.0,
                    height: isSelected ? 15.0 : 20.0,
                    padding: EdgeInsets.all(isSelected ? 4.0 : 0.0),
                    margin: EdgeInsets.symmetric(vertical:isSelected ? 3.0 : 0.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xffffffff): Colors.transparent,
                      // border: Border.all(
                      //   color: Colors.grey,
                      //   width: 1.0,
                      // ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: isSelected
                          ? Text(
                        '$duration sec',
                        style: SafeGoogleFont (
                          'DM Sans',
                          fontSize: 12*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.3333333333*ffem/fem,
                          color: Color(0xff1e1e1e),
                        ),
                      )
                          : Text(
                        '$duration sec',
                        style: SafeGoogleFont (
                          'DM Sans',
                          fontSize: 12*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.3333333333*ffem/fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 30.0,
            viewportFraction: 0.15,
            initialPage: durations.indexOf(selectedDuration),
            enableInfiniteScroll: false,
            reverse: false,
            onPageChanged: (index, reason) {
              setState(() {
                selectedDuration = durations[index];
              });
            },
          ),
        ),
      ],
    );




}




  Widget imageBox(int index, String path, bool isSelected){
    return Container(
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent, // Change the border color on selection
          width: 2.0, // Border width
        ),
      ),
      child: Image.asset(
        path, // Replace with your image asset path
        fit: BoxFit.cover,
      ),
    );

  }

   void musicBottomSheet(BuildContext context, TabController tabController,double height,double width){
    showModalBottomSheet(
        backgroundColor:Colors.white,
        context: context,
        isDismissible: true,
        isScrollControlled: true, // Set this property to true
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
              return Container(
                  height: MediaQuery.of(context).size.height*0.95,
                  decoration: BoxDecoration(
                      color:Colors.white,
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
                            }, icon: Icon(Icons.close)),

                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Sounds',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 16
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Icon(Icons.keyboard_arrow_down,size: 25,),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16 ),
                        child: TextField(

                          // controller: _controller,
                          onChanged: (text) {
                            // setState(() {
                            // _searchText = text;
                            // });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            labelText: 'Search',
                            hintText: 'Search for something...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            enabledBorder: OutlineInputBorder(

                              borderSide: BorderSide(
                                  color: Colors.transparent
                              ),

                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                      ),
                      TabBar(
                        // indicatorWeight: 1.5,
                indicatorSize: TabBarIndicatorSize.label,
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        controller: tabController ,
                        tabs: [
                          Tab(text: 'For You',),
                          Tab(text: 'Favorites'),
                          Tab(text: 'More'),
                          Tab(text: 'Sounds'),
                        ],
                      ),
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
                                                                _loadAudio2(
                                                                    musicModel
                                                                        .getAudioFile!.url!);
                                                                player2.play();
                                                                musicController
                                                                    .togglePlayItemPressed(
                                                                    index);



                                                              }
                                                              else {
                                                                player2.pause();
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
                                                  Text(musicModel.getAudioName!, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                                  Text(musicModel.getSingerName?? "",style: TextStyle(fontSize: 12),),
                                                  Text('00:60',style: TextStyle(fontSize: 12),),
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

                                                  _loadAudio(musicModel.getAudioFile!.url!).then((value) {
                                                    musicController.itemPressed[index].value=false;
                                                    isMusicSelected=true;
                                                    selectedMusicURL=musicModel.getAudioFile!.url!;
                                                    musicController.selectedAudioName.value= musicModel.getAudioName!;

                                                  });

                                                },
                                                child: Container(
                                                  width: 65,
                                                  height: 38,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
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

          if(player2.playing){
            player2.pause();
          }
          player2.stop();
          musicController.isPlaying= List.generate(15, (index) => false.obs);
          // print(musicController.isPlaying);



    });

  }



}







