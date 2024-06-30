import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/widgets/nothing_widget.dart';
import '../../utils/permission/go_live_permission.dart';
import '../../utils/theme/colors_constant.dart';
import '../../view_model/popular_controller.dart';

class YouMayLike extends StatelessWidget {
  const YouMayLike({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopularViewModel popularViewModel = Get.find();
    return GetBuilder<PopularViewModel>(
        init: popularViewModel,
        builder: (controller) {
          if(popularViewModel.popularAllModelList.isNotEmpty)
          return Container(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1,
            ),
            itemCount: popularViewModel.popularAllModelList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: ()=> LivePermissionHandler.checkPermission(popularViewModel.popularAllModelList[index].liveModel.getStreamingType, context, liveStreamingModel: popularViewModel.popularAllModelList[index].liveModel),
                child: Container(
                  width: 110.w,
                  height: 110.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          popularViewModel.popularAllModelList[index].image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 8.h,
                        right: 8.w,
                        child: Row(
                          children: [
                            Image.asset(AppImagePath.trendPic),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              '${popularViewModel.popularAllModelList[index].liveModel.getViewersId!.length}',
                              style: TextStyle(color: Colors.white, fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8.h,
                        left: 8.w,
                        child: Row(
                          children: [
                            Text(
                              popularViewModel.popularAllModelList[index].name.split(" ")[0],
                              style: TextStyle(color: Colors.white, fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 65.h,),
              NothingIsHere(height: 180, width: 180,),
            ],
          );
      }
    );
  }
}
