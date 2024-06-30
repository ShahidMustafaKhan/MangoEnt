import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/app_text_field.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../widgets/custom_buttons.dart';

class LinkEmail extends StatefulWidget {
  const LinkEmail();

  @override
  State<LinkEmail> createState() => _LinkEmailState();
}

class _LinkEmailState extends State<LinkEmail> {
  late TextEditingController newPassword;

  RxBool isChecked = false.obs;

  @override
  void initState() {
    super.initState();
    newPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
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
                Text("Link Email",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w500)),
                SizedBox(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 16.h,
            color: Color(0xff494848),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Add Email Address",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTextFormField(
                    controller: newPassword!,
                    isPrefixIcon: true,
                    prefixIcon: const Icon(Icons.person),
                    isSuffixIcon: true,
                    validator: (val) {},
                    hintText: "Email "),
                const SizedBox(
                  height: 24,
                ),
                PrimaryButton(
                    width: 343.w,
                    height: 48.h,
                    borderRadius: 35.r,
                    title: "Next",
                    textColor: Color(0xff1E2121),
                    bgColor: AppColors.yellowBtnColor,
                    onTap: () {
                      Get.toNamed(AppRoutes.verifyEmail);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
