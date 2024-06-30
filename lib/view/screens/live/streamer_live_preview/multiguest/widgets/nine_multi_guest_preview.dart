import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/live_controller.dart';
import '../../widgets/camera_off_widget.dart';

class NinePerson extends StatelessWidget {
  final CameraController cameraController;
  const NinePerson({Key? key, required this.cameraController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                      ),
                      child: Obx(() {
                        if(liveViewModel.isCameraOn.value)
                          return CameraPreview(cameraController);
                        else
                          return CameraOffPreviewWidget(radius: 17,);
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                        border: Border(
                          right: BorderSide(color: AppColors.grey300,width:0),
                          top: BorderSide(color: AppColors.grey300,width:0),
                          bottom: BorderSide(color: AppColors.grey300,width:0),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                        border: Border(
                          right: BorderSide(color: AppColors.grey300,width:0),
                          bottom: BorderSide(color: AppColors.grey300,width:0),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.2),
                        border: Border(
                          right: BorderSide(color: AppColors.grey300,width:0),
                          left: BorderSide(color: AppColors.grey300,width:0),
                          bottom: BorderSide(color: AppColors.grey300,width:0),
                        ),),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 30,
                          width: 30.w,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                          border: Border(
                            right: BorderSide(color: AppColors.grey300,width:0),
                            bottom: BorderSide(color: AppColors.grey300,width:0),
                          ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                          border: Border(
                            right: BorderSide(color: AppColors.grey300,width:0),
                          ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                        border: Border(
                          bottom: BorderSide(color: AppColors.grey300,width:0),
                        ),),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 30,
                          width: 30.w,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                        border: Border(
                          bottom: BorderSide(color: AppColors.grey300,width:0),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.sofaFilled,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
