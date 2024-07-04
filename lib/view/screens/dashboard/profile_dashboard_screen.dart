import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/dashboard/subscription/subscribers.dart';
import 'package:teego/view/screens/dashboard/subscription/subscription.dart';
import 'package:teego/view/screens/dashboard/wallet/transaction_history.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../view_model/theme_controller.dart';
import 'bag/bag.dart';
import 'level/level.dart';

class ProfileDashBoardScreen extends StatefulWidget {
  const ProfileDashBoardScreen({Key? key}) : super(key: key);

  @override
  _ProfileDashBoardScreenState createState() => _ProfileDashBoardScreenState();
}

class _ProfileDashBoardScreenState extends State<ProfileDashBoardScreen> {
  final List<Map<String, String>> items = [
    {"image": AppImagePath.transaction, "label": "Transaction History"},
    {"image": AppImagePath.bag, "label": "Bag"},
    {"image": AppImagePath.podium, "label": "Level"},
    {"image": AppImagePath.fans, "label": "Top Fans"},
    {"image": AppImagePath.subscription, "label": "Subscription"},
    {"image": AppImagePath.subscriberImage, "label": "Subscriber"},
  ];
  final List<Function()> onTap = [
        () => Get.toNamed(AppRoutes.transactionHistory),
        () => Get.toNamed(AppRoutes.bag),
        () => Get.toNamed(AppRoutes.level),
        () => Get.toNamed(AppRoutes.topFan),
        () => Get.toNamed(AppRoutes.subscription),
        () => Get.toNamed(AppRoutes.subscribers),
  ];

  bool _isToggled = false;


  @override
  void initState() {
    if(Get.isDarkMode==true)
    _isToggled=false;
    else{
      _isToggled=true;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();
    return BaseScaffold(
      body: GetBuilder<UserViewModel>(
          init: userViewModel,
          builder: (userViewModel) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.profileScreen,
                            arguments: {"otherProfile": false}),
                        child: Container(
                          height: 88.h,
                          width: 88.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.yellowBtnColor, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(42.r),
                            child: Image.network(
                              userViewModel.currentUser.getAvatar!.url!,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          SizedBox(
                            width: 60.w,
                            height: 30.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF626262),
                                    borderRadius: BorderRadius.circular(15.h),
                                  ),
                                ),
                                Transform.scale(
                                  scale: 1.1,
                                  child: CupertinoSwitch(
                                    value: _isToggled,
                                    onChanged: (bool value) {
                                      ThemeController().toggleTheme();
                                      setState(() {
                                        _isToggled = value;
                                      });
                                    },
                                    trackColor: Colors.transparent,
                                    activeColor: Colors.transparent,
                                    thumbColor: Color(0xFF333333),
                                  ),
                                ),
                                Align(
                                  alignment: _isToggled
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Container(
                                      width: 24.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF333333),
                                        shape: BoxShape.circle,
                                      ),
                                      // child: Center(
                                      //   child: Image.asset(
                                      //     AppImagePath.moonIcon,
                                      //     width: 16.w,
                                      //     height: 16.h,
                                      //   ),
                                      // ),
                                      child: Center(
                                        child: Image.asset(
                                          _isToggled
                                              ? AppImagePath.sunIcon
                                              : AppImagePath.moonIcon,
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.settingScreen);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 18.h),
                                Container(
                                    height: 27.w,
                                    width: 27.w,
                                    child: ColorFiltered(
                                        colorFilter: Theme.of(context)
                                            .brightness ==
                                            Brightness.light
                                            ? ColorFilter.mode(
                                            Colors.black, BlendMode.srcIn)
                                            : ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn),
                                        child: Image.asset(
                                          icon1,
                                          fit: BoxFit.cover,
                                        ))),
                                SizedBox(height: 18.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text(
                        userViewModel.currentUser.getFullName ?? '',


                        style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (userViewModel.currentUser.isVerified)
                        Image.asset(AppImagePath.yellow_tick),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.profileScreen,
                            arguments: {"otherProfile": false}),
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff494848),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "id: ${userViewModel.currentUser.getUid}",
                        // style: TextStyle(
                        //   fontSize: 12.sp,
                        //   fontWeight: FontWeight.w400,
                        //   color: AppColors.white,
                        // ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.copy,
                        size: 15,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      if (userViewModel.currentUser.getHideMyBirthday == false)
                        Container(
                          width: 30.w,
                          height: 13.h,
                          decoration: BoxDecoration(
                            color: AppColors.progressPinkColor2,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                AppImagePath.share,
                                height: 6.h,
                                width: 6.w,
                              ),
                              Text(
                                QuickHelp.getAgeFromDate(
                                    userViewModel.currentUser.getBirthday!)
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        width: 30.w,
                        height: 13.h,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Lv.",
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${userViewModel.currentUser.getLevel}",
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      if (userViewModel.currentUser.getHideMyLocation == false)
                        SvgPicture.asset(
                          QuickActions.getCountryFlag(
                              userViewModel.currentUser),
                          height: 17.h,
                          width: 24.w,
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${userViewModel.currentUser.getFollowing!.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 35.h,
                        width: 1,
                        color: AppColors.yellowBtnColor,
                      ),
                      Column(
                        children: [
                          Text(
                            "${userViewModel.currentUser.getFollowers!.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 35.h,
                        width: 1,
                        color: AppColors.yellowBtnColor,
                      ),
                      Column(
                        children: [
                          Text(
                            "0",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Likes",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.wallet),
                        child: Container(
                          width: 163.w,
                          height: 70.h,
                          child: Image.asset(
                            AppImagePath.tile1,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.store),
                        child: Container(
                          width: 163.w,
                          height: 70.h,
                          child: Image.asset(
                            AppImagePath.tile2,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.h,
                      mainAxisSpacing: 17.h,
                      childAspectRatio: 0.96,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: onTap[index],
                        child: Column(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.h,
                              decoration: BoxDecoration(),
                              child: Image.asset(
                                items[index]['image']!,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              items[index]['label']!,
                              style: TextStyle(fontSize: 12.sp),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
