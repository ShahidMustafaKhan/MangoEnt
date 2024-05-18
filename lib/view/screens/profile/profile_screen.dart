import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view_model/theme_controller.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../helpers/quick_help.dart';
import '../../../utils/Utils.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);


  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  // ThemeController().toggleTheme();
                  // setState(() {
                  //
                  // });
                  QuickHelp.showLoadingDialog(context);
                  Get.find<UserViewModel>().currentUser
                      .logout(deleteLocalUserData: true)
                      .then((value) {
                    QuickHelp.hideLoadingDialog(context);
                    Get.offAllNamed(AppRoutes.onBoarding);
                  }).onError(
                        (error, stackTrace) {
                      QuickHelp.hideLoadingDialog(context);
                    },
                  );
                },
                child: Container(
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.right,
                    style: SafeGoogleFont (
                      'DM Sans',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15,),
            ],
          ),
        ),
        Align(
            child: Text(
              "Profile screen",
              style: TextStyle(color: Colors.white, fontSize: 30),
            )),
        Spacer(),
      ],
    );
  }
}
