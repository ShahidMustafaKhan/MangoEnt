import 'package:flutter/material.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../utils/constants/app_constants.dart';


class ForYou extends StatelessWidget {
  ForYou();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Drawer(
          width: 170,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 135,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.orangeContainer,
                        AppColors.progressLinearOrangeColor1,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('For You', style: sfProDisplayBold.copyWith(fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(AppImagePath.lightningIcon, width: 36, height: 36),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ...List.generate(
                  10,
                      (index) => Container(
                    height: 125,
                    width: 125,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      image:  DecorationImage(
                        image: AssetImage(AppImagePath.singleLiveBgImage),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: AppColors.black.withOpacity(0.4),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  'Kyle',
                                  style: sfProDisplaySemiBold.copyWith(fontSize: 12),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImagePath.fireIcon,
                                      width: 10,
                                      height: 10,
                                      color: AppColors.white.withOpacity(0.7),
                                    ),
                                    Text(
                                      '343',
                                      style: sfProDisplayRegular.copyWith(
                                        fontSize: 10,
                                        color: AppColors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
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
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: -18,
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
            },
            child: const CircleAvatar(
              radius: 15,
              child: Icon(Icons.close, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
