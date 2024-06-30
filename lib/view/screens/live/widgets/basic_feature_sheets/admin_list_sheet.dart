import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../helpers/quick_actions.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../utils/constants/status.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/live_controller.dart';
import '../../../../widgets/custom_buttons.dart';

class AdminListSheet extends StatelessWidget {
  const AdminListSheet();

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    liveViewModel.getAdminList(liveViewModel.liveStreamingModel);

    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (liveViewModel) {
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(liveViewModel.status == Status.Completed)
                    ...List.generate(
                      liveViewModel.adminList.length,
                      (index) {
                        UserModel user = liveViewModel.adminList[index] as UserModel;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Row(
                            children: [
                              Stack(children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage:
                                   NetworkImage(user.getAvatar!.url!),
                                ),
                                Positioned(
                                    right: 5,
                                    bottom: 1,
                                    child: Container(
                                      width: 10.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle),
                                    ))
                              ]),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(user.getFullName!),
                                      const SizedBox(width: 16),
                                      if(user.getHideMyLocation == false)
                                        SvgPicture.asset(
                                        QuickActions.getCountryFlag(user),
                                        width: 24,
                                        height: 17,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'id: ${user.getUid}',
                                        style: sfProDisplayRegular.copyWith(
                                            fontSize: 12,
                                            color: AppColors.white.withOpacity(0.7)),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(Icons.copy,
                                          size: 15,
                                          color: AppColors.white.withOpacity(0.7)),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              PrimaryButton(
                                width: 65.w,
                                height: 32.h,
                                title: 'Remove',
                                borderRadius: 35,
                                textStyle: sfProDisplayMedium.copyWith(
                                    fontSize: 16, color: AppColors.black),
                                bgColor: AppColors.yellowBtnColor,
                                onTap: () {
                                  liveViewModel.adminList.removeAt(index);
                                  liveViewModel.update();
                                  liveViewModel.removeAdmin(user.getUid!);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    if(liveViewModel.adminList.isEmpty && liveViewModel.status == Status.Completed)
                      Container(
                        height: 200.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                            Text("No user added to admin list", style: sfProDisplayMedium.copyWith(
                              fontSize: 14.sp,

                            ),),
                          ],
                        ),
                      ),
                    if(liveViewModel.status == Status.Loading)
                      Container(
                        height: 200.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator()
                          ],
                        ),
                      ),

                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
