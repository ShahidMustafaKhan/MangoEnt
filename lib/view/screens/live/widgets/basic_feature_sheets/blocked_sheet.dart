import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../utils/constants/status.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/userViewModel.dart';
import '../../../../widgets/custom_buttons.dart';

class BlockedSheet extends StatefulWidget {
  const BlockedSheet();

  @override
  State<BlockedSheet> createState() => _BlockedSheetState();
}

class _BlockedSheetState extends State<BlockedSheet> {
  LiveViewModel liveViewModel = Get.find();

  @override
  void initState() {
    liveViewModel.blockUserList(liveViewModel.liveStreamingModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 36.h,
                        //       width: 343.w,
                        //       child: TextField(
                        //         decoration: InputDecoration(
                        //           filled: true,
                        //           fillColor: Color(0xffBCBBBE),
                        //           hintText: 'Search for username or ID',
                        //           hintStyle: TextStyle(color: Colors.black),
                        //           prefixIcon: Icon(Icons.search, color: Colors.black),
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(90.0),
                        //             borderSide: BorderSide.none,
                        //           ),
                        //           contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        if(liveViewModel.status == Status.Completed)
                          ...List.generate(
                          liveViewModel.blockList.length,
                          (index) {
                            UserModel user = liveViewModel.blockList[index] as UserModel;
                            return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage: NetworkImage(user.getAvatar!.url!),
                                ),
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
                                    liveViewModel.blockList.removeAt(index);
                                    liveViewModel.update();
                                    liveViewModel.removeBlockUser(user.getUid!);
                                  },
                                ),
                              ],
                            ),
                          );}
                        ),
                        if(liveViewModel.blockList.isEmpty && liveViewModel.status == Status.Completed)
                          Container(
                            height: 200.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                                Text("No user added to block list", style: sfProDisplayMedium.copyWith(
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
