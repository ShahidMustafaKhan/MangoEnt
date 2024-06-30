import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/audience_gift_card.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'package:teego/view_model/chat_controller.dart';
import 'package:teego/view_model/whisper_controller.dart';


import '../../../../../../parse/UserModel.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../parse/MessageModel.dart';
import '../../../widgets/custom_buttons.dart';


class MessageGiftSheet extends StatefulWidget {

  final UserModel? profileUser;
  final bool isProfileUser;
  final bool whisper;

  MessageGiftSheet({this.profileUser, this.whisper=false, this.isProfileUser=false});

  @override
  State<MessageGiftSheet> createState() => _MessageGiftSheetState();
}

class _MessageGiftSheetState extends State<MessageGiftSheet> {
  bool isFirstUserSelected = false;
  int selectedIndex = 0;
  bool all = false;
  String selectedGift = '';
  String selectedGiftMp3 = '';
  String selectedQuantity = '99';
  late int selectedCoin ;
  List<String> tabs = ['Gifts', 'My bag', 'New'];
  String selectedTab = 'Gifts';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                          bgColor: selectedGift == AppImagePath.lamborghiniImage ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.lamborghiniImage;
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
                          bgColor: selectedGift == AppImagePath.bearCastleImage ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.bearCastleImage;
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
                          bgColor: selectedGift == AppImagePath.yachtIslandImage ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.yachtIslandImage;
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
                          bgColor: selectedGift == AppImagePath.babyDragonImage ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.babyDragonImage;
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
                          bgColor: selectedGift == AppImagePath.heartsImage ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.heartsImage;
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
                          bgColor: selectedGift == AppImagePath.kissingImage ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.kissingImage;
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
                          bgColor: selectedGift == AppImagePath.motorCycleImage ? AppColors.yellowColor.withOpacity(0.5) : AppColors.button,
                          onSelect: () {
                            setState(() {
                              selectedGift = AppImagePath.motorCycleImage;
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
                          isSelected: selectedQuantity == '999',
                          onTap: () {
                            setState(() {
                              selectedQuantity = '999';
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
                            if(widget.whisper == false)
                                Get.find<ChatViewModel>().saveMessage(MessageModel.messageTypeGif,
                                     messageType: MessageModel.messageTypeGif, onTap: () {}, gif: selectedGift, coins: selectedCoin, amount: int.parse(selectedQuantity) );
                            else
                              Get.find<WhisperViewModel>().saveMessage(MessageModel.messageTypeGif,
                                  messageType: MessageModel.messageTypeGif, onTap: () {}, gif: selectedGift, coins: selectedCoin, amount: int.parse(selectedQuantity) );
                                Get.back();
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
