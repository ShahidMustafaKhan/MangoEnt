import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/search_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../utils/constants/status.dart';
import '../../utils/constants/typography.dart';
import '../../utils/theme/colors_constant.dart';

class RecentlyPopular extends StatelessWidget {
  const RecentlyPopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? Colors.black : Colors.white;
    final backgroundColor = isLightTheme ? Colors.white : Color(0xff212121);

    SearchController searchController = Get.find();
    UserViewModel userViewModel = Get.find();
    return Container(
      height: 120.h,
      child: GetBuilder<SearchController>(
          init: searchController,
          builder: (searchController) {
            if (searchController.status == Status.Loading)
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QuickHelp.appLoading(),
                ],
              );
            return ListView.builder(
              shrinkWrap: true,
              itemCount: searchController.recentPopular.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Column(
                    children: [
                      Container(
                        width: 87.w,
                        height: 106.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            // color: Color(0xff212121),
                            color: backgroundColor),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            QuickActions.avatarWidget(
                              searchController.recentPopular[index],
                              height: 40.w,
                              width: 40.w,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              searchController
                                  .recentPopular[index].getFirstName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: textColor),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GetBuilder<UserViewModel>(
                                init: userViewModel,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      userViewModel.followOrUnFollow(
                                          searchController
                                              .recentPopular[index].objectId!);
                                    },
                                    child: Container(
                                      width: 36.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30.r),
                                        color: AppColors.yellowBtnColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          userViewModel
                                              .currentUser.getFollowing!
                                              .contains(searchController
                                              .recentPopular[index]
                                              .objectId)
                                              ? "✓"
                                              : "+",
                                          style: sfProDisplayMedium.copyWith(
                                            color:
                                            Colors.black.withOpacity(0.6),
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
