import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view_model/live_controller.dart';

import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';


class TopGifters extends StatelessWidget {
  const TopGifters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    return Container(
      height: 500.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Top Gifters",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              height: 3.h,
              color: AppColors.grey300,
            ),
            SizedBox(
              height: 20.h,
            ),
            ...List.generate(
              liveViewModel.hostGifters.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.grey300,
                        backgroundImage: NetworkImage(liveViewModel.hostGifters[index][LiveStreamingModel.keySenderAvatar]),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              liveViewModel.hostGifters[index][LiveStreamingModel.keySenderName],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.sp),
                            ),
                            SizedBox(width: 16.w),
                            SvgPicture.asset(
                              liveViewModel.hostGifters[index][LiveStreamingModel.keySenderCountry],
                              width: 24,
                              height: 17,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text(
                              'Contribution: ${liveViewModel.hostGifters[index][LiveStreamingModel.keyCoins]
                            }',
                              style: sfProDisplayRegular.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.yellowBtnColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   width: 342.w,
            //   height: 72.h,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16.r),
            //     color: Color(0xff302F2F),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 10.w),
            //     child: Row(
            //       children: [
            //         Text(
            //           "875",
            //           style: TextStyle(
            //               fontSize: 16.sp, fontWeight: FontWeight.w600),
            //         ),
            //         SizedBox(
            //           width: 10.w,
            //         ),
            //         Container(
            //           height: 40.h,
            //           width: 40.w,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Colors.blue,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 10.w,
            //         ),
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Savannah Nguyen",
            //               style: TextStyle(
            //                   fontSize: 14.sp, fontWeight: FontWeight.w500),
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 SvgPicture.asset(AppImagePath.diamond),
            //                 SizedBox(
            //                   width: 5.w,
            //                 ),
            //                 Text(
            //                   "8811M",
            //                   style: TextStyle(
            //                       fontSize: 12.sp,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.yellowBtnColor),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           width: 20.w,
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(bottom: 20.h),
            //           child: Row(
            //             children: [
            //               SvgPicture.asset(
            //                 AppImagePath.franceFlag,
            //                 width: 24,
            //                 height: 17,
            //               ),
            //               SizedBox(
            //                 width: 20.w,
            //               ),
            //               Container(
            //                 width: 39.w,
            //                 height: 12.h,
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(19.r),
            //                     color: Color(0xff6617Af)),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Image.asset(AppImagePath.gemStone),
            //                     SizedBox(
            //                       width: 5.w,
            //                     ),
            //                     Text(
            //                       "LV.9",
            //                       style: TextStyle(
            //                           fontSize: 8.sp,
            //                           fontWeight: FontWeight.w400),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
