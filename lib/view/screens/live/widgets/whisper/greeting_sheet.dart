import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../widgets/custom_buttons.dart';

class GreetingSheet extends StatelessWidget {
  const GreetingSheet();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  2,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.grey300,
                          backgroundImage: AssetImage(AppImagePath.profilePic),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Savannah Nguyen'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Welcome! you can meet and follow',
                                  style: sfProDisplayRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.white.withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        PrimaryButton(
                          width: 65.w,
                          height: 32.h,
                          title: 'Chat',
                          borderRadius: 35,
                          textStyle: sfProDisplayMedium.copyWith(
                              fontSize: 16, color: AppColors.black),
                          bgColor: AppColors.yellowBtnColor,
                          onTap: () {
                            Get.back();
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              backgroundColor: AppColors.grey500,
                              builder: (context) => Wrap(
                                children: [
                                  Chat(),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 447.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Icon(Icons.arrow_back_ios),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 36.h,
                  width: 36.w,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: ClipOval(
                    child: Image.asset(
                      AppImagePath.multiGuestImage,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "Andrew Parker",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: AppColors.grey300,
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  bool isUserMessage = index % 2 == 0;
                  return Row(
                    mainAxisAlignment: isUserMessage
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      if (isUserMessage) ...[
                        Container(
                          height: 28.h,
                          width: 28.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppImagePath.profilePic,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 12.w,
                          ),
                          decoration: BoxDecoration(
                            color: isUserMessage
                                ? Color(0xff494848)
                                : Color(0xffE5375A),
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(isUserMessage ? 4.r : 18.r),
                              bottomLeft:
                                  Radius.circular(isUserMessage ? 18.r : 4.r),
                              topRight: Radius.circular(18.r),
                              bottomRight: Radius.circular(18.r),
                            ),
                          ),
                          child: Text(
                            isUserMessage
                                ? "How are you doing? "
                                : "I'm good, thanks!",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      // if (!isUserMessage) ...[
                      //   SizedBox(width: 10.w),
                      //   Container(
                      //     height: 28.h,
                      //     width: 28.w,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //     ),
                      //     child: Image.asset(
                      //       AppImagePath.profilePic,
                      //       height: double.infinity,
                      //       width: double.infinity,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ],
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Container(
                  height: 36.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffE5375A)),
                  child: Center(
                    child: Image.asset(
                      AppImagePath.giftIcon,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 40.h,
                  width: 286.w,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff494848),
                      hintText: ' Aa',
                      hintStyle: TextStyle(color: Colors.black),
                      suffixIcon: Icon(Icons.emoji_emotions),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
