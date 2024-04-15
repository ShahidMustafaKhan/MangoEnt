import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';

import '../widgets/invitation_dialog.dart';

class AllFriendsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text('Select all friends'),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.yellowColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              constraints: BoxConstraints(
                maxHeight: 330.h,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.grey300,
                            backgroundImage: AssetImage(AppImagePath.cardImage2),
                          ),
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
                                    'id: 01251421',
                                    style: sfProDisplayRegular.copyWith(fontSize: 12, color: AppColors.white.withOpacity(0.7)),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(Icons.copy, size: 15, color: AppColors.white.withOpacity(0.7)),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.white.withOpacity(0.7), width: 2),
                              color: AppColors.yellowColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              PrimaryButton(
                title: 'Invite (0)',
                borderRadius: 35,
                textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
                bgColor: AppColors.yellowBtnColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        // child: InvitationDialog(),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}