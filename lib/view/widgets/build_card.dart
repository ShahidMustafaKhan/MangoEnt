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

class BuildCard extends StatelessWidget {
  final String cFlag;
  final String cName;
  final String imagePath;
  final int count;
  final String name;
  final String avatar;
  final LiveStreamingModel liveModel;


  BuildCard({Key? key,
    required this.cFlag,
    required this.cName,
    required this.liveModel,
    required this.imagePath,
    required this.count,
    required this.name,
    required this.avatar,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> LivePermissionHandler.checkPermission(liveModel.getStreamingType, context, liveStreamingModel: liveModel),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            image:
            DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              margin: EdgeInsets.all(4.w),
              width: 84.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.black.withOpacity(0.4)]),
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
                  Text(
                      cName,
                      style: sfProDisplaySemiBold.copyWith(color: Colors.white, fontSize: 12.sp)
                  )
                ],
              ),
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
                              borderRadius: BorderRadius.circular(19.w),
                              color: Colors.black.withOpacity(0.5)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppImagePath.diamond),
                              SizedBox(width: 6.w),
                              FittedBox(
                                  child: Text(
                                      count.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: sfProDisplayLight.copyWith(color: Colors.white, fontSize: 10.sp)
                                  ))
                            ],
                          ),
                        ),
                        Text(
                          name,
                          style: sfProDisplayBold.copyWith(color: Colors.white, fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                            width: 2.w, color: CupertinoColors.systemYellow),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(avatar), fit: BoxFit.cover)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
