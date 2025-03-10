import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

import '../../../helpers/quick_actions.dart';
import '../../../utils/theme/colors_constant.dart';
import '../../../view_model/userViewModel.dart';
import '../../widgets/custom_buttons.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isChecked = false;
  UserViewModel userViewModel = Get.find();

  void _toggleCheck() {
    setState(() {
      _isChecked = !_isChecked;
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
                  "Delete account",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
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
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      userViewModel.currentUser.getFullName!,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "*",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                    Expanded(
                      child: Text(
                        " You are deleting your account. The deleted account can't be\n restored. Before deleting, make sure all services related with this\n account are handled.",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _toggleCheck,
                      child: Container(
                        width: 12.w,
                        height: 14.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isChecked ? Colors.yellow : Colors.white,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: _isChecked
                            ? Icon(
                                Icons.check,
                                size: 8.w,
                                color: Colors.black,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "I have read and agree to the above information",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                    width: 343.w,
                    height: 48.h,
                    borderRadius: 35.r,
                    title: "Delete account",
                    textColor: Color(0xff1E2121),
                    bgColor: AppColors.yellowBtnColor,
                    onTap: () {
                      if(_isChecked == true){
                        QuickActions.showAlertDialog(context,
                            "Are you sure you want to delete this account?",
                                () {
                              Get.back();
                              userViewModel.deleteAccount(context);
                            });
                      }
                      else{
                        QuickHelp.showAppNotificationAdvanced(title: "Please click the toggle button to confirm that you have read and agreed.", context: context);
                      }


                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
