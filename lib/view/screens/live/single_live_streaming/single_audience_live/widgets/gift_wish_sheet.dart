import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../../../../../parse/LiveStreamingModel.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/gift_contoller.dart';
import 'gift_card.dart';


class GiftWishSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    UserViewModel userViewModel = Get.find();
    return GetBuilder<UserViewModel>(
        init: userViewModel,
        builder: (userViewModel) {
          return GetBuilder<LiveViewModel>(
            init: liveViewModel,
            builder: (liveViewModel) {
              return Container(
                height: 613.h,
                child: Column(
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
                        if(liveViewModel.myWishList!.isNotEmpty)
                          Container(
                          height: 425.h,
                          child: GridView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0.0),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Number of columns in the grid// Vertical space between grid items
                              childAspectRatio: 0.60,// Set the number of columns
                              crossAxisSpacing: 12.42.w, // Set spacing between columns
                              mainAxisSpacing: 5.w,
                              // Aspect ratio of each grid item
                            ),
                            itemCount: liveViewModel.myWishList!.length,
                            itemBuilder: (context, index) {
                              final giftCard = liveViewModel.myWishList![index];
                              return GiftCard(
                                giftImage: giftCard[LiveStreamingModel.keyPath],
                                giftName: giftCard[LiveStreamingModel.keyName],
                                coins: (int.parse(giftCard[LiveStreamingModel.keyAmount])*3) .toString(),
                                score: (int.parse(giftCard[LiveStreamingModel.keyReceived])*3).toString(),
                                progress: double.parse(giftCard[LiveStreamingModel.keyReceived])/double.parse(giftCard[LiveStreamingModel.keyAmount]),
                                onSend: (){
                                  if(userViewModel.currentUser.getCoins! >= 3){
                                    if(int.parse(giftCard[LiveStreamingModel.keyAmount])!=int.parse(giftCard[LiveStreamingModel.keyReceived])) {
                                      Map<String,
                                          dynamic> item = {
                                        LiveStreamingModel.keyName: giftCard[LiveStreamingModel.keyName],
                                        LiveStreamingModel.keyPath: giftCard[LiveStreamingModel.keyPath],
                                        LiveStreamingModel.keyAmount: giftCard[LiveStreamingModel.keyAmount],
                                        LiveStreamingModel
                                            .keyReceived: (int
                                            .parse(
                                            giftCard[LiveStreamingModel
                                                .keyReceived]) +
                                            1).toString(),
                                      };
                                      liveViewModel.myWishList![index] = item;
                                      liveViewModel.liveStreamingModel
                                          .setMyWishWholeList =
                                          liveViewModel.myWishList!;
                                      liveViewModel.liveStreamingModel.addDiamonds=3;
                                      liveViewModel.liveStreamingModel
                                          .save().then((
                                          value) {
                                        userViewModel.currentUser
                                            .decrementCoins =
                                        3;

                                        userViewModel.currentUser.save();
                                      });
                                      // });
                                    }

                                  }
                                },
                              );
                            },
                          ),
                        ),
                        if(liveViewModel.myWishList!.isEmpty)
                          Container(
                            height: 230.h,
                            width: Get.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.asset(
                                    bag,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 9.h,),
                                Text(
                                  "No item added yet",
                                  style: TextStyle(
                                    color:  Get.isDarkMode ?  Colors.white70 : Colors.black.withOpacity(0.4),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          )

                      ],
                    ),
                  ),
                ],
            ),
              );
          }
        );
      }
    );
  }
}
