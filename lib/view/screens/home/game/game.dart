import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/home/game/widgets/game_all_categories.dart';
import 'package:teego/view/screens/home/game/widgets/game_bottom_widget.dart';
import 'package:teego/view/screens/home/game/widgets/game_categories.dart';
import 'package:teego/view/screens/home/game/widgets/top_stream_widget.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  String selectedOption = 'All';
  bool showAllContent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: showAllContent ? buildAllContent() : GameAllCategories()),
    );
  }

  Widget buildAllContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Top Streams",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.h,
            ),
            TopStreamWidget(),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Text(
                  "Categories",
                  style:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAllContent = false;
                    });
                  },
                  child: Text(
                    "All",
                    style:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            GameCategories(),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = "All";
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "All",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      if (selectedOption == "All")
                        Container(
                          height: 2.h,
                          width: 15.w,
                          color: AppColors.darkPurple,
                        )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = "Trends";
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Trends",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          if (selectedOption == "Trends")
                            Container(
                              height: 2.h,
                              width: 15.w,
                              color: AppColors.darkPurple,
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            GameBottomWidget(),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }
}
