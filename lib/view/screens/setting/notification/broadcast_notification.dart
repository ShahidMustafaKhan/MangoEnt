import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../../../parse/UserModel.dart';
import '../../../widgets/custom_toggle_button.dart';

class BroadcastNotification extends StatefulWidget {
  const BroadcastNotification({Key? key}) : super(key: key);

  @override
  _BroadcastNotificationState createState() => _BroadcastNotificationState();
}

class _BroadcastNotificationState extends State<BroadcastNotification> {
  final List<String> names = ['James', 'Alice', 'Bob', 'Charlie', 'David'];

  List<RxBool> toggleStates = List.generate(5, (_) => false.obs);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
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
                  "Broadcast Notification",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: FutureBuilder<List>(
                future: Get.find<UserViewModel>().getFollowersUserModel(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data found'));
                  } else {
                    return ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        UserModel user = snapshot.data![index] as UserModel;
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    child: QuickActions.avatarWidget(user),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    user.getFirstName ?? '',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() {
                                      return ToggleButton(
                                        isActive: toggleStates[index].value,
                                        onChanged: (value) {
                                            toggleStates[index].value = value;
                                        },
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Color(0xff494848)),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
