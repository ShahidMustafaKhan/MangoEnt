import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/streamer_live_preview/audio_live/audio_streamer_live.dart';
import 'package:teego/view/screens/live/streamer_live_preview/live_preview_screen.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/room_announcement.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view/screens/splash_screen.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/live_controller.dart';
import 'language_card.dart';
import 'live_view_top_menu.dart';



class LiveBottomCard extends StatelessWidget {
  final LiveBottomCardController liveCardController = Get.put(LiveBottomCardController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      await Future.delayed(const Duration(seconds: 5));
      SystemChrome.restoreSystemUIOverlays();
    });

    LiveViewModel liveViewModel = Get.put(LiveViewModel(ZegoLiveRole.host, null));

    return BaseScaffold(
      body: Obx(() {
        if (liveCardController.cameraReady.value && !liveCardController.hideNavigator.value) {
          liveCardController.hideNavigator.value = true;
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
        }
        return !liveCardController.cameraReady.value
            ? SplashScreen()
            : Stack(
          children: [
            liveCardController.streamView[liveCardController.selectedTab.value],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  RoomAnnouncementCard(),
                  const SizedBox(height: 16),
                  LiveViewTopMenu(),
                  const SizedBox(height: 4),
                  if (liveCardController.selectedTab.value == 1) LanguageCard(),
                  const Spacer(),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Image.asset(AppImagePath.makeup, width: 30, height: 30),
                      const SizedBox(width: 40),
                      Expanded(
                        child: PrimaryButton(
                          title: 'Go Live',
                          borderRadius: 35,
                          bgColor: AppColors.yellowBtnColor,
                          onTap: () {
                            Get.find<LiveViewModel>().createLive(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          liveCardController.bottomTab.length,
                              (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: GestureDetector(
                              onTap: () {
                                liveCardController.setSelectedTab(index);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    liveCardController.bottomTab[index],
                                    style: sfProDisplayMedium.copyWith(
                                      fontSize: liveCardController.selectedTab.value == index ? 16.sp : 14.sp,
                                      color: liveCardController.selectedTab.value == index
                                          ? AppColors.white
                                          : AppColors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  CircleAvatar(
                                    backgroundColor: liveCardController.selectedTab.value == index ? Colors.white : Colors.transparent,
                                    radius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class LiveBottomCardController extends GetxController {
  final List<String> bottomTab = [
    'Multi-guest Live',
    'Live',
    'Audio Live',
    'Game Live',
  ];

  final RxInt selectedTab = 1.obs;
  late final CameraController cameraController;

  final RxBool cameraReady = false.obs;
  final RxBool hideNavigator = false.obs;
  final List<Widget> streamView = [];

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    await cameraController.initialize();
    cameraReady.value = true;

    streamView.addAll([
      Center(child: Text("Multi-Guest Live")),
      LivePreviewScreen(cameraController: cameraController),
      Center(child: AudioStreamerLive()),
      Center(child: Text("Game Live")),
    ]);
  }

  void setSelectedTab(int index) {
    selectedTab.value = index;
  }
}







// class LiveBottomCard extends StatefulWidget {
//   const LiveBottomCard();
//
//   @override
//   State<LiveBottomCard> createState() => _LiveBottomCardState();
// }
//
// class _LiveBottomCardState extends State<LiveBottomCard> {
//
//   late final CameraController cameraController;
//
//
//   int selectedTab = 1;
//   final StreamBottomCardViewModel controller = Get.put(StreamBottomCardViewModel());
//
//
//
//   final RxBool cameraReady=false.obs;
//
//   final RxBool hideNavigator=false.obs;
//
//   Future<void> initializeCamera() async {
//     final cameras =  await availableCameras();
//     cameraController = CameraController(cameras[1], ResolutionPreset.medium);
//     cameraController.initialize().whenComplete((){
//
//       cameraReady.value=true;
//
//     });
//     streamView = [
//       Center(child: Text("Multi-Guest Live"),),
//       LivePreviewScreen(cameraController: cameraController,),
//       Center(child: Text("Audio Live"),),
//       Center(child: Text("Game Live"),),
//     ];
//   }
//
//
//   List<Widget> streamView = [];
//
//   @override
//   void initState() {
//     initializeCamera();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
//       await Future.delayed(const Duration(seconds: 5));
//       SystemChrome.restoreSystemUIOverlays();
//     });
//     LiveViewModel liveViewModel=Get.put(LiveViewModel(ZegoLiveRole.host, null));
//     // initializeCamera();
//     return BaseScaffold(
//       body: Obx(() {
//         if(cameraReady.value==true && hideNavigator==false){
//           hideNavigator.value=true;
//           SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
//         }
//         return !cameraReady.value ?  SplashScreen() : Stack(
//           children: [
//             streamView[selectedTab],
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 45),
//                   RoomAnnouncementCard(),
//                   const SizedBox(height: 16),
//                   LiveViewTopMenu(),
//                   const SizedBox(height: 4),
//                   if(selectedTab == 1)
//                   LanguageCard(),
//                   const Spacer(),
//                   Row(
//                     children: [
//                       const SizedBox(width: 20),
//                       Image.asset(AppImagePath.makeup, width: 30, height: 30),
//                       const SizedBox(width: 40),
//                       Expanded(
//                         child: PrimaryButton(
//                           title: 'Go Live',
//                           borderRadius: 35,
//                           bgColor: AppColors.yellowBtnColor,
//                           onTap: () {
//                             Get.find<LiveViewModel>().createLive(context);
//                             // Get.toNamed(AppRoutes.streamerSingleLivePreview);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ...List.generate(
//                           controller.bottomTab.length,
//                               (index) => Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 12.w),
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedTab = index;
//                                 });
//                               },
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     controller.bottomTab[index],
//                                     style: sfProDisplayMedium.copyWith(
//                                       fontSize: selectedTab == index ? 16.sp : 14.sp,
//                                       color: selectedTab == index ? AppColors.white : AppColors.white.withOpacity(0.7),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   CircleAvatar(
//                                     backgroundColor: selectedTab == index ? Colors.white : Colors.transparent,
//                                     radius: 4,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
//
//
// class StreamBottomCardViewModel extends GetxController {
//
//   List<String> bottomTab = [
//     'Multi-guest Live',
//     'Live',
//     'Audio Live',
//     'Game Live',
//   ];
//
//   RxInt selectedId = 0.obs;
//   RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     selectedId.value = 0;
//   }
// }
