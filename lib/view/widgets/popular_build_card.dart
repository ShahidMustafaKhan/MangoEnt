import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/utils/permission/go_live_permission.dart';
import '../../parse/LiveStreamingModel.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/typography.dart';
import '../../view_model/trending_controller.dart';

class PopularBuildCard extends StatelessWidget {
  final String cFlag;
  final String cName;
  final String tagPic;
  final String tagName;
  final String imagePath;
  final String message;
  final String name;
  final String avatar;
  final int count;
  final LiveStreamingModel liveModel;

  PopularBuildCard({
    Key? key,
    required this.cFlag,
    required this.cName,
    required this.liveModel,
    required this.imagePath,
    required this.message,
    required this.name,
    required this.avatar,
    required this.count,
    required this.tagPic,
    required this.tagName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => LivePermissionHandler.checkPermission(
          LiveStreamingModel.keyTypeSingleLive, context,
          liveStreamingModel: liveModel),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            image: DecorationImage(
                image: NetworkImage(imagePath), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  margin: EdgeInsets.all(4.w),
                  width: 84.w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        Colors.black.withOpacity(0.4)
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(5.r))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        cFlag,
                        height: 15.h,
                        width: 15.w,
                      ),
                      Text(cName,
                          style: sfProDisplaySemiBold.copyWith(
                              color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  padding: EdgeInsets.all(4.w),
                  margin: EdgeInsets.all(4.w),
                  width: 60.w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        Colors.black.withOpacity(0.4)
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(50.r))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      SvgPicture.asset(
                        tagPic,
                        height: 12.h,
                        width: 12.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(tagName,
                          style: sfProDisplaySemiBold.copyWith(
                              color: Colors.white, fontSize: 10.sp)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.w),
                      bottomRight: Radius.circular(8.w))),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(19.w),
                              // color: Colors.black.withOpacity(0.5)
                              ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // SvgPicture.asset(AppImagePath.diamond),
                              // SizedBox(width: 6.w),
                              FittedBox(
                                  child: Text(message,
                                      overflow: TextOverflow.ellipsis,
                                      style: sfProDisplayLight.copyWith(
                                          color: Colors.white,
                                          fontSize: 10.sp)))
                            ],
                          ),
                        ),
                        Text(
                          name,
                          style: sfProDisplayBold.copyWith(
                              color: Colors.white, fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 12.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        // border: Border.all(
                        //     width: 2.w, color: CupertinoColors.systemYellow
                        //     ),
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                            // image: NetworkImage(avatar), fit: BoxFit.cover)
                            image: AssetImage(avatar),
                            fit: BoxFit.cover)),
                  ),
                  FittedBox(
                      child: Text(count.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: sfProDisplayLight.copyWith(
                              color: Colors.white, fontSize: 10.sp)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
