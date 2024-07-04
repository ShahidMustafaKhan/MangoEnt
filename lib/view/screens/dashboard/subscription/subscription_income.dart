import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/subscription_model.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../wallet/wallet.dart';


class SubscriptionIncome extends StatelessWidget {
  const SubscriptionIncome();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(centerTitle: true, title: Text('Subscription income',
        style: sfProDisplayMedium.copyWith(fontSize: 16.sp,
            color: Get.isDarkMode ? AppColors.white : AppColors.black
        ),),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
                Icons.arrow_back_ios,
                color: Get.isDarkMode ? AppColors.white : AppColors.black
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Balance",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$ ${Get.find<SubscriptionViewModel>().totalRevenue.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: amberColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 IconButton(
                  onPressed: () => Get.toNamed(AppRoutes.wallet),
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: Get.isDarkMode ? Colors.white70 : AppColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.wallet),
              child: Container(
                height: 51.93.h,
                width: 342.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.r),
                  color: Get.isDarkMode ? Color(0xff494848) :  AppColors.white,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wallet,
                      color: Get.isDarkMode ? Colors.white70 : AppColors.black,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "Go to wallet",
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.white70 : AppColors.black,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
