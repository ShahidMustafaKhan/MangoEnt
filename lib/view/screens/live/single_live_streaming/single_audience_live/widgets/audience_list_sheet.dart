import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../parse/UserModel.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../widgets/custom_buttons.dart';
import 'audience_detail_sheet.dart';

class AudienceListSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    liveViewModel.fetchViewersList();
    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (controller) {
          return SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.close, color: Colors.transparent),
                    Text(
                      'Audience',
                      style: sfProDisplaySemiBold.copyWith(fontSize: 24),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.orangeContainer,
                        AppColors.progressLinearOrangeColor1,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('Join For Exclusive Privileges', style: sfProDisplayRegular.copyWith(fontSize: 16)),
                      const Spacer(),
                      PrimaryButton(
                        width: 100,
                        height: 40,
                        title: 'Subscribe',
                        bgColor: Colors.white,
                        textStyle: sfProDisplayBold.copyWith(fontSize: 14, color: AppColors.darkPink),
                        borderRadius: 34,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(thickness: 2),
                if(liveViewModel.viewerList.isNotEmpty)
                const SizedBox(height: 20),
                if(liveViewModel.viewerList.isEmpty)
                  Container(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                        Text("No Viewers ", style: sfProDisplayMedium.copyWith(
                          fontSize: 15.sp,

                        ),),
                      ],
                ),
                    ),
                  ),
                if(liveViewModel.viewerList.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 400,
                    minHeight: 200,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: liveViewModel.viewerList.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      UserModel user = liveViewModel.viewerList[index] as UserModel;
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            backgroundColor: AppColors.grey500,
                            builder: (context) => AudienceDetailSheet(user, viewer: liveViewModel.role == ZegoLiveRole.host ? true : false,),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Row(
                            children: [
                              Text(
                                '${index + 1}',
                                style: sfProDisplaySemiBold.copyWith(
                                  fontSize: 16,
                                  color: AppColors.white.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(width: 18),
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: AppColors.yellowColor,
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage: NetworkImage(user.getAvatar!.url!),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(user.getFullName ?? ''),
                                      const SizedBox(width: 16),
                                      if(user.getHideMyLocation == false)
                                        SvgPicture.asset(
                                        QuickActions.getCountryFlag(user),
                                        width: 24,
                                        height: 17,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Image.asset(AppImagePath.audienceBadge, width: 60, height: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }
}
