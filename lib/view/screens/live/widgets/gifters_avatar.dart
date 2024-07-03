import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/widgets/whisper/top_gifters_sheet.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view_model/live_messages_controller.dart';
import 'package:teego/view_model/popular_controller.dart';

import '../../../../parse/LiveStreamingModel.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/routes/app_routes.dart';
import '../../../../view_model/live_controller.dart';


class GiftAvatar extends StatelessWidget {
  String? avatar1;
  String? avatar2;
  String? avatar3;
  GiftAvatar({this.avatar1, this.avatar2, this.avatar3 });

  @override
  Widget build(BuildContext context) {
  LiveViewModel liveViewModel = Get.find();
    return GestureDetector(
      onTap:()=> openBottomSheet(TopGifters(), context),
      child:Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(avatar1 != null)
          Stack(
              children: [
                  Container(
                    width: 38, height: 34,
                    margin: const EdgeInsets.only(left: 33),
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(1.5, 0, 1, 0),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.black.withOpacity(0.6),
                              backgroundImage: avatar3 == null ? null : NetworkImage(avatar3!),),
                          ),
                        ),
                          Positioned(
                            top: -1.2,
                            child: SvgPicture.asset("assets/svg/badge2.svg", fit: BoxFit.cover,)),
                      ],
                    )
                ),
                  Container(
                    width: 38, height: 34,
                    margin: const EdgeInsets.only(left: 17),
                    child: Stack(
                      children: [

                        Align(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(1.5, 0, 1, 2),
                            child: CircleAvatar(
                              radius: 13.6,
                              backgroundColor: AppColors.black.withOpacity(0.6),
                              backgroundImage: avatar2== null ? null :NetworkImage(avatar2!),),
                          ),
                        ),
                          Positioned(
                            top: -1.2,
                            child: SvgPicture.asset("assets/svg/badge3.svg", fit: BoxFit.cover,)),
                      ],
                    )
                ),
                Container(
                    width: 34, height: 34,
                    margin: const EdgeInsets.only(left: 3),
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.black.withOpacity(0.6),
                              backgroundImage: avatar1== null ? null : NetworkImage(avatar1!),),
                          ),
                        ),
                        SvgPicture.asset("assets/svg/badge1.svg"),

                      ],
                    )
                ),
              ]),


        ],
      )
    );
  }

}
