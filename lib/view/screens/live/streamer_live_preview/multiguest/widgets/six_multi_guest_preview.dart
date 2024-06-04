import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';

class SixPerson extends StatefulWidget {
  final CameraController cameraController;

  const SixPerson({Key? key, required this.cameraController}) : super(key: key);

  @override
  State<SixPerson> createState() => _SixPersonState();
}

class _SixPersonState extends State<SixPerson> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex : 2,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                      ),
                      child: CameraPreview(widget.cameraController),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.black.withOpacity(0.2),
                                  border: Border(
                                      right: BorderSide(
                                          color: AppColors.grey300,
                                          width: 0.0))),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppImagePath.sofaFilled,
                                  height: 25,
                                  width: 25,
                                ),
                              )
                              ),
                        ),
                        Expanded(
                          child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.black.withOpacity(0.2),
                                  border: Border(
                                      right: BorderSide(
                                          color: AppColors.grey300,
                                          width: 0.0))),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppImagePath.sofaFilled,
                                  height: 25,
                                  width: 25,
                                ),
                              )
                              ),
                        ),
                      ],
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
                              bottom: BorderSide(
                                  color: AppColors.grey300,
                                  width: 0.0))
                      ),
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
                              bottom: BorderSide(
                                  color: AppColors.grey300,
                                  width: 0.0))
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
