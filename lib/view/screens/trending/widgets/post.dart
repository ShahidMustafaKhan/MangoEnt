import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 65.h),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Container(
              width: 342.w,
              height: 494.h,
              decoration: BoxDecoration(
                color: Color(0xff212121),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppImagePath.profilePic,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ralph Edwards",
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "id: 01251421",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Icon(
                                  Icons.copy,
                                  size: 15,
                                )
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 36.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: Colors.yellow),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                        Icon(Icons.more_vert)
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Akshay syan Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      width: 332.w,
                      height: 332.h,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          AppImagePath.post_img,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Image.asset(
                          AppImagePath.coinsIcon,
                          height: 16.h,
                          width: 16.w,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Reward",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Image.asset(
                          AppImagePath.ic_heart,
                          width: 16.w,
                          height: 13.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("257"),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(
                          AppImagePath.ic_comment,
                          width: 16.w,
                          height: 13.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("95"),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(
                          AppImagePath.ic_send,
                          width: 16.w,
                          height: 13.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("6"),
                        SizedBox(
                          width: 5.w,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
