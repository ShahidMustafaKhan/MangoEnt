import 'package:flutter/material.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../widgets/custom_buttons.dart';

class InvitationDialog extends StatelessWidget {
  final Function() onAccept;
  final String avatar;

  InvitationDialog({required this.onAccept, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.grey500,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.close, color: Colors.transparent),
                  Text(
                    'Invitation',
                    style: sfProDisplayBold.copyWith(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(thickness: 2),
              const SizedBox(height: 20),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  image:  DecorationImage(
                    image: NetworkImage(avatar),
                  ),
                  borderRadius: BorderRadius.circular(80),
                  border: Border.all(color: AppColors.purpleColor, width: 2),
                ),
              ),
              const SizedBox(height: 50),
              PrimaryButton(
                bgColor: AppColors.yellow.withOpacity(0.3),
                title: 'Join me for an epic battle!',
                textStyle: sfProDisplaySemiBold.copyWith(fontSize: 15),
                onTap: () {
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      title: 'Cancel',
                      height: 40,
                      borderRadius: 35,
                      textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.yellowColor),
                      bgColor: AppColors.grey500,
                      borderColor: AppColors.yellowColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      title: 'Accept',
                      borderRadius: 35,
                      height: 40,
                      textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
                      bgColor: AppColors.yellowBtnColor,
                      onTap: () {
                        onAccept();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: -30,
            left: -20,
            child: Image.asset(AppImagePath.megaphone, width: 115, height: 115),
          ),
        ],
      ),
    );
  }
}
