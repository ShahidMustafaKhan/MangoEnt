import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class AudioStreamerLive extends StatelessWidget {
  AudioStreamerLive();

  final RxInt nineMemberIndex = 0.obs;
  final RxList<String> personList = <String>[
    "9P",
    "12P"
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        Spacer(),
        Container(
          height: 360.h,
          width: 343.w,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          // color: Colors.red,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer(),
              Container(
                height: 72.h,
                width: 72.w,
                decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(image: AssetImage(AppImagePath.nothingIsHere)),
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: AppColors.yellowColor)
                ),
              ),
              SizedBox(height: 20.h,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 21.h,
                      crossAxisSpacing: 32.w
                  ),
                  // shrinkWrap: true,
                  itemCount: nineMemberIndex.value == 0 ? 8 : 11,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 54.h,
                      width: 54.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        // image: DecorationImage(image: AssetImage(AppImagePath.sofaFilled)),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: SvgPicture.asset(AppImagePath.sofaFilled)),
                    );
                  },),
              ),
              // SizedBox(height: 30.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(personList.length, (index) =>
                    GestureDetector(
                      onTap: () {
                        nineMemberIndex.value = index;
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          height: 28.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                              color: nineMemberIndex.value == index
                                  ? AppColors.black
                                  : AppColors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.r)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppImagePath.sofaFilled),
                              Text(personList[index]),
                            ],
                          ),
                        ),
                      ),
                    ),),
              ),
              // SizedBox(height: 40.h,)
              // Expanded(
              //   child: GridView.count(
              //       crossAxisCount: 4,
              //     children: List.generate(8, (index) => Container(
              //       height: 54.h,
              //       width: 54.w,
              //       decoration: BoxDecoration(
              //         color: Colors.green,
              //         // image: DecorationImage(image: AssetImage("assetName")),
              //         shape: BoxShape.circle,
              //       ),
              //     ),),
              //   ),
              // ),
              // Wrap(
              //   // crossAxisAlignment: WrapCrossAlignment.center,
              //   runAlignment: WrapAlignment.spaceBetween,
              //   // spacing: 42.w,
              //   // runSpacing: 21.h,
              //   children: List.generate(8, (index) => Container(
              //     height: 54.h,
              //     width: 54.w,
              //     decoration: BoxDecoration(
              //         color: Colors.green,
              //         // image: DecorationImage(image: AssetImage("assetName")),
              //         shape: BoxShape.circle,
              //     ),
              //   ),),
              // )
            ],
          ),
        ),
        SizedBox(height: 110.h,)
      ],
    ));
  }
}
