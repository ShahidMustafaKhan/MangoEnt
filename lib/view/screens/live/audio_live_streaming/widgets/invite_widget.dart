import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/popular_controller.dart';

import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../widgets/custom_buttons.dart';

class InviteWidget extends StatefulWidget {


  const InviteWidget();

  @override
  State<InviteWidget> createState() => _InviteWidgetState();
}

class _InviteWidgetState extends State<InviteWidget> {
  LiveViewModel liveViewModel = Get.find();
  bool seeMore = false;
  int selectedIndex = -1 ;
  bool liveListSelected = false;

  @override
  void initState() {
    liveViewModel.peopleWhoAreLive();
    liveViewModel.peopleWhoAreFriends();
    super.initState();
  }

  onSelect(int index, bool value) {
    setState(() {
      selectedIndex = index;
      liveListSelected = value;
    });
}



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<LiveViewModel>(
            init: liveViewModel,
            builder: (controller) {
              return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Friends (${liveViewModel.friendsList.length})',
                  style: sfProDisplayBold.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child:Column(
                      children: [
                        if(liveViewModel.friendsList.isEmpty)
                          Container(
                            height: 50.h,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                                  Text("Nothing is here", style: sfProDisplayMedium.copyWith(
                                    fontSize: 14.sp,
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ...List.generate(
                          liveViewModel.friendsList.length<=2 ? liveViewModel.friendsList.length : seeMore==false ? 3 : liveViewModel.friendsList.length ,
                              (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage: NetworkImage(liveViewModel.friendsList[index].getAvatar!.url!),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(liveViewModel.friendsList[index].getFullName ?? ''),
                                        const SizedBox(width: 16),
                                        if(liveViewModel.friendsList[index].getHideMyLocation == false)
                                        SvgPicture.asset(
                                          QuickActions.getCountryFlag(liveViewModel.friendsList[index]),
                                          width: 24,
                                          height: 17,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'id: ${liveViewModel.friendsList[index].getUid}',
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
                                GestureDetector(
                                  onTap: () => onSelect(index, false),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.white.withOpacity(0.7),
                                          width: 2),
                                      color: selectedIndex == index && liveListSelected==false
                                          ? AppColors.yellowColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if(liveViewModel.friendsList.length>2)
                          InkWell(
                            onTap:(){
                              seeMore=!seeMore;
                              setState(() {
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  seeMore==false ? 'see more' : 'see less',
                                  style: sfProDisplayBold.copyWith(
                                      fontSize: 13,
                                      color: AppColors.white.withOpacity(0.7)),
                                ),
                                Icon(seeMore==false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                              ],
                            ),
                          ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'People who are live',
                              style: sfProDisplayBold.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        if(liveViewModel.liveUsers.isEmpty)
                          Container(
                            height: 50.h,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                                  Text("No User is live", style: sfProDisplayMedium.copyWith(
                                    fontSize: 14.sp,
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ...List.generate(
                          liveViewModel.liveUsers.length,
                              (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              children: [
                                Stack(children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: AppColors.grey300,
                                    backgroundImage:
                                    NetworkImage(liveViewModel.liveUsers[index].getAvatar!.url!),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 10.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ]),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(liveViewModel.liveUsers[index].getFullName ?? ''),
                                        const SizedBox(width: 16),
                                        if(liveViewModel.liveUsers[index].getHideMyLocation == false)
                                        SvgPicture.asset(
                                          QuickActions.getCountryFlag(liveViewModel.liveUsers[index]),
                                          width: 24,
                                          height: 17,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'id: ${liveViewModel.liveUsers[index].getUid}',
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
                                GestureDetector(
                                  onTap: () => onSelect(index, true),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.white.withOpacity(0.7),
                                          width: 2),
                                      color: selectedIndex == index && liveListSelected==true
                                          ? AppColors.yellowColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: PrimaryButton(
              title: 'Invite',
              borderRadius: 35,
              textStyle: sfProDisplayBold.copyWith(
                  fontSize: 16, color: AppColors.black),
              bgColor: AppColors.yellowBtnColor,
              onTap: () {
                if(selectedIndex!= -1)
                Get.back();
                else
                  QuickHelp.showAppNotificationAdvanced(title: "Please select a user", context: context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
