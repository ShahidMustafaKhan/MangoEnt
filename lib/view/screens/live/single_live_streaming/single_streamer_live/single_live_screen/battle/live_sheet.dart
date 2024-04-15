import 'package:flutter/material.dart';

import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../widgets/custom_buttons.dart';


class LiveSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.close, color: Colors.transparent),
                Text(
                  'Live',
                  style: quinlliykRegular.copyWith(fontSize: 24),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image:  DecorationImage(
                      image: AssetImage(AppImagePath.cardImage2),
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.yellowColor, width: 1),
                  ),
                ),
                Image.asset(AppImagePath.boxingIcon, width: 60, height: 60),
                Image.asset(AppImagePath.authentication, width: 80, height: 80),
              ],
            ),
            const Spacer(),
            PrimaryButton(
              bgColor: AppColors.yellowColor,
              borderRadius: 50,
              title: 'Leave',
              textStyle: sfProDisplaySemiBold.copyWith(color: Colors.black, fontSize: 16),
              onTap: () {},
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
