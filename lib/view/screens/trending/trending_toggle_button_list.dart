import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/typography.dart';
import '../../../view_model/trending_tab_bar_controller.dart';

class TrendingToggleButtonList extends StatefulWidget {
  final int? selected;
  final Function? callback;
  final List<String>? categories;

  const TrendingToggleButtonList({
    Key? key,
    this.selected,
    this.callback,
    this.categories,
  }) : super(key: key);

  @override
  _TrendingToggleButtonListState createState() =>
      _TrendingToggleButtonListState();
}

class _TrendingToggleButtonListState extends State<TrendingToggleButtonList> {
  int _selectedIndex = 0;
  final TrendingTabBarViewModel trendingTabBarViewModel = Get.find();
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selected ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  items(0),
                  SizedBox(
                    width: 10.w,
                  ),
                  items(1),
                  SizedBox(width: 10.w),
                  items(2),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.createPostScreen);
              },
              child: Image.asset(
                AppImagePath.notification,
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.createPostScreen);
              },
              child: Image.asset(AppImagePath.post, width: 40, height: 40),
            ),
          ),
          SizedBox(width: 9.w),
        ],
      ),
    );
  }

  Widget items(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        widget.callback!(index);
      },
      child: FittedBox(
        child: Container(
          margin: EdgeInsets.only(
            left: 0,
            top: 15,
            bottom: 4,
          ),
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.categories![index],
                style: sfProDisplayBold.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: _selectedIndex == index ? Colors.white : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              _selectedIndex == index
                  ? Container(
                      height: 2,
                      width: 15.w,
                      color: const Color(0xffF9C034),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
