import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/routes/app_routes.dart';
import '../store/store.dart';


class Level extends StatelessWidget {
  const Level();

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();
    int level=userViewModel.currentUser.getLevel ?? 1;
    int xp=userViewModel.currentUser.getXp ?? 0;
    double xpFactor= (1/5000)*xp;
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Gifter Level',
          style: SafeGoogleFont('sfProDisplayMedium', fontSize: 16.sp),

        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),

      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: amberColor,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(userViewModel.currentUser.getAvatar!.url!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: -40,
                  child: Container(
                    height: 65.h,
                    width: 237.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ribon),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      "Lv. $level",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace,
            verticalSpace,

            //* Progress Bar
            SizedBox(
              height: 50.h,
              width: 343.w,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Container(
                      width: 343.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffD9D1C2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xffD9D1C2),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 10.h,
                            width: (xp / 5000) * 343.w,
                            decoration: BoxDecoration(
                              color: amberColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      chest,
                      height: 43.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lv.$level",
                          style: TextStyle(
                            color: const Color(0xff877777),
                            fontSize: 12.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50.w),
                          child: Text(
                            "EXP $xp / 5000",
                            style: TextStyle(
                              color: const Color(0xff877777),
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            verticalSpace,

            //Cover
            GestureDetector(
              onTap: ()=> Get.toNamed(AppRoutes.store),
              child: Image.asset(
                AppImagePath.popularBadge,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get verticalSpace => SizedBox(height: 24.h);
}
