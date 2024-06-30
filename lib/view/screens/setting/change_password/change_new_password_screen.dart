import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/app_text_field.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../widgets/custom_buttons.dart';

class ChangeNewPasswordScreen extends StatefulWidget {
  const ChangeNewPasswordScreen();

  @override
  State<ChangeNewPasswordScreen> createState() =>
      _ChangeNewPasswordScreenState();
}

class _ChangeNewPasswordScreenState extends State<ChangeNewPasswordScreen> {
  late TextEditingController newPassword;
  late TextEditingController confirmPassword;

  RxBool isChecked = false.obs;

  @override
  void initState() {
    super.initState();
    newPassword = TextEditingController();
    confirmPassword = TextEditingController();
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
                Text("Change password",
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
                      "Set New Password",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    const Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      " Password should have 8+ characters with numbers",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                AppTextFormField(
                    controller: newPassword!,
                    isPrefixIcon: true,
                    prefixIcon: const Icon(Icons.lock),
                    isSuffixIcon: true,
                    suffixIcon: Icon(Icons.visibility_outlined),
                    validator: (val) {},
                    hintText: "Password "),
                const SizedBox(
                  height: 24,
                ),
                AppTextFormField(
                    controller: confirmPassword!,
                    isPrefixIcon: true,
                    prefixIcon: const Icon(Icons.lock),
                    isSuffixIcon: true,
                    suffixIcon: Icon(Icons.visibility_outlined),
                    validator: (val) {},
                    hintText: "Confirm Password"),
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
                      Get.toNamed(AppRoutes.successPasswordScreen);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
