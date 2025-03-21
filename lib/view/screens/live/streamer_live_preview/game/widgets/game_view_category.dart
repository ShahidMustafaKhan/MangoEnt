import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/permission/choose_photo_permission.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../../view_model/live_controller.dart';
import '../../../../../widgets/app_text_field_streamer.dart';
import '../../../single_live_streaming/single_streamer_live/single_live_screen/widgets/privacy_sheet.dart';
import '../../../single_live_streaming/single_streamer_live/single_live_screen/widgets/tags_sheet.dart';

class GameViewCategory extends StatelessWidget {
  GameViewCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final LiveViewModel liveViewModel = Get.find();
    return Container(
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
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 80.h, right: 80.h),
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 40),
                          width: 350.w,
                          child: AppTextFormSField(
                            controller: _titleController,
                            onChanged: (value) {
                              if (value != null) {
                                liveViewModel.title.value = value;
                              }
                              return null;
                            },
                            validator: (value) {},
                            hintText: 'Add a title to game',
                            borderRadius: 0,
                            fillColor: AppColors.black.withOpacity(0.0),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
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
                                builder: (context) => PrivacySheet(),
                              );
                            },
                            child: Container(
                              width: 118.w,
                              height: 40.h,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.grey300.withOpacity(0.6),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    "Category",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.keyboard_arrow_right,
                                      size: 20, color: AppColors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Obx(() {
                        return Row(
                          children: [
                            ...List.generate(
                              liveViewModel.tagList.length > 2
                                  ? 2
                                  : liveViewModel.tagList.length,
                              (index) => Container(
                                margin: EdgeInsets.only(right: 4.w),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 6),
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
                            // Spacer(),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: AppColors.grey300),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  child: Image.asset(AppImagePath.instagram,
                      height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child:
                      Image.asset(AppImagePath.facebook, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child:
                      Image.asset(AppImagePath.whatsapp, height: 16, width: 16),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.grey300.withOpacity(0.6),
                  child: const Icon(Icons.more_horiz,
                      color: Colors.white, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget addTagContainer() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(50),
  //       color: AppColors.grey300.withOpacity(0.6),
  //     ),
  //     child: Row(
  //       children: [
  //         const SizedBox(width: 6),
  //         Text(
  //           'Add Tag',
  //           style: sfProDisplayRegular.copyWith(
  //             fontSize: 13,
  //             color: AppColors.white,
  //           ),
  //         ),
  //         const SizedBox(width: 6),
  //         const Icon(Icons.keyboard_arrow_down,
  //             size: 14, color: AppColors.white),
  //       ],
  //     ),
  //   );
  // }
}
