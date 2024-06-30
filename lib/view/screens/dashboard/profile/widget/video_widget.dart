import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/screens/reels/reels_single_screen.dart';
import 'package:teego/view_model/communityController.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../view_model/streamer_profile_controller.dart';
import '../../../reels/feed/videoutils/video.dart';

class VideoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CommunityController communityController = Get.find();
    StreamerProfileController controller = Get.find();
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h, top: 16.h),
        child: FutureBuilder<List<VideoInfo>>(
            future: communityController.profileVideos(controller.profile! , false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No videos available'));
              }

              final gridItems = snapshot.data!;

              return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: gridItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 163.w / 220.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Get.to(ReelsSingleScreen(currentUser: Get.find<UserViewModel>().currentUser,
                    post: gridItems[index].postModel,));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 220.h,
                        width: 163.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            gridItems[index].postModel!.getAuthor!.getAvatar!.url!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 10,
                        child: Image.asset(
                          AppImagePath.play,
                          height: 12.h,
                          width: 12.w,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 30,
                        child: Text(
                          "${gridItems[index].postModel!.getViews}",
                          style:
                              TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 40,
                        child: Image.asset(
                          AppImagePath.ic_heart,
                          height: 12.h,
                          width: 12.w,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 15,
                        child: Text(
                          "${gridItems[index].postModel!.getLikes!.length}",
                          style:
                              TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
