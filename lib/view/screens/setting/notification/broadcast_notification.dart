import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../widgets/custom_toggle_button.dart';

class BroadcastNotification extends StatefulWidget {
  const BroadcastNotification({Key? key}) : super(key: key);

  @override
  _BroadcastNotificationState createState() => _BroadcastNotificationState();
}

class _BroadcastNotificationState extends State<BroadcastNotification> {
  final List<String> names = ['James', 'Alice', 'Bob', 'Charlie', 'David'];

  List<bool> toggleStates = List.generate(5, (_) => false);

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
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
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
                              child: Image.asset(AppImagePath.profilePic),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              names[index],
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            ToggleButton(
                              isActive: toggleStates[index],
                              onChanged: (value) {
                                setState(() {
                                  toggleStates[index] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Color(0xff494848)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
