import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/permission/choose_photo_permission.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../view_model/live_controller.dart';
import '../../../../widgets/app_text_field_streamer.dart';
import '../../single_live_streaming/single_streamer_live/single_live_screen/widgets/privacy_sheet.dart';
import '../../single_live_streaming/single_streamer_live/single_live_screen/widgets/tags_sheet.dart';



class LiveViewTopMenu extends StatelessWidget {
  final CameraController cameraController;
  LiveViewTopMenu({Key? key, required this.cameraController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final LiveViewModel liveViewModel= Get.find();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.black.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
        child: Column(
          children: [
            Row(
              children: [
                GetBuilder<LiveViewModel>(
                    init: liveViewModel,
                    builder: (controller) {
                      return GestureDetector(
                        onTap: ()=> PermissionHandler.checkPermission(false, context,liveStreamingFile: true),
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: controller.liveStreamingModel.getImage==null ? DecorationImage(
                              image:  NetworkImage(Get.find<UserViewModel>().currentUser.getAvatar!.url!) ,
                              fit: BoxFit.cover,
                            ) : DecorationImage(
                              image:  NetworkImage(controller.liveStreamingModel.getImage!.url!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: AppColors.black.withOpacity(0.4),
                                ),
                                child: Center(
                                  child: Text(
                                    'Add Image',
                                    style: sfProDisplayRegular.copyWith(fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints( maxHeight: 40),
                        width: 350.w,
                        child: AppTextFormSField(
                          controller: _titleController,
                          onChanged: (value) {
                            if(value!=null){
                              liveViewModel.title.value=value;
                            }
                            return null;
                          },
                          validator: (value) {},
                          hintText: 'Add a title to chat',
                          borderRadius: 0,
                          fillColor: AppColors.black.withOpacity(0.0),
                        ),
                      ),
                      Obx(() {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    backgroundColor: AppColors.grey500,
                                    builder: (context) => PrivacySheet(),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.grey300.withOpacity(0.6),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.groups, size: 20, color: AppColors.white),
                                      const SizedBox(width: 6),
                                      Obx(() {
                                        return Text(
                                          liveViewModel.mode.value,
                                          style: sfProDisplayRegular.copyWith(
                                            fontSize: 13,
                                            color: AppColors.white,
                                          ),
                                        );
                                      }
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.white),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Obx(() {
                                  return Visibility(
                                    visible : liveViewModel.selectedLiveType.value != LiveStreamingModel.keyTypeAudioLive,
                                    child: GestureDetector(
                                      onTap:()=> liveViewModel.toggleCamera(cameraController),
                                      child: Obx(() {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 1.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: AppColors.grey300.withOpacity(0.6),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(7.0),
                                                  child: Image.asset(AppImagePath.cameraOff,fit: BoxFit.cover, color: liveViewModel.isCameraOn.value == false ? AppColors.yellowColor.withOpacity(0.9) : null,),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                    ),
                                  );
                                }
                              ),
                              Spacer(),
                              if(liveViewModel.tagList.length==0)
                              SizedBox(width: 5),
                              if(liveViewModel.tagList.length==0)
                                GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    backgroundColor: AppColors.grey500,
                                    builder: (context) => const TagsSheet(),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                                  child: Icon(Icons.keyboard_arrow_down_rounded, size: 13, color: AppColors.white),
                                ),
                              ),
                            ],
                          );
                        }
                      ),
                      const SizedBox(height: 8),
                      Obx((){
                        return Row(
                          children: [
                            ...List.generate(
                              liveViewModel.tagList.length>2 ? 2 : liveViewModel.tagList.length,
                                  (index) =>  Container(
                                margin: EdgeInsets.only(right: 4.w),
                                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.grey300.withOpacity(0.6),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      liveViewModel.tagList[index],
                                      style: sfProDisplayRegular.copyWith(
                                        fontSize: 13,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            if(liveViewModel.tagList.length!=0)
                            GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  backgroundColor: AppColors.grey500,
                                  builder: (context) => const TagsSheet(),
                                );
                              },
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: AppColors.grey300.withOpacity(0.6),
                                child: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 20),
                              ),
                            ),

                          ],
                        );
                      }
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: AppColors.grey300),
            Row(
              children: [
                Text(
                  'Share to',
                  style: sfProDisplayRegular.copyWith(
                    fontSize: 13,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: Image.asset(AppImagePath.instagram, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: Image.asset(AppImagePath.facebook, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: Image.asset(AppImagePath.whatsapp, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: const Icon(Icons.more_horiz, color: Colors.white, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addTagContainer(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.grey300.withOpacity(0.6),
      ),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Text(
            'Add Tag',
            style: sfProDisplayRegular.copyWith(
              fontSize: 13,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.white),
        ],
      ),
    );
  }
}