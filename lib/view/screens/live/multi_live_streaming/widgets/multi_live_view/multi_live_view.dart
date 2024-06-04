import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/multi_live_view/six_multi_guest.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/multi_live_view/three_multi_guest.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/multi_live_view/twelve_multi_guest.dart';
import 'package:teego/view_model/live_controller.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/multi_guest_grid_controller.dart';
import 'four_multi_guest.dart';
import 'nine_multi_guest.dart';

class MultiGuestView extends StatelessWidget {
  const MultiGuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    GridController _controller = Get.put(GridController());

    if(liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiThreeSeat)
    return ThreeMultiGuestView();
    else if(liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiFourSeat)
      return FourMultiGuestView();
    else if(liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiSixSeat)
      return SixMultiGuestView();
    else if(liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiNineSeat)
      return NineMultiGuestView();
    else if(liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiTwelveSeat)
      return TwelveMultiGuestView();
    else
      return ThreeMultiGuestView();
  }
}
