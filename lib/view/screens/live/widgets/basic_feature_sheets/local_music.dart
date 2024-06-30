import 'package:just_audio/just_audio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../parse/MusicModel.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/music_controller.dart';

class LocalMusicWidget extends StatefulWidget {
  const LocalMusicWidget();

  @override
  _LocalMusicWidgetState createState() => _LocalMusicWidgetState();
}

class _LocalMusicWidgetState extends State<LocalMusicWidget> {
  MusicController musicController= Get.find();


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
            child: FutureBuilder<List<MusicModel>>(
                future: MusicController.getAudioData(), // Replace with your actual data fetching function
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // Display a loading indicator while waiting for data.
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final musicModelList = snapshot.data; // Access the loaded data
                    return ListView.builder(
                      itemCount: musicModelList!.length,
                      itemBuilder: (context, index) {
                        final musicModel = musicModelList[index];
                        String singerName= musicModel.getSingerName?? "";
                        String musicName= musicModel.getAudioName!;
                        String time= musicModel.getTime!;


                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.w),
                          child: Obx(() {
                              return Container(
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


                                    if (musicController
                                        .isPlaying[index]
                                        .value==true)
                                      GestureDetector(
                                          onTap:(){
                                            musicController.player.pause();
                                            musicController.togglePlayItemPressed(index);

                                          },
                                          child: Icon(Icons.play_arrow, color: Colors.yellow)),

                                      if(musicController
                                          .isPlaying[index]
                                          .value==false)
                                        GestureDetector(
                                          onTap: () {
                                              //
                                              musicController.loadAudio(
                                              musicModel
                                                  .getAudioFile!.url!);
                                              musicController.player.play();
                                              musicController
                                                  .togglePlayItemPressed(
                                              index);

                                          },
                                          child: Image.asset(AppImagePath.musicIcon),
                                        )


                                    ],
                                  ),
                                ),
                              );
                            }
                          ),
                        );
                      },
                    );}
                }
            ),
          ),
        ],
      ),
    );
  }
}

