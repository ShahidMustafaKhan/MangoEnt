import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';

class TopFanView extends StatefulWidget {

  @override
  State<TopFanView> createState() => _TopFanViewState();
}

class _TopFanViewState extends State<TopFanView> {
  String activeTab = "Daily";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey700,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                  Text(
                    '15k 🚨 MICMIC',
                    style: sfProDisplayMedium.copyWith(color: AppColors.white, fontSize: 16),
                  ),
                  const Icon(Icons.arrow_back_ios_new, color: Colors.transparent),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.grey900,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activeTab = 'Daily';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: activeTab == 'Daily' ? AppColors.yellowColor : AppColors.grey900,
                      ),
                      child: Text(
                        'Daily',
                        style: sfProDisplayRegular.copyWith(color: activeTab == 'Daily' ? AppColors.black : AppColors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activeTab = 'Weekly';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: activeTab == 'Weekly' ? AppColors.yellowColor : AppColors.grey900,
                      ),
                      child: Text(
                        'Weekly',
                        style: sfProDisplayRegular.copyWith(color: activeTab == 'Weekly' ? AppColors.black : AppColors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activeTab = 'Monthly';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: activeTab == 'Monthly' ? AppColors.yellowColor : AppColors.grey900,
                      ),
                      child: Text(
                        'Monthly',
                        style: sfProDisplayRegular.copyWith(color: activeTab == 'Monthly' ? AppColors.black : AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Image.asset(AppImagePath.levelBadge, width: 120, height: 120),
                Positioned(
                  top: 40,
                  left: 29,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(AppImagePath.cardImage1, fit: BoxFit.contain, width: 64, height: 64),
                  ),
                ),
              ],
            ),
            Text('Enrique Perkins', style: sfProDisplayMedium.copyWith(fontSize: 14)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                color: AppColors.lightPurple,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImagePath.gemStone, height: 15, width: 15),
                  const SizedBox(width: 5),
                  const Text('LV.9'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImagePath.diamondIcon, height: 18, width: 18),
                const SizedBox(width: 5),
                Text(
                  '6.72M',
                  style: sfProDisplayRegular.copyWith(color: AppColors.yellowColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 3),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 2}',
                          style: sfProDisplaySemiBold.copyWith(fontSize: 15, color: AppColors.white.withOpacity(0.7)),
                        ),
                        const SizedBox(width: 15),
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(AppImagePath.diamondIcon, height: 18, width: 18),
                                const SizedBox(width: 5),
                                Text(
                                  '8811M',
                                  style: sfProDisplayRegular.copyWith(color: AppColors.yellowColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(35)),
                              color: AppColors.lightPurple,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(AppImagePath.gemStone, height: 15, width: 15),
                                const SizedBox(width: 5),
                                Text('LV.9', style: sfProDisplayRegular.copyWith(fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
