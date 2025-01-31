import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/ranking_controller.dart';
import '../../utils/constants/typography.dart';
import '../../view_model/tab_bar_controller.dart';

class TrophyToggleButtonList extends StatefulWidget {
  final int? selected;
  final Function? callback;
  final List<String>? categories;

  const TrophyToggleButtonList({
    Key? key,
    this.selected,
    this.callback,
    this.categories,
  }) : super(key: key);

  @override
  _TrophyToggleButtonListState createState() => _TrophyToggleButtonListState();
}

class _TrophyToggleButtonListState extends State<TrophyToggleButtonList> {
  int _selectedIndex = 0;
  final RankingViewModel rankingViewModel = Get.find();
  final TabBarViewModel tabBarViewModel = Get.find();

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
          SizedBox(width: 5.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(5.w, 5.h, 10.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      rankingViewModel.showTrophyScreen.value = false;
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                    ),
                  ),
                  items(0),
                  items(1),
                  items(2),
                  items(3),
                ],
              ),
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
        if (widget.callback != null) {
          widget.callback!(index);
        }
      },
      child: FittedBox(
        child: Container(
          margin: EdgeInsets.only(
            left: 0,
            top: 8,
            bottom: 4,
          ),
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.categories![index],
                style: sfProDisplayBold.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: _selectedIndex == index ? Get.isDarkMode ? Colors.white : Colors.black : Get.isDarkMode ? Colors.grey : Colors.black.withOpacity(0.6),
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
