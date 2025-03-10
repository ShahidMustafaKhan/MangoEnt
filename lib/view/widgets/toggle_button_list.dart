import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view_model/ranking_controller.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/constants/typography.dart';
import '../../utils/routes/app_routes.dart';

class ToggleButtonList extends StatefulWidget {
  final int? selected;
  final Function? callback;
  final List<String>? categories;

  const ToggleButtonList({
    Key? key,
    this.selected,
    this.callback,
    this.categories,
  }) : super(key: key);

  @override
  _ToggleButtonListState createState() => _ToggleButtonListState();
}

class _ToggleButtonListState extends State<ToggleButtonList> {
  int _selectedIndex = 0;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    items(0),
                    items(1),
                    items(2),
                    items(3),
                  ],
                )),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.searchScreen),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SvgPicture.asset(
                AppImagePath.searchIcon,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black // Selected color for light theme
                    : Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.topFan),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child:
              Image.asset(AppImagePath.trophyIcon, width: 40, height: 40),
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
                  // color: _selectedIndex == index
                  //     ? Colors.white
                  //     : Colors.grey,
                  color: _selectedIndex == index
                      ? (Theme.of(context).brightness == Brightness.light
                      ? Colors.black // Selected color for light theme
                      : Colors.white) // Selected color for dark theme
                      : Colors.grey, // Unselected color for both themes
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
