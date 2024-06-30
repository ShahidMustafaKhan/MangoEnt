import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/trending/widgets/tip_sheet.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'comment_sheet.dart';

class ForYouView extends StatelessWidget {
  const ForYouView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        right: 10,
        bottom: 50,
        child: Column(
          children: [
            Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite, color: Colors.white, size: 30),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("5000"),
            SizedBox(
              height: 25.h,
            ),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: AppColors.grey500,
                    isScrollControlled: true,
                    builder: (context) => Wrap(
                      children: [
                        CommentSheet(),
                      ],
                    ),
                  );
                },
                child: Image.asset(AppImagePath.reel_comment)),
            SizedBox(
              height: 10.h,
            ),
            Text("6000"),
            SizedBox(
              height: 25.h,
            ),
            Image.asset(
              AppImagePath.post,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("7000"),
            SizedBox(
              height: 25.h,
            ),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: AppColors.grey500,
                    isScrollControlled: true,
                    builder: (context) => Wrap(
                      children: [
                        TipSheet(),
                      ],
                    ),
                  );
                },
                child: Image.asset(AppImagePath.reel_tip)),
            SizedBox(
              height: 10.h,
            ),
            Text("Tip"),
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff494848)),
              child: Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("Tools"),
            SizedBox(
              height: 25.h,
            ),
            Image.asset(AppImagePath.reel_music),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
      Positioned(
          left: 10,
          bottom: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImagePath.profilePic,
                    height: 30.h,
                    width: 30.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Ralph Edwards ❤️❤️ ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 20.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColors.yellowBtnColor),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text("Lorem metus epsum colori smrjw. Not em dhwi cjs...."),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Container(
                    height: 26.h,
                    width: 96.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.r),
                        color: Color(0xffFFFFF)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.person,
                          size: 20,
                        ),
                        Text(
                          "55  users",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 26.h,
                    width: 196.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.r),
                        color: Color(0xffFFFFF)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.music_note,
                          size: 20,
                        ),
                        Text(
                          "Lorem Espanl corem  poertiittor....",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ))
    ]);
  }
}
