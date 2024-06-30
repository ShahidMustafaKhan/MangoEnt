import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view_model/streamer_profile_controller.dart';
import '../../../../helpers/quick_actions.dart';
import '../../../../helpers/quick_help.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/userViewModel.dart';
import '../../../widgets/custom_buttons.dart';

class ReportOptionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StreamerProfileController controller = Get.find();
    UserViewModel userViewModel = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          PrimaryButton(
            width: 342.w,
            height: 59.h,
            title: 'Report',
            borderRadius: 12,
            textStyle: sfProDisplayMedium.copyWith(
                fontSize: 16, color: AppColors.white),
            bgColor: Color(0xFF363339),
            onTap: () {
              Get.toNamed(AppRoutes.chatReportScreen, arguments: controller.profile);
            },
          ),
          Container(
            width: 342.w,
            height: 0.3.h,
            color: AppColors.white,
          ),
          GetBuilder<UserViewModel>(
              init: userViewModel,
              builder: (userViewModel) {
                return
                  PrimaryButton(
                width: 342.w,
                height: 59.h,
                title: userViewModel.isUserInBlockList(controller.profile!) ? 'UnBlock' : 'Block' ,
                borderRadius: 12,
                textStyle: sfProDisplayMedium.copyWith(
                    fontSize: 16, color: AppColors.white),
                bgColor: Color(0xFF363339),
                onTap: (){
                  if(!userViewModel.isUserInBlockList(controller.profile!))
                  QuickActions.showAlertDialog(context, 'Are you sure you want to add user to block list?', (){
                    userViewModel.currentUser.setBlockedUserIds= controller.profile!.getUid!;
                    userViewModel.currentUser.save().then((value){
                      userViewModel.currentUser.update();
                      Get.back();
                      Get.back();
                      QuickHelp.showAppNotificationAdvanced(title: 'User Added to Block List!', context: context, isError: false);
                    });
                  });
                  else{
                    QuickActions.showAlertDialog(context, 'Are you sure you want to remove user from block list?', (){
                      userViewModel.currentUser.removeBlockedUserIds= controller.profile!.getUid!;
                      userViewModel.currentUser.save().then((value){
                        userViewModel.currentUser.update();
                        Get.back();
                        Get.back();
                        QuickHelp.showAppNotification(title: 'User removed from Block List!', context: context, isError: false);
                      });
                    });
                  }
                },
              );
            }
          ),
          SizedBox(
            height: 20.h,
          ),
          PrimaryButton(
            width: 342.w,
            height: 48.h,
            title: 'Cancel',
            borderRadius: 12,
            textStyle: sfProDisplayMedium.copyWith(
                fontSize: 16, color: AppColors.white),
            bgColor: AppColors.yellowBtnColor,
            onTap: () {},
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
