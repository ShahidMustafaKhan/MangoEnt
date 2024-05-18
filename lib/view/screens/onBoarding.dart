import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/auth_controller.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/theme/colors_constant.dart';
import '../widgets/appButton.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

   AuthViewModel authViewModel = Get.put(AuthViewModel());


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          guestLogin(context),
          Image.asset(
            AppImagePath.onBoarding,
          ),

          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0.h),
            child: AppButton(context, "Sign in", () {
              Get.toNamed(AppRoutes.login);
            }, textColor: AppColors.kWhite, backgroundColor: AppColors.bgShadeColor),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0.h),
            child: AppButton(context, "Create Account", () {
              Get.toNamed(AppRoutes.createAccount);
            }),
          ),
          const Spacer(),
        ],
      ),
    );
  }

   Widget guestLogin(BuildContext context){
     return InkWell(
       onTap: ()=> authViewModel.guestSignIn(context),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
           Text('Guest', style: sfProDisplayBold.copyWith(fontSize: 14),),
           Icon(Icons.keyboard_double_arrow_right_outlined),
           SizedBox(width:12.w)
         ],
       ),
     );
   }

}
