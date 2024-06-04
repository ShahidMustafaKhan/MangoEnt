import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/gift_contoller.dart';
import 'gift_card.dart';


class GiftWishSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImagePath.giftOverlay),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bree🦊💥', style: sfProDisplayRegular.copyWith(fontSize: 20)),
                  const SizedBox(width: 10),
                  Text(
                    'Wish List',
                    style: sfProDisplaySemiBold.copyWith(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 17),
                decoration: const BoxDecoration(
                  color: AppColors.button,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                  'Broadcasters Wish List. Help achieve the wishes And surprise the broadcaster!',
                  style: sfProDisplayMedium.copyWith(fontSize: 14, color: AppColors.yellowColor, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gift wish',
                style: sfProDisplaySemiBold.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GiftCard(
                      giftImage: AppImagePath.lamborghiniImage,
                      giftName: 'Lamborghini',
                      coins: '10',
                      score: '5/5',
                      progress: 0.9,
                      onSend: () {
                        Get.back();
                        //Get.find<AudienceViewModel>().setGiftToShow = AppImagePath.princess;
                        Get.find<LiveViewModel>().liveStreamingModel.setGift={"gift": AppImagePath.lamborghini, "audio" : AppImagePath.lamborghiniMp3 };
                        Get.find<LiveViewModel>().liveStreamingModel.save();
                      },
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: GiftCard(
                      giftImage: AppImagePath.bearCastleImage,
                      giftName: 'Bear Castle',
                      coins: '1000',
                      score: '4/5',
                      progress: 0.7,
                      onSend: () {
                        Get.back();
                        Get.find<LiveViewModel>().liveStreamingModel.setGift={"gift": AppImagePath.bearCastle, "audio" : AppImagePath.bearCastleMp3 };
                        Get.find<LiveViewModel>().liveStreamingModel.save();
                      },
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: GiftCard(
                      giftImage: AppImagePath.yachtIslandImage,
                      giftName: 'Yacht Island',
                      coins: '100',
                      score: '5/10',
                      progress: 0.5,
                      onSend: () {
                        Get.back();
                        Get.find<LiveViewModel>().liveStreamingModel.setGift={"gift": AppImagePath.yachtIsland, "audio" : AppImagePath.yachtIslandMp3 };
                        Get.find<LiveViewModel>().liveStreamingModel.save();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GiftCard(
                      giftImage: AppImagePath.babyDragonImage,
                      giftName: 'Baby Dragon',
                      coins: '220',
                      score: '5/5',
                      progress: 0.9,
                      onSend: () {
                        Get.back();
                        Get.find<LiveViewModel>().liveStreamingModel.setGift={"gift": AppImagePath.babyDragon, "audio" : AppImagePath.babyDragonMp3 };
                        Get.find<LiveViewModel>().liveStreamingModel.save();
                      },
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: GiftCard(
                      giftImage: AppImagePath.kissingImage,
                      giftName: 'Kissing',
                      coins: '130',
                      score: '4/5',
                      progress: 0.7,
                      onSend: () {
                        Get.back();
                        Get.find<LiveViewModel>().liveStreamingModel.setGift={"gift": AppImagePath.kissingGift, "audio" : AppImagePath.kissingGiftMp3 };
                        Get.find<LiveViewModel>().liveStreamingModel.save();
                      },
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: GiftCard(
                      giftImage: AppImagePath.heartsImage,
                      giftName: 'Hearts',
                      coins: '980',
                      score: '5/10',
                      progress: 0.5,
                      onSend: () {
                        Get.back();
                        Get.find<LiveViewModel>().liveStreamingModel.setGift={"gift": AppImagePath.hearts, "audio" : AppImagePath.heartMp3 };
                        Get.find<LiveViewModel>().liveStreamingModel.save();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
