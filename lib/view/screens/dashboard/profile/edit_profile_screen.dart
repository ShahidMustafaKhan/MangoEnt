import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/dashboard/profile/widget/basic_information.dart';
import 'package:teego/view/screens/dashboard/profile/widget/edit_profile_top_bar.dart';
import 'package:teego/view/screens/dashboard/profile/widget/profile_setting.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../../../view_model/edit_controller.dart';
import '../../../../view_model/gender_controller.dart';
import '../../../../view_model/relationship_status_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final GenderController genderController = Get.put(GenderController());
  final RelationshipStatusController relationStatusController =
      Get.put(RelationshipStatusController());

  final EditController editController = Get.put(EditController());

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UserViewModel userViewModel = Get.find();
    genderController.selectedGender.value = userViewModel.currentUser.getGender!;
    return BaseScaffold(
      body: SingleChildScrollView(
        child: GetBuilder<UserViewModel>(
            init: userViewModel,
            builder: (controller) {
              return Column(
              children: [
                EditProfileTopBar(),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: BasicInformationSection(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 16.h,
                  color: Color(0xff494848),
                ),
                ProfileSetting(),
              ],
            );
          }
        ),
      ),
    );
  }
}
