import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../../utils/Utils.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../widgets/custom_buttons.dart';


class GiftCard extends StatelessWidget {
  final String giftImage;
  final String giftName;
  final String coins;
  final String score;
  final double progress;
  final VoidCallback onSend;

  const GiftCard({
    required this.giftImage,
    required this.giftName,
    required this.coins,
    required this.score,
    required this.progress,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SizedBox(
      width: 106.58*fem,
      child: Stack(
        children: [
          Positioned(
            // bg2jh (1:19982)
            left: 0*fem,
            top: 0.879119873*fem,
            child: Align(
              child: SizedBox(
                width: 106.58*fem,
                height: 170.58*fem,
                child: Container(
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(5*fem),
                    color: const Color(0xff2a2634),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x3f000000),
                        offset: Offset(0*fem, 4*fem),
                        blurRadius: 2*fem,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // Wes (1:19983)
            left: 47*fem,
            top: 124*fem,
            child: Align(
              child: SizedBox(
                height: 14*fem,
                child: Text(
                  '$score/$coins',
                  style: SafeGoogleFont (
                    'DM Sans',
                    fontSize: 10*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.4*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 77*fem,
            child: Container(
              width:  106.58*fem,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30.21*fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 2.21*fem),
                          child: Text(
                            giftName,
                            style: SafeGoogleFont (
                              'DM Sans',
                              fontSize: 10*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4*ffem/fem,
                              color: Color(0xff9e9e9e),
                            ),
                          ),
                        ),
                        Container(
                          width: 47*fem,
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0.63*fem),
                                width: 11*fem,
                                height: 11*fem,
                                child: Image.asset(
                                  AppImagePath.coinsIcon,
                                  width: 11*fem,
                                  height: 11*fem,
                                ),
                              ),
                              Text(
                                '3',
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 10.5*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4*ffem/fem,
                                  color: Color(0xff9e9e9e),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 17*fem,
            top: 0*fem,
            child: Align(
              child: SizedBox(
                width: 76.12*fem,
                height: 76.12*fem,
                child: Image.asset(
                  giftImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 9 * fem,
            top: 112 * fem,
            child: SizedBox(
              width: 88 * fem,
              height: 5 * fem,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14 * fem),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14 * fem),
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.progressBgColor,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.progressLinearGreenColor1), // Color of the progress indicator
                    value: progress , // Set the value of the progress bar (between 0.0 and 1.0)
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 146 * fem ,
            child: Container(
              height: 20,
              width: 106.58*fem,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    title: int.parse(score)>=int.parse(coins) ? 'Completed' : 'Send',
                    textStyle: sfProDisplayRegular.copyWith(fontSize:  int.parse(score)>=int.parse(coins) ? 12 : 14, color: AppColors.black),
                    height: 20,
                    width: 50,
                    borderRadius: 30,
                    bgColor: AppColors.yellowColor,
                    onTap: onSend,
                  ),
                ],
              ),
            ),
          ),




        ],
      ),
    );




    //   Container(
    //   padding: const EdgeInsets.symmetric( vertical: 6),
    //   decoration: BoxDecoration(
    //     color: Color(0xff323232).withOpacity(0.4),
    //     borderRadius: BorderRadius.circular(5),
    //     border: Border.all(color: Color(0xffCFCFFC26).withOpacity(0.02)),
    //
    //   ),
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 18,),
    //         child: Column(
    //             children: [
    //               Image.asset(giftImage, width: 75, height: 75),
    //               const SizedBox(height: 15),
    //               FittedBox(
    //                 child: Text(
    //                   giftName,
    //                   style: sfProDisplayMedium.copyWith(fontSize: 12),
    //                 ),
    //               ),
    //               const SizedBox(height: 6),
    //               Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Image.asset(AppImagePath.coinsIcon, width: 12, height: 12),
    //                   const SizedBox(width: 5),
    //                   Text(
    //                     coins,
    //                     style: sfProDisplayMedium.copyWith(fontSize: 12),
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 20,
    //                 width: 70,
    //                 child: LinearPercentIndicator(
    //                   animation: true,
    //                   animateFromLastPercent: true,
    //                   padding: const EdgeInsets.all(0),
    //                   lineHeight: 5.0,
    //                   width: 70,
    //                   animationDuration: 2500,
    //                   percent: progress,
    //                   barRadius: const Radius.circular(10),
    //                   progressColor: AppColors.progressLinearGreenColor1,
    //                   backgroundColor: AppColors.progressBgColor,
    //                 ),
    //               ),
    //               const SizedBox(height: 6),
    //               Text(
    //                 score,
    //                 style: sfProDisplayMedium.copyWith(fontSize: 12),
    //               ),
    //             ]),
    //       ),
    //
    //
    //       PrimaryButton(
    //         title: int.parse(score)>=int.parse(coins) ? 'Completed' : 'Send',
    //         textStyle: sfProDisplayRegular.copyWith(fontSize:  int.parse(score)>=int.parse(coins) ? 12 : 14, color: AppColors.black),
    //         height: 30,
    //         width: 50,
    //         borderRadius: 30,
    //         bgColor: AppColors.yellowColor,
    //         onTap: onSend,
    //       ),
    //     ],
    //   ),
    // );
  }
}
