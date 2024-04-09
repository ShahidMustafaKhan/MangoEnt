import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mango_ent/view/utils/app_constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: buildAppBar()),
        SizedBox(width: 10.w,),
        SvgPicture.asset(AppImagePath.searchIcon, height: 24.h, width: 24.w,),
        SizedBox(width: 8.w,),
        SvgPicture.asset(AppImagePath.trophyIcon, height: 24.h, width: 24.w,),
      ],
    );
  }
  Widget buildAppBar () {
    return SizedBox(
      height: 40.w,
      child: ListView.builder(
        itemCount: SubLists.categoryItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Center(
              child: Text(
                SubLists.categoryItems[index],
                style: TextStyle(color: index == 0 ? Colors.white : Colors.white70, fontSize: 18.sp,),
              ),
            ),
          );
        },),
    );
  }
}
