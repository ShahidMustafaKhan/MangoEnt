import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/screen_recording_sheet.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/settings_sheet.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/youtube_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../model/youtube_model.dart';
import '../../../../../utils/constants/status.dart';


class YoutubeSheet extends StatefulWidget {

  @override
  State<YoutubeSheet> createState() => _YoutubeSheetState();
}

class _YoutubeSheetState extends State<YoutubeSheet> {


  @override
  Widget build(BuildContext context) {
    YoutubeController youtubeController = Get.find();
    LiveViewModel liveViewModel = Get.find();
    TextEditingController titleController = TextEditingController();
    return Container(
      height: 600.h,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 14, 11.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 2.8, 0),
                        child: SizedBox(
                          width: 90.w,
                          height: 27.h,
                          child: Image.asset(
                            'assets/png/youtube_logo.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap:()=> Get.back(),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 6.h, 4.w, 0),
                      width: 12,
                      height: 12,
                      child: Image.asset(
                        'assets/png/ic_cross.png',
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 0, 16, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(90),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.fromLTRB(19.1, 9.1, 0, 9.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 17.9,
                        height: 17.9,
                        child: SizedBox(
                          width: 17.9,
                          height: 17.9,
                          child: Image.asset(
                            "assets/png/ic_search.png",
                          ),
                        ),
                      ),
                      Container(
                        width: 250.w,
                        margin: EdgeInsets.fromLTRB(13, 0.4, 0, 1.4),
                        child: TextField(
                          expands: false,
                          controller: titleController,
                          onSubmitted: (value){
                            youtubeController.fetchYouTubeVideos(value);
                          },
                          style: GoogleFonts.getFont(
                            'Roboto Condensed',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search keywords or video link',
                            hintStyle: GoogleFonts.getFont(
                              'Roboto Condensed',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0x99000000),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            isDense: false,
                            contentPadding: EdgeInsets.only(top: 1),
                            isCollapsed : true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<YoutubeController>(
                init: youtubeController,
                builder: (youtubeController) {
                  if(youtubeController.status == Status.Completed)
                  return ListView.separated(
                                padding: EdgeInsets.only(
                                    left: 16.w, right: 16.w, top: 19.h, bottom: 16.h),
                                itemCount: youtubeController.youtubeVideoList!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap:(){
                                      Get.back();
                                      if(liveViewModel.liveStreamingModel.getYoutube == false)
                                      liveViewModel.setYoutube(true, youtubeController.youtubeVideoList![index].id.videoId );
                                      else{
                                        liveViewModel.setYoutube(true, youtubeController.youtubeVideoList![index].id.videoId );
                                        youtubeController.youtubePlayerController.load(youtubeController.youtubeVideoList![index].id.videoId);
                                      }
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 193.h,
                                              width: double.infinity,
                                              child: Image.network(
                                                youtubeController.youtubeVideoList![index].snippet.thumbnails.high.url,
                                              fit: BoxFit.cover,)),
                                          SizedBox(height: 12.h),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  youtubeController.youtubeVideoList![index].snippet.title,
                                                  style: sfProDisplayMedium.copyWith(
                                                      fontSize: 14.sp,
                                                      color: Colors.black
                                                  ),),
                                                SizedBox(height: 8.h),
                                                Row(
                                                  children: [
                                                    Text(youtubeController.youtubeVideoList![index].snippet.channelTitle,
                                                      style: sfProDisplayRegular.copyWith(
                                                          fontSize: 12.sp,
                                                          color: Colors.black.withOpacity(
                                                              0.5)
                                                      ),),
                                                    SizedBox(width: 8.w),
                                                    Text('${QuickHelp.getTimeAgo(DateTime.parse(youtubeController.youtubeVideoList![index].snippet.publishedAt))}',
                                                      style: sfProDisplayRegular.copyWith(
                                                          fontSize: 12.sp,
                                                          color: Colors.black.withOpacity(
                                                              0.5)
                                                      ),),
                                                  ],
                                                )
                                              ],

                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(height: 24.h,);
                                },);
                  else
                    return Center(child: CircularProgressIndicator());

                }
            ),

                     ),





        ],
      ),
    );
  }
}

