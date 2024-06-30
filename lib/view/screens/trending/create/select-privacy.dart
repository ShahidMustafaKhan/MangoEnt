import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

import '../../../../utils/Utils.dart';
import '../../../../utils/colors_hype.dart';



class SelectPrivacy extends StatefulWidget {

  @override
  State<SelectPrivacy> createState() => _SelectPrivacyState();
}

class _SelectPrivacyState extends State<SelectPrivacy> {
  bool isPublic=true;
  bool isFriends=false;
  bool isOnlyMe=false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return BaseScaffold(
      appBar: AppBar(title: Text(
        'Select Privacy',
        style: SafeGoogleFont (
          'DM Sans',
          fontSize: 16*ffem,
          fontWeight: FontWeight.w700,
          height: 1.375*ffem/fem,
          color: Color(0xffffffff),
        ),
      ),),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration (
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // frame51610dUM (5:17722)
                    margin: EdgeInsets.fromLTRB(15*fem, 25*fem, 35*fem, 15.5*fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // whocanseeyourpostNB3 (5:17723)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                          child: Text(
                            'Who can see your post?',
                            style: SafeGoogleFont (
                              'DM Sans',
                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.375*ffem/fem,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Container(
                          // yourpostwillappearinnewsfeedon (5:17724)
                          constraints: BoxConstraints (
                            maxWidth: 325*fem,
                          ),
                          child: Text(
                            'Your post will appear in News Feed, on your profile and in search results. ',
                            style: SafeGoogleFont (
                              'DM Sans',
                              fontSize: 14*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2857142857*ffem/fem,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isPublic=true;
                        isFriends=false;
                        isOnlyMe=false;
                      });
                    },
                    child: Container(
                      // publicZFX (5:17704)
                      padding: EdgeInsets.fromLTRB(16.53*fem, 14*fem, 15*fem, 14*fem),
                      width: double.infinity,
                      height: 50*fem,
                      decoration: BoxDecoration (
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // frame51610fJZ (5:17706)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: isPublic,
                                  child: Container(
                                    // radioawK (5:17707)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16.53*fem, 0*fem),
                                    width: 16.94*fem,
                                    height: 16.94*fem,
                                    child: Image.asset(
                                      'assets/reels/radio_active.png',
                                      width: 16.94*fem,
                                      height: 16.94*fem,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isPublic==false,
                                  child: Container(
                                    // radiopDP (5:17713)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                    width: 18*fem,
                                    height: 18*fem,
                                    child: Image.asset(
                                      'assets/reels/radio.png',
                                      width: 18*fem,
                                      height: 18*fem,
                                    ),
                                  ),
                                ),
                                Text(
                                  // livenotificationJ6d (5:17708)
                                  'Public',
                                  style: SafeGoogleFont (
                                    'DM Sans',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.375*ffem/fem,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            // todayEW5 (5:17709)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 2*fem),
                            width: 16*fem,
                            height: 16*fem,
                            child: Image.asset(
                              'assets/reels/public.png',
                              width: 16*fem,
                              height: 16*fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isPublic=false;
                        isFriends=true;
                        isOnlyMe=false;
                      });
                    },
                    child: Container(
                      // publicMah (5:17710)
                      padding: EdgeInsets.fromLTRB(16*fem, 14*fem, 14.5*fem, 14*fem),
                      width: double.infinity,
                      height: 50*fem,
                      decoration: BoxDecoration (
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // frame51610Ghf (5:17712)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: isFriends,
                                  child: Container(
                                    // radioawK (5:17707)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16.53*fem, 0*fem),
                                    width: 16.94*fem,
                                    height: 16.94*fem,
                                    child: Image.asset(
                                      'assets/reels/radio_active.png',
                                      width: 16.94*fem,
                                      height: 16.94*fem,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isFriends==false,
                                  child: Container(
                                    // radiopDP (5:17713)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                    width: 18*fem,
                                    height: 18*fem,
                                    child: Image.asset(
                                      'assets/reels/radio.png',
                                      width: 18*fem,
                                      height: 18*fem,
                                    ),
                                  ),
                                ),
                                Text(
                                  // livenotificationLBj (5:17714)
                                  'Friends',
                                  style: SafeGoogleFont (
                                    'DM Sans',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.375*ffem/fem,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            // todayfUu (5:17715)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 2*fem),
                            width: 17.5*fem,
                            height: 14*fem,
                            child: Image.asset(
                              'assets/reels/friends.png',
                              width: 17.5*fem,
                              height: 14*fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isPublic=false;
                        isFriends=false;
                        isOnlyMe=true;
                      });
                    },
                    child: Container(
                      // publiczGH (5:17716)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 116*fem),
                      padding: EdgeInsets.fromLTRB(16*fem, 14*fem, 16.75*fem, 14*fem),
                      width: double.infinity,
                      height: 50*fem,
                      decoration: BoxDecoration (
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // frame516105Yd (5:17718)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: isOnlyMe,
                                  child: Container(
                                    // radioawK (5:17707)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16.53*fem, 0*fem),
                                    width: 16.94*fem,
                                    height: 16.94*fem,
                                    child: Image.asset(
                                      'assets/reels/radio_active.png',
                                      width: 16.94*fem,
                                      height: 16.94*fem,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isOnlyMe==false,
                                  child: Container(
                                    // radiopDP (5:17713)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                    width: 18*fem,
                                    height: 18*fem,
                                    child: Image.asset(
                                      'assets/reels/radio.png',
                                      width: 18*fem,
                                      height: 18*fem,
                                    ),
                                  ),
                                ),
                                Text(
                                  // livenotification8G1 (5:17720)
                                  'Only me',
                                  style: SafeGoogleFont (
                                    'DM Sans',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.375*ffem/fem,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            // today4QZ (5:17721)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 2*fem),
                            width: 12.25*fem,
                            height: 14*fem,
                            child: Image.asset(
                              'assets/reels/ic_lock.png',
                              width: 12.25*fem,
                              height: 14*fem,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: (){
                if(isPublic){
                  Navigator.pop(context,{"privacy":"Public"});
                }
                else if(isFriends){
                  Navigator.pop(context,{"privacy":"Friends"});
                }
                else if(isOnlyMe){
                  Navigator.pop(context,{"privacy":"Only Me"});
                }
              },
              child: Container(
                // autogroupbrnqJ41 (Qrv3mkC2yKtockjPGqbRNq)
                padding: EdgeInsets.fromLTRB(15*fem, 0*fem, 15*fem, 0*fem),
                width: double.infinity,
                child: Container(
                  // buttonDAy (I5:17703;0:15783)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 13*fem),
                  width: double.infinity,
                  height: 48*fem,
                  decoration: BoxDecoration (
                    color: AppColors.yellowBtnColor,
                    borderRadius: BorderRadius.circular(24*fem),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont (
                        'DM Sans',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.375*ffem/fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}