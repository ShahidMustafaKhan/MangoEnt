import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../widgets/custom_buttons.dart';
import '../../../widgets/custom_keyboard.dart';

class RetrievePasswordScreen extends StatefulWidget {
  const RetrievePasswordScreen({Key? key}) : super(key: key);

  @override
  _RetrievePasswordScreenState createState() => _RetrievePasswordScreenState();
}

class _RetrievePasswordScreenState extends State<RetrievePasswordScreen> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onKeyTapped(String value) {
    setState(() {
      if (value == 'x') {
        for (var i = _controllers.length - 1; i >= 0; i--) {
          if (_controllers[i].text.isNotEmpty) {
            _controllers[i].clear();
            _focusNodes[i].requestFocus();
            break;
          }
        }
      } else {
        for (var i = 0; i < _controllers.length; i++) {
          if (_controllers[i].text.isEmpty) {
            _controllers[i].text = value;
            if (i < _controllers.length - 1) {
              _focusNodes[i + 1].requestFocus();
            } else {
              _focusNodes[i].unfocus();
            }
            break;
          }
        }
      }
    });
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
                Text(
                  "Reset password",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 16.h,
            color: Color(0xff494848),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Retrieve Password",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text(
                      "*",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                    Text(
                      " We will send a code at +92303030303",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        height: 72.w,
                        width: 72.w,
                        child: TextFormField(
                          focusNode: _focusNodes[index],
                          controller: _controllers[index],
                          onTap: () => _focusNodes[index].requestFocus(),
                          style: Theme.of(context).textTheme.headlineMedium,
                          keyboardType: TextInputType.none,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.darkBGColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(36.r),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(36.r),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(36.r),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(36.r),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 20.h),
                            isDense: true,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                PrimaryButton(
                    width: 343.w,
                    height: 48.h,
                    borderRadius: 35.r,
                    title: "Verify",
                    textColor: AppColors.black,
                    bgColor: AppColors.yellowBtnColor,
                    onTap: () {
                      Get.toNamed(AppRoutes.setNewPassword);
                    }),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send Code again ",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "00:20",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.0,
                        color: AppColors.yellowBtnColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          CustomKeyboard(
            onKeyTapped: (key) {
              _onKeyTapped(key);
            },
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
