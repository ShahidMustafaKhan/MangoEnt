import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:teego/utils/constants/app_constants.dart';

import '../../../../../../utils/theme/colors_constant.dart';

class ThreeLiveWidget extends StatefulWidget {
  final CameraController cameraController;
  ThreeLiveWidget({Key? key, required this.cameraController}) : super(key: key);

  @override
  State<ThreeLiveWidget> createState() => _ThreeLiveWidgetState();
}

class _ThreeLiveWidgetState extends State<ThreeLiveWidget> {
  List<String> peoples = ['3P', '4P', '6P', '9P', '12P'];
  String selectedPeople = '3P';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 25),
      child: Column(
        children: [
          Expanded(
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
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  ...List.generate(
                    peoples.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPeople = peoples[index];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: selectedPeople == peoples[index] ? AppColors.black.withOpacity(0.8) : AppColors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppImagePath.bitCoinSofa, width: 25, height: 25),
                            SizedBox(width: 5),
                            Text(peoples[index]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
