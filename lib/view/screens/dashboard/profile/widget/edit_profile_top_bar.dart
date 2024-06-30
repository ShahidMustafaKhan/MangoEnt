import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:teego/view_model/gender_controller.dart';
import 'package:teego/view_model/streamer_profile_controller.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/permission/choose_photo_permission.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/edit_controller.dart';
import '../../../../../view_model/relationship_status_controller.dart';

class EditProfileTopBar extends StatelessWidget {
  const EditProfileTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();
    final EditController editController = Get.find();
    final StreamerProfileController profileController = Get.find();
    final GenderController genderController = Get.find();
    final RelationshipStatusController relationStatusController =
    Get.find();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()=> Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  Text(
                    "Edit",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () async {
                      QuickHelp.showLoadingDialog(context);
                      if(editController.bioEditingController.text.isNotEmpty)
                        userViewModel.currentUser.setBio = editController.bioEditingController.text;
                      if(editController.nameEditingController.text.isNotEmpty)
                        userViewModel.currentUser.setFullName = editController.nameEditingController.text;
                        userViewModel.currentUser.setFirstName = editController.nameEditingController.text.split(' ')[0];
                        if(editController.nameEditingController.text.split(' ').length>1){
                        userViewModel.currentUser.setLastName = editController.nameEditingController.text.split(' ')[1];}
                      if(editController.selectedDate.value.isNotEmpty)
                        userViewModel.currentUser.setBirthday = DateTime.parse(editController.selectedDate.value);
                      if(genderController.selectedGender.value.isNotEmpty)
                        userViewModel.currentUser.setGender = genderController.selectedGender.value;
                      if(relationStatusController.selectedStatus.value.isNotEmpty)
                        userViewModel.currentUser.setRelationshipStatus = relationStatusController.selectedStatus.value;

                      ParseResponse parseResponse = await userViewModel.currentUser.save();
                      if(parseResponse.success){
                        if(parseResponse.results!=null){
                          userViewModel.currentUser = parseResponse.results!.first as UserModel ;
                          userViewModel.update() ;
                          profileController.profile = userViewModel.currentUser;
                          profileController.update();

                          QuickHelp.hideLoadingDialog(context);
                        }
                      }
                      else
                        QuickHelp.hideLoadingDialog(context);

                    },
                    child: Text(
                      "SAVE",
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Text(
                    "Image",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Tap to edit up to 9 images",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      PermissionHandler.checkPermission(true, context);
                    },
                    child: Container(
                      width: 88.w,
                      height: 88.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.yellowBtnColor, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(44.r),
                        child: Image.network(
                          userViewModel.currentUser.getAvatar!.url!,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) {
                              ParseFileBase? avatar;
                              if(index==0)
                                avatar = userViewModel.currentUser.getAvatar1;
                              else if(index==1)
                                avatar = userViewModel.currentUser.getAvatar2;
                              else if(index==2)
                                avatar = userViewModel.currentUser.getAvatar3;
                             else
                                avatar = userViewModel.currentUser.getAvatar4;
                              return GestureDetector(
                              onTap: ()=> PermissionHandler.checkPermission(true, context, avatarNumber: index+1),
                              child: Container(
                                width: 36.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.white),
                                ),
                                child:
                                avatar==null ?
                                Center(child: Icon(Icons.add)) : ClipRRect(
                                  borderRadius: BorderRadius.circular(44.r),
                                  child: Image.network(
                                    avatar.url!,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                            }
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) {
                              ParseFileBase? avatar;
                              if(index==0)
                                avatar = userViewModel.currentUser.getAvatar5;
                              else if(index==1)
                                avatar = userViewModel.currentUser.getAvatar6;
                              else if(index==2)
                                avatar = userViewModel.currentUser.getAvatar7;
                              else
                                avatar = userViewModel.currentUser.getAvatar8;
                              return GestureDetector(
                                onTap: ()=> PermissionHandler.checkPermission(true, context, avatarNumber: index+5),
                                child: Container(
                                width: 36.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.white),
                                ),
                                child: avatar==null ?
                                Center(child: Icon(Icons.add)) : ClipRRect(
                                borderRadius: BorderRadius.circular(44.r),
                                child: Image.network(
                                avatar.url!,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                ),
                            )),
                              );}
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    "Video",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Unlock at Lv 6",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 88.w,
                    height: 88.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.yellowBtnColor, width: 2)),
                    child: Center(child: Icon(Icons.play_arrow)),
                  ),
                  Container(
                    width: 88.w,
                    height: 88.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2)),
                    child: Center(child: Icon(Icons.play_arrow)),
                  ),
                  Container(
                    width: 88.w,
                    height: 88.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2)),
                    child: Center(child: Icon(Icons.play_arrow)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
