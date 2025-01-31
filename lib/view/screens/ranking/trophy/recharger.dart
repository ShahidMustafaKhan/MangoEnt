import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/view/screens/ranking/trophy/widgets/bottombar_widget.dart';
import 'package:teego/view/screens/ranking/trophy/widgets/main_coins_view.dart';
import 'package:teego/view/screens/ranking/trophy/widgets/topbar_widget.dart';

class RechargerView extends StatelessWidget {
  const RechargerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TrophyTopBar(),
        SizedBox(
          height: 150.h,
        ),
        MainCoinsView(),
        SizedBox(
          height: 30.h,
        ),
        Divider(color: Colors.white, height: 5),
        SizedBox(
          height: 20.h,
        ),
        TrophyBottomBar(),
      ],
    );
  }
}
