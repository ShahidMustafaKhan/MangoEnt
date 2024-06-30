import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/typography.dart';
import '../../../utils/theme/colors_constant.dart';
import '../../widgets/custom_buttons.dart';

class DislikeSetting extends StatefulWidget {
  const DislikeSetting({Key? key}) : super(key: key);

  @override
  _DislikeSettingState createState() => _DislikeSettingState();
}

class _DislikeSettingState extends State<DislikeSetting> {
  bool _isDisableChatSelected = true;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    Text(
                      "Language",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDisableChatSelected = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Disable chat",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5.h),
                          if (_isDisableChatSelected)
                            Container(
                              width: 5.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDisableChatSelected = false;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Blocked",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5.h),
                          if (!_isDisableChatSelected)
                            Container(
                              width: 5.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(
                  color: Color(0xff494848),
                )
              ],
            ),
          ),
          Expanded(
            child:
                _isDisableChatSelected ? DisableChatWidget() : BlockedWidget(),
          ),
        ],
      ),
    );
  }
}

class DisableChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
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
                            backgroundImage:
                                AssetImage(AppImagePath.profilePic),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Savannah Nguyen'),
                                  const SizedBox(width: 16),
                                  SvgPicture.asset(
                                    AppImagePath.franceFlag,
                                    width: 24,
                                    height: 17,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'id: 12345678',
                                    style: sfProDisplayRegular.copyWith(
                                        fontSize: 12,
                                        color:
                                            AppColors.white.withOpacity(0.7)),
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
                            title: 'Enable',
                            borderRadius: 35,
                            textStyle: sfProDisplayMedium.copyWith(
                                fontSize: 16, color: AppColors.black),
                            bgColor: AppColors.yellowBtnColor,
                            onTap: () {},
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
      ),
    );
  }
}

class BlockedWidget extends StatelessWidget {
  const BlockedWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 36.h,
                        width: 343.w,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffBCBBBE),
                            hintText: 'Search for username or ID',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.search, color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ...List.generate(
                    2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.grey300,
                            backgroundImage:
                                AssetImage(AppImagePath.profilePic),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Savannah Nguyen'),
                                  const SizedBox(width: 16),
                                  SvgPicture.asset(
                                    AppImagePath.franceFlag,
                                    width: 24,
                                    height: 17,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'id: 12345678',
                                    style: sfProDisplayRegular.copyWith(
                                        fontSize: 12,
                                        color:
                                            AppColors.white.withOpacity(0.7)),
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
                            title: 'Unblock',
                            borderRadius: 35,
                            textStyle: sfProDisplayMedium.copyWith(
                                fontSize: 16, color: AppColors.black),
                            bgColor: AppColors.yellowBtnColor,
                            onTap: () {},
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
      ),
    );
  }
}
