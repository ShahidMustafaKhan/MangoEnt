import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/userViewModel.dart';

class TipSheet extends StatefulWidget {
  const TipSheet({Key? key}) : super(key: key);

  @override
  State<TipSheet> createState() => _TipSheetState();
}

class _TipSheetState extends State<TipSheet> {
  final List<Map<String, dynamic>> goldData = [
    {"amount": "10", "width": 34.w},
    {"amount": "100", "width": 42.w},
    {"amount": "1000", "width": 51.w},
    {"amount": "5000", "width": 34.w},
    {"amount": "10000", "width": 42.w},
    {"amount": "100000", "width": 51.w},
  ];

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.h),
            Row(
              children: [
                Text(
                  "Reward This Moment",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  "More",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_forward_ios, size: 20.sp),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Coins",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: (108.w / 118.h),
          ),
          itemCount: goldData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: ()=> setState(() {
                selectedIndex=index;
              }),
              child: Container(
                width: 108.w,
                height: 118.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: selectedIndex==index ? AppColors.yellowColor : Colors.transparent, width: 2),
                  color: AppColors.bgShadeColor2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 34.h,
                      width: 34.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffE9B020),
                        border: Border.all(color: AppColors.yellow, width: 2),
                      ),
                    ),
                    Text(
                      "Gold",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: goldData[index]['width'],
                      height: 18.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: Color(0xff32271A),
                      ),
                      child: Center(
                        child: Text(
                          goldData[index]['amount']=='5000' ? '5k' : goldData[index]['amount']=='10000' ? '10k' : goldData[index]['amount']=='100000' ? '100k' : goldData[index]['amount'] ,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
            SizedBox(
              height: 20.h,
            ),
            PrimaryButton(
                width: 343.w,
                height: 48.h,
                borderRadius: 35.r,
                bgColor: AppColors.yellowBtnColor,
                title: "Confirm",
                textColor: Colors.black,
                onTap: () {
                  if(selectedIndex != -1){
                    if(Get.find<UserViewModel>().checkCoins(int.parse(goldData[selectedIndex]["amount"]))){
                      Get.find<UserViewModel>().deductBalance(int.parse(goldData[selectedIndex]["amount"]));
                      Get.back();
                      QuickHelp.showAppNotification(title: 'Reward successfully sent to the creator.', context: context, isError: false);
                    }
                    else{
                      QuickHelp.showAppNotificationAdvanced(title: 'Insufficient Balance.', context: context, isError: true);

                    }
                  }

                })
          ],
        ),
      ),
    );
  }
}
