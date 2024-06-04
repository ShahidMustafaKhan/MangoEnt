import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:svgaplayer_flutter/player.dart';
import '../../../../../../view_model/gift_contoller.dart';


class GiftAnimationView extends StatelessWidget {
  final GiftViewModel giftViewModel;

  const GiftAnimationView({
    required this.giftViewModel,
  });

  @override
  Widget build(BuildContext context) {
      return Obx((){
        if(giftViewModel.lamborghiniAnimation)
          return Container(
              height: 550.h,
              width: double.infinity,
              child: SVGAImage(giftViewModel.animationController!,fit: BoxFit.cover,));
        if(giftViewModel.bearCastle)
          return Container(
              height: 200.h,
              width: double.infinity,
              child: SVGAImage(giftViewModel.animationController!,fit: BoxFit.cover,));
        if(giftViewModel.hearts)
          return Container(
              height: 500,
              width: double.infinity,
              child: SVGAImage(giftViewModel.animationController!,fit: BoxFit.cover,));
        if(giftViewModel.motorCycleEntry)
          return Container(
              height: 500,
              width: double.infinity,
              child: SVGAImage(giftViewModel.animationController!,fit: BoxFit.cover,));
        return Container(
            height: 350.h,
            width: double.infinity,
            child: SVGAImage(giftViewModel.animationController!, fit: BoxFit.cover,));
        }
      );

  }
}
