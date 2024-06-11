import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../widgets/custom_buttons.dart';

class AdminListSheet extends StatelessWidget {
  const AdminListSheet();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  1,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Row(
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.grey300,
                            backgroundImage:
                                AssetImage(AppImagePath.profilePic),
                          ),
                          Positioned(
                              right: 5,
                              bottom: 1,
                              child: Container(
                                width: 10.w,
                                height: 10.h,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                              ))
                        ]),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Savannah Nguyen'),
                                const SizedBox(width: 16),
                                SvgPicture.asset(
                                  AppImagePath.franceFlag,
                                  width: 24,
                                  height: 17,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'id: 12345678',
                                  style: sfProDisplayRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.white.withOpacity(0.7)),
                                ),
                                const SizedBox(width: 10),
                                Icon(Icons.copy,
                                    size: 15,
                                    color: AppColors.white.withOpacity(0.7)),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        PrimaryButton(
                          width: 65.w,
                          height: 32.h,
                          title: 'Remove',
                          borderRadius: 35,
                          textStyle: sfProDisplayMedium.copyWith(
                              fontSize: 16, color: AppColors.black),
                          bgColor: AppColors.yellowBtnColor,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
