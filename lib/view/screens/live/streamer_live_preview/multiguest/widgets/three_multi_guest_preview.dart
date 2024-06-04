import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view_model/live_controller.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';

class ThreePerson extends StatefulWidget {
  final CameraController cameraController;
  const ThreePerson({Key? key, required this.cameraController}) : super(key: key);

  @override
  State<ThreePerson> createState() => _ThreePersonState();
}

class _ThreePersonState extends State<ThreePerson> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                      ),
                      child: Image.asset(
                        AppImagePath.bitCoinSofa,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Divider(color: AppColors.grey300, height: 0),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                      ),
                      child: Image.asset(
                        AppImagePath.bitCoinSofa,
                        height: 30,
                        width: 30,
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
