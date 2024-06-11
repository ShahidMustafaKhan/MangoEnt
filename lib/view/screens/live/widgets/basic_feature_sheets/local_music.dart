import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class LocalMusicWidget extends StatefulWidget {
  const LocalMusicWidget();

  @override
  _LocalMusicWidgetState createState() => _LocalMusicWidgetState();
}

class _LocalMusicWidgetState extends State<LocalMusicWidget> {
  List<bool> isPlayingList = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 130),
                child: Text(
                  'Local music',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.close)
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            color: AppColors.grey300,
            height: 3,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                String singerName;
                String musicName;
                String time;
                Widget trailingWidget;

                switch (index) {
                  case 0:
                    musicName = "2 AM";
                    singerName = "Arizona Zervas";
                    time = "3:03";
                    break;
                  case 1:
                    musicName = "You right";
                    singerName = "Doja Cat, The Weekend";
                    time = "3:58";
                    break;
                  case 2:
                    musicName = "Baddest";
                    singerName = "2 Chainz, Chris Brown";
                    time = "3:51";
                    break;
                  case 3:
                    musicName = "True Love";
                    singerName = "Kanye West";
                    time = "4:52";
                    break;
                  case 4:
                    musicName = "Bye Bye";
                    singerName = "Marshmello, Juice WRLD";
                    time = "2:09";
                    break;
                  case 5:
                    musicName = "Hands on you";
                    singerName = "Austin George";
                    time = "3:56";
                    break;
                  default:
                    musicName = "";
                    singerName = "";
                    time = "";
                    break;
                }

                if (isPlayingList[index]) {
                  trailingWidget = Icon(Icons.play_arrow, color: Colors.yellow);
                } else {
                  trailingWidget = GestureDetector(
                    onTap: () {
                      setState(() {
                        isPlayingList[index] = !isPlayingList[index];
                      });
                    },
                    child: Image.asset(AppImagePath.musicIcon),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.w),
                  child: Container(
                    width: 343,
                    height: 76,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: AppColors.grey300),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                musicName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    singerName,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          trailingWidget,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
