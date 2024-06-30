import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/popular_trending_widget.dart';
import '../../../parse/UserModel.dart';
import '../../../view_model/popular_controller.dart';
import '../../widgets/popular_all_widget.dart';

class Popular extends StatefulWidget {
  final UserModel? currentUser;

  Popular({Key? key, this.currentUser}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}


class _PopularState extends State<Popular> {
  final PopularViewModel popularViewModel= Get.put(PopularViewModel());

  @override
  void initState() {
    popularViewModel.subscribeLiveStreamingModel();
    super.initState();
  }

  @override
  void dispose() {
    popularViewModel.unSubscribeLiveStreamingModel();
    super.dispose();
  }

  Color? colorSelected(bool isSelected) {
    return isSelected ? Colors.yellow.shade600 : null;
  }

  Color? textColorSelected(bool isSelected) {
    return isSelected ? Colors.black : Colors.white;
  }

  Color? borderColorSelected(bool isSelected) {
    return isSelected ? null : Colors.white70;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularViewModel>(
        init: popularViewModel,
        builder: (controller) {
          return Center(
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              toggleButton(),
              SizedBox(height: 6.h,),
              controller.isAllTapSelected.value ? Expanded(child: PopularAllWidget()) : Expanded(child: PopularTrendingWidget()),
            ],
          ),
        );
      }
    );
  }

  Widget toggleButton() {
    return Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (popularViewModel.isAllTapSelected.value == false) {
                    popularViewModel.switchToggle(toggle: "All");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setWidth(40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colorSelected(popularViewModel.isAllTapSelected.value == true),
                      border: Border.all(color: Colors.white70)),
                  child: Text(
                    'All',
                    style: TextStyle(
                        color: textColorSelected(popularViewModel.isAllTapSelected.value == true),
                        fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(20)),
              InkWell(
                onTap: () {
                  if (popularViewModel.isAllTapSelected.value == true) {
                    popularViewModel.switchToggle(toggle: "Trending");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setWidth(80),
                  decoration: BoxDecoration(
                      color: colorSelected(popularViewModel.isAllTapSelected.value == false),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white70)
                  ),
                  child: Text(
                    "Trending",
                    style: TextStyle(
                        color: textColorSelected(popularViewModel.isAllTapSelected.value == false),
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
