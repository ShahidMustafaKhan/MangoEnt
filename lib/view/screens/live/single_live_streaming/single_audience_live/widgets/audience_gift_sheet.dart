import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/audience_gift_card.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'package:teego/view_model/gift_contoller.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../../parse/UserModel.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/live_controller.dart';
import '../../../../../widgets/custom_buttons.dart';
import '../../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import 'audio_coHost_gift_widget.dart';
import 'multi_coHost_gift_widget.dart';

class AudienceGiftSheet extends StatefulWidget {
  final BattleViewModel? battleViewModel;
  
  AudienceGiftSheet({this.battleViewModel});

  @override
  State<AudienceGiftSheet> createState() => _AudienceGiftSheetState();
}

class _AudienceGiftSheetState extends State<AudienceGiftSheet> {
  bool isFirstUserSelected = false;
  int selectedIndex = 0;
  bool all = false;
  String selectedGift = '';
  String selectedGiftMp3 = '';
  String selectedQuantity = '99';
  late int selectedCoin ;
  List<String> tabs = ['Gifts', 'My bag', 'New'];
  String selectedTab = 'Gifts';
  late final BattleViewModel? battleViewModel;

  @override
  void initState() {
    battleViewModel = widget.battleViewModel;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    ZegoController zegoController = Get.find();
    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (liveViewModel) {
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: battleViewModel != null && battleViewModel!.isBattleView ? 16 : 12),
            if(liveViewModel.isMultiGuest && liveViewModel.role == ZegoLiveRole.audience)
              MultiCoHostGiftAvatar(),
            if(liveViewModel.isAudioLive && liveViewModel.role == ZegoLiveRole.audience)
              AudioCoHostGiftAvatar(),
            if(battleViewModel != null && battleViewModel!.isBattleView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: ()=> setState(() {
                        all=!all;
                      }) ,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.grey,
                        ),
                        child: Text(
                          'All',
                          style: sfProDisplayRegular.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isFirstUserSelected=true;
                        });
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(battleViewModel!.battleModel.getHost!.getAvatar!.url!),
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: isFirstUserSelected || all==true ? AppColors.yellowColor : AppColors.grey, width: 3),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: isFirstUserSelected || all==true ? AppColors.yellowColor : AppColors.grey,
                              child: Image.asset(AppImagePath.chessIcon, width: 15, height: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      width: 5,
                      height: 50,
                      color: AppColors.yellowColor,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isFirstUserSelected=false;
                        });
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(battleViewModel!.playerBAvatar),
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: !isFirstUserSelected || all==true ? AppColors.yellowColor : AppColors.grey, width: 3),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: !isFirstUserSelected || all==true ? AppColors.yellowColor : AppColors.grey,
                              child: Text('2', style: sfProDisplaySemiBold.copyWith(color: AppColors.black, fontSize: 14)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: LinearPercentIndicator(
                            animation: true,
                            padding: const EdgeInsets.all(0),
                            lineHeight: 12.0,
                            animationDuration: 2500,
                            percent: 0.7,
                            barRadius: const Radius.circular(10),
                            progressColor: AppColors.yellowColor,
                            backgroundColor: AppColors.progressBgColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppImagePath.chestIcon, height: 28, width: 28),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Lv.1', style: sfProDisplayMedium.copyWith(color: AppColors.greyText)),
                  const Spacer(),
                  Text('EXP  3350/5000', style: sfProDisplayMedium.copyWith(color: AppColors.greyText)),
                  const SizedBox(width: 60),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    tabs.length,
                        (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = tabs[index];
                        });
                      },
                      child: TabBar(
                        tabName: tabs[index],
                        isSelected: selectedTab == tabs[index],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8.w),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(color: AppColors.grey300, thickness: 2),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StreamerGiftCard(
                          giftImage: AppImagePath.lamborghiniImage,
                          giftName: 'Lamborghini',
                          coins: '10',
                          score: '5/5',
                          progress: 0.9,
                          bgColor: selectedGift == AppImagePath.lamborghini ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.lamborghini;
                              selectedGiftMp3 = AppImagePath.lamborghiniMp3;
                              selectedCoin=10;
                            });

                            // Get.back();
                            // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.princessWeddingSvga, AppImagePath.princessWeddingMp3);
                          },
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: StreamerGiftCard(
                          giftImage: AppImagePath.bearCastleImage,
                          giftName: 'Bear Castle',
                          coins: '1000',
                          score: '4/5',
                          progress: 0.7,
                          bgColor: selectedGift == AppImagePath.bearCastle ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.bearCastle;
                              selectedGiftMp3 = AppImagePath.bearCastleMp3;
                              selectedCoin=1000;
                            });
                            // Get.back();
                            // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.happyBirthdaySvga, AppImagePath.happyBirthdayMp3);
                          },
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: StreamerGiftCard(
                          giftImage: AppImagePath.yachtIslandImage,
                          giftName: 'Yacht Island',
                          coins: '100',
                          score: '5/10',
                          progress: 0.5,
                          bgColor: selectedGift == AppImagePath.yachtIsland ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.yachtIsland;
                              selectedGiftMp3 = AppImagePath.yachtIslandMp3;
                              selectedCoin=100;
                            });
                            // Get.back();
                            // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.dragonSvga, AppImagePath.dragonMp3);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: StreamerGiftCard(
                          giftImage: AppImagePath.babyDragonImage,
                          giftName: 'Baby Dragon',
                          coins: '220',
                          score: '5/5',
                          progress: 0.9,
                          bgColor: selectedGift == AppImagePath.babyDragon ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.babyDragon;
                              selectedGiftMp3 = AppImagePath.babyDragonMp3;
                              selectedCoin=220;
                            });
                            // Get.back();
                            // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.greatPalaceSvga, AppImagePath.greatPalaceMp3);
                          },
                        ),
                      ),
                      const SizedBox(width: 11),
                      // Expanded(
                      //   child: StreamerGiftCard(
                      //     giftImage: AppImagePath.flyingPhoenixImage,
                      //     giftName: 'Flying Phoenix',
                      //     coins: '130',
                      //     score: '4/5',
                      //     progress: 0.7,
                      //     bgColor: selectedGift == AppImagePath.flyingPhoenix ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                      //     onSelect: () {
                      //       setState(() {
                      //         selectedGift = AppImagePath.flyingPhoenix;
                      //         selectedGiftMp3 = AppImagePath.flyingPhoenixMp3;
                      //         selectedCoin=130;
                      //       });
                      //       // Get.back();
                      //       // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.lionEntrySvga, AppImagePath.lionEntryMp3);
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(width: 11),
                      Expanded(
                        child: StreamerGiftCard(
                          giftImage: AppImagePath.heartsImage,
                          giftName: 'Hearts',
                          coins: '980',
                          score: '5/10',
                          progress: 0.5,
                          bgColor: selectedGift == AppImagePath.hearts ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.hearts;
                              selectedGiftMp3 = AppImagePath.heartMp3;
                              selectedCoin=980;
                            });
                            // Get.back();
                            // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.runningTigerSvga, AppImagePath.runningTigerMp3);
                          },
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: StreamerGiftCard(
                          giftImage: AppImagePath.kissingImage,
                          giftName: 'Kissing',
                          coins: '220',
                          score: '5/5',
                          progress: 0.9,
                          bgColor: selectedGift == AppImagePath.kissingGift ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.kissingGift;
                              selectedGiftMp3 = AppImagePath.kissingGiftMp3;
                              selectedCoin=220;
                            });
                            // Get.back();
                            // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.greatPalaceSvga, AppImagePath.greatPalaceMp3);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // Expanded(
                      //   child: StreamerGiftCard(
                      //     giftImage: AppImagePath.kissingImage,
                      //     giftName: 'Kissing',
                      //     coins: '220',
                      //     score: '5/5',
                      //     progress: 0.9,
                      //     bgColor: selectedGift == AppImagePath.kissingGift ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                      //     onSelect: () {
                      //       setState(() {
                      //         selectedGift = AppImagePath.kissingGift;
                      //         selectedGiftMp3 = AppImagePath.kissingGiftMp3;
                      //         selectedCoin=220;
                      //       });
                      //       // Get.back();
                      //       // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.greatPalaceSvga, AppImagePath.greatPalaceMp3);
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(width: 11),

                      Expanded(
                        child: StreamerGiftCard(
                          giftImage: AppImagePath.motorCycleImage,
                          giftName: 'Motorcycle',
                          coins: '130',
                          score: '4/5',
                          progress: 0.7,
                          bgColor: selectedGift == AppImagePath.motorCycleEntry ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.motorCycleEntry;
                              selectedGiftMp3 = AppImagePath.motorcycleMp3;
                              selectedCoin=130;
                            });
                            // Get.back();
                            // Get.find<AudienceViewModel>().loadAnimation(AppImagePath.lionEntrySvga, AppImagePath.lionEntryMp3);
                          },
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.asset(AppImagePath.coinsIcon, width: 15, height: 15),
                      const SizedBox(width: 5),
                      const Text('100'),
                      const SizedBox(width: 5),
                      Icon(Icons.arrow_forward_ios, size: 15, color: AppColors.yellowColor),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor.withOpacity(0.15), width: 2),
                      color: AppColors.button,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        CoinsCountWidget(
                          count: '1',
                          isSelected: selectedQuantity == '1',
                          onTap: () {
                            setState(() {
                              selectedQuantity = '1';
                            });
                          },
                        ),
                        const SizedBox(width: 7),
                        CoinsCountWidget(
                          count: '10',
                          isSelected: selectedQuantity == '10',
                          onTap: () {
                            setState(() {
                              selectedQuantity = '10';
                            });
                          },
                        ),
                        const SizedBox(width: 7),
                        CoinsCountWidget(
                          count: '99',
                          isSelected: selectedQuantity == '99',
                          onTap: () {
                            setState(() {
                              selectedQuantity = '99';
                            });
                          },
                        ),
                        const SizedBox(width: 7),
                        CoinsCountWidget(
                          count: '999',
                          isSelected: selectedQuantity == '9999',
                          onTap: () {
                            setState(() {
                              selectedQuantity = '9999';
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        PrimaryButton(
                          title: 'Send',
                          textStyle: sfProDisplayRegular.copyWith(fontSize: 14, color: AppColors.black),
                          height: 35,
                          width: 50,
                          borderRadius: 30,
                          bgColor: AppColors.yellowColor,
                          onTap: () {
                            if(selectedGift.isNotEmpty){
                              Get.back();
                              if(battleViewModel!= null && battleViewModel!.isBattleView==true){
                                if(all==true){
                                  battleViewModel!.sendGiftToAllTeams(gift: selectedGift, audio: selectedGiftMp3, coins: int.parse(selectedQuantity)* selectedCoin);
                                }
                                else{
                                  if(isFirstUserSelected==true)
                                    battleViewModel!.sendGiftToTeamA(gift: selectedGift, audio: selectedGiftMp3, coins: int.parse(selectedQuantity)* selectedCoin);
                                  else
                                    battleViewModel!.sendGiftToTeamB(gift: selectedGift, audio: selectedGiftMp3, coins: int.parse(selectedQuantity)* selectedCoin);
                                }
                              }
                              else
                                Get.find<LiveViewModel>().sendGift(gift: selectedGift, audio: selectedGiftMp3, coins: int.parse(selectedQuantity)* selectedCoin);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }
    );
  }
}

class ActiveUserWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.yellowColor, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                AppImagePath.cardImage2,
                width: 45,
                height: 45,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '🔥🔥Soqniqn',
            style: sfProDisplayMedium.copyWith(fontSize: 10),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class TabBar extends StatelessWidget {
  final String tabName;
  final bool isSelected;

  const TabBar({
    required this.tabName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tabName,
          style: sfProDisplaySemiBold.copyWith(
            fontSize: isSelected ? 20 : 16,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 7),
        if (isSelected)
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 3,
          ),
      ],
    );
  }
}

class CoinsCountWidget extends StatelessWidget {
  final String count;
  final bool isSelected;
  final VoidCallback onTap;

  const CoinsCountWidget({
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor.withOpacity(0.15), width: 2),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: count=="1" ? 2.w : 0),
          child: Text(
            count,
            style: sfProDisplayRegular.copyWith(color: isSelected ? AppColors.yellowColor : AppColors.white),
          ),
        ),
      ),
    );
  }
}
