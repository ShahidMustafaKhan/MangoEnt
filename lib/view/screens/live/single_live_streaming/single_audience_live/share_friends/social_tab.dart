import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../widgets/custom_buttons.dart';


class SocialTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.grey300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImagePath.cardImage2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Unmissable broadcast come and join us to share the fun!...',
                      style: sfProDisplayMedium.copyWith(fontSize: 12, height: 1.5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  PrimaryButton(
                    width: 95,
                    height: 40,
                    borderRadius: 30,
                    bgColor: AppColors.yellowColor,
                    onTap: () {},
                    title: 'Copy',
                    textStyle: sfProDisplayRegular.copyWith(fontSize: 16, color: AppColors.black),
                  )
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Image.asset(
                    AppImagePath.link,
                    width: 15,
                    height: 15,
                    color: AppColors.white.withOpacity(0.6),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'https://www.emolm.com/us/m/v/17120184694772079622/ind',
                      style: sfProDisplayRegular.copyWith(
                        fontSize: 12,
                        color: AppColors.white.withOpacity(0.6),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}