import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_core/src/get_main.dart';
import 'package:like_button/like_button.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:share_plus/share_plus.dart';

import 'package:teego/ui/text_with_tap.dart';
import 'package:teego/utils/colors_hype.dart';
import 'package:teego/utils/constants/status.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/screens/trending/widgets/report_comment_sheet.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../helpers/quick_actions.dart';
import '../../../../../helpers/quick_cloud.dart';
import '../../../../../helpers/quick_help.dart';
import '../../../../../parse/CommentsModel.dart';
import '../../../../../parse/NotificationsModel.dart';
import '../../../../../parse/PostsModel.dart';
import '../../../../../parse/ReportModel.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../services/dynamic_link_service.dart';
import '../../../../../ui/button_with_icon.dart';
import '../../../../../ui/container_with_corner.dart';
import '../../../../../utils/Utils.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/communityController.dart';
import '../../../trending/widgets/comment_sheet.dart';
import '../../../trending/widgets/for_you.dart';
import '../../../trending/widgets/tip_sheet.dart';
import '../../comments.dart';


// ignore: must_be_immutable
class DefaultVideoInfoWidget extends StatefulWidget {
  PostsModel? postModel;
  int? currentIndex;
  final bool singleReel;


  DefaultVideoInfoWidget({this.postModel, this.currentIndex, this.singleReel=false});

  @override
  State<DefaultVideoInfoWidget> createState() => _DefaultVideoInfoWidgetState();
}

class _DefaultVideoInfoWidgetState extends State<DefaultVideoInfoWidget> {
  TextEditingController textEditingController = TextEditingController();

  bool following = false;
  // Subscription? subscription;
  // LiveQuery liveQuery = LiveQuery();
  List<StreamSubscription> subscriptions = [];
  RxBool followingUser =false.obs;
  RxInt selectedGiftIndex=0.obs;

  RxInt userTotalDiamonds=0.obs;
  UserViewModel userViewModel = Get.find();




  @override
  void dispose() {
    // if (subscription != null) {
    //   liveQuery.client.unSubscribe(subscription!);
    // }
    // subscription = null;
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void initState() {
    // setupCounterLiveUser();
    if (userViewModel.currentUser!.getFollowing!.contains(widget.postModel!.getAuthor!.objectId)) {
      followingUser.value = true;
    } else {
     followingUser.value = false;
    }
    userTotalDiamonds.value=userViewModel.currentUser!.getCoins!;
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    if (userViewModel.currentUser!.getFollowing!.contains(widget.postModel!.getAuthor!.objectId)) {
      following = true;
    } else {
      following = false;
    }
    


    return Stack(children: [
      Positioned(
        right: 10,
        bottom: widget.singleReel==true ? 15 : 50,
        child: Column(
          children: [
            LikeButton(
              padding: EdgeInsets.only(right: 2),
              size: 34,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.bottom,
              circleColor:
              CircleColor(start: kPrimaryColor, end: kPrimaryColor),
              bubblesColor: BubblesColor(
                dotPrimaryColor: kPrimaryColor,
                dotSecondaryColor: kPrimaryColor,
              ),
              isLiked: widget.postModel!.getLikes!.contains(userViewModel.currentUser!.objectId),
              likeCountAnimationType: LikeCountAnimationType.all,
              likeBuilder: (bool isLiked) {
                return Container(
                  height: 33.h,
                  width: 33.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite,
                      color: isLiked ? kPrimaryColor : Colors.white.withOpacity(0.8), size: 32),
                );
              },
              likeCountPadding: EdgeInsets.only(left: 3, top: 9),
              likeCount: widget.postModel!.getLikes!.length,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.white : Colors.white;
                Widget result;

                result = Text(
                  QuickHelp.convertNumberToK(count!),
                  style: SafeGoogleFont (
                    'DM Sans',
                    fontSize: 12*ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.3333333333*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                );
                return result;
              },
              onTap: (isLiked) {
                print("Liked: $isLiked");

                if (isLiked) {
                  widget.postModel!.removeLike = userViewModel.currentUser!.objectId!;

                  widget.postModel!.save().then((value) {
                    widget.postModel = value.results!.first as PostsModel;
                  });

                  _deleteLike(widget.postModel!);

                  return Future.value(false);
                } else {
                  widget.postModel!.setLikes = userViewModel.currentUser!.objectId!;
                  widget.postModel!.setLastLikeAuthor = userViewModel.currentUser!;

                  widget.postModel!.save().then((value) {
                    widget.postModel = value.results!.first as PostsModel;
                  });

                  _likePost(widget.postModel!);

                  return Future.value(true);
                }
              },
            ),
            SizedBox(
              height: widget.singleReel==false ? 21.h : 15.h,
            ),
            LikeButton(
              padding: EdgeInsets.only(right: 2),
              size: 34,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.bottom,
              circleColor:
              CircleColor(start: kPrimaryColor, end: kPrimaryColor),
              bubblesColor: BubblesColor(
                dotPrimaryColor: kPrimaryColor,
                dotSecondaryColor: kPrimaryColor,
              ),
              isLiked: widget.postModel!.getLikes!.contains(userViewModel.currentUser!.objectId),
              likeCountAnimationType: LikeCountAnimationType.all,
              likeBuilder: (bool isLiked) {
                return Image.asset(AppImagePath.reel_comment);
              },
              likeCountPadding: EdgeInsets.only(left: 3, top: 9),
              likeCount: widget.postModel!.getComments!.length,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.white : Colors.white;
                Widget result;

                result = Text(
                  QuickHelp.convertNumberToK(count!),
                  style: SafeGoogleFont (
                    'DM Sans',
                    fontSize: 12*ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.3333333333*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                );
                return result;
              },
              onTap: (isLiked) {
                print("Liked: $isLiked");
                showComments(context, fem, ffem);
                return Future.value(false);
              },
            ),
            SizedBox(
              height: 21.h,
            ),
            LikeButton(
              padding: EdgeInsets.only(right: 2),
              size: 34,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.bottom,
              // circleColor:
              // CircleColor(start: kPrimaryColor, end: kPrimaryColor),
              // bubblesColor: BubblesColor(
              //   dotPrimaryColor: kPrimaryColor,
              //   dotSecondaryColor: kPrimaryColor,
              // ),
              isLiked: widget.postModel!.getLikes!.contains(userViewModel.currentUser!.objectId),
              likeCountAnimationType: LikeCountAnimationType.all,
              likeBuilder: (bool isLiked) {
                return Padding(
                  padding: EdgeInsets.all(4.5.r),
                  child: Image.asset(
                    AppImagePath.post,
                    height: 24.h,
                    width: 24.w,
                  ),
                );
              },
              likeCountPadding: EdgeInsets.only(left: 3, top: 9),
              likeCount: widget.postModel!.getShares!.length,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.white : Colors.white;
                Widget result;

                result = Text(
                  QuickHelp.convertNumberToK(count!),
                  style: SafeGoogleFont (
                    'DM Sans',
                    fontSize: 12*ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.3333333333*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                );
                return result;
              },
              onTap: (isLiked) async {

                Uri? uri= await DynamicLinkService().createDynamicLink(widget.postModel!.objectId, reels: true);
                if(uri!=null){
                  Share.share("Come and check ${widget.postModel!.getAuthor!.getFirstName!}'s reel in #MangoEnt! ${uri.host}${uri.path}").then((value){
                    widget.postModel!.setShares = userViewModel.currentUser!.objectId!;

                    widget.postModel!.save().then((value) {
                      widget.postModel = value.results!.first as PostsModel;
                    });

                  });

                }
                else{
                  QuickHelp.showAppNotificationAdvanced(title: 'Something went wrong!', context: context);
                  Navigator.of(context).pop();
                }

                return Future.value(true);
              },
            ),
            SizedBox(
              height: 25.h,
            ),
            if(widget.singleReel==false)
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: AppColors.grey500,
                    isScrollControlled: true,
                    builder: (context) => Wrap(
                      children: [
                        TipSheet(),
                      ],
                    ),
                  );
                },
                child: Image.asset(AppImagePath.reel_tip)),
            if(widget.singleReel==false)
              SizedBox(
              height: 10.h,
            ),
            if(widget.singleReel==false)
              Text("Tip"),
            if(widget.singleReel==false)
              SizedBox(
              height: 25.h,
            ),
            GestureDetector(
              onTap: (){
                tools(context);
              },
              child: Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff494848)),
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("Tools"),
            SizedBox(
              height:  25.h
            ),
            Image.asset(AppImagePath.reel_music),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
      Positioned(
          left: 10,
          bottom: widget.singleReel==true ? 15 : 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  QuickActions.avatarWidget(
                    widget.postModel!.getAuthor!,
                    height: 30.h,
                    width: 30.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "${widget.postModel!.getAuthor!.getFullName} ❤️❤️ ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GetBuilder<UserViewModel>(
                      builder: (controller) {
                        if(controller.currentUser!.getUid! != widget.postModel!.getAuthor!.getUid!)
                          return GestureDetector(
                          onTap: ()=> controller.followOrUnFollow(widget.postModel!.getAuthor!.objectId!.toString()),
                          child: Container(
                          height: 20.h,
                          width: 44.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: AppColors.yellowBtnColor),
                          child: Center(
                            child: Icon(
                              controller.followingUser(widget.postModel!.getAuthor!) ? Icons.check : Icons.add,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                      ),
                        );
                        return SizedBox();
                    }
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              if(widget.postModel!.getCaption != null)
              Text("${widget.postModel!.getCaption ?? ''}"),
              if(widget.postModel!.getCaption != null)
                SizedBox(
                height: 30.h,
              ),
              if(widget.postModel!.getCaption == null)
                SizedBox(
                  height: 10.h,
                ),
              Row(
                children: [
                  Container(
                    height: 26.h,
                    width: 96.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.r),
                        color: Color(0xffFFFFF)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.person,
                          size: 20,
                        ),
                        Text(
                          "${widget.postModel!.getAuthor!.getFollowers!.length}  users",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  // Container(
                  //   height: 26.h,
                  //   width: 196.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(26.r),
                  //       color: Color(0xffFFFFF)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Icon(
                  //         Icons.music_note,
                  //         size: 20,
                  //       ),
                  //       Text(
                  //         "Lorem Espanl corem  poertiittor....",
                  //         style: TextStyle(
                  //             fontSize: 12.sp, fontWeight: FontWeight.w400),
                  //       ),
                  //       SizedBox(
                  //         width: 5.w,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              if(widget.postModel!.getCaption == null)
                SizedBox(
                  height: 14.h,
                ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ))
    ]);
  }

  /// Like heart icon: tap to increase like number
  /// More option: tap to share or edit
  ///
  Widget _likeWidget(BuildContext context, double fem, double ffem) {
    return Container(
      margin: EdgeInsets.only(bottom: 5*fem, right: 5*fem),

      // alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // group52952rh3 (3:839)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                width: 70*fem,
                height: 80*fem,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      // ellipse924ad3 (3:840)
                      right: -14*fem,
                      top: 0*fem,
                      child: InkWell(
                        onTap: (){
                          // QuickHelp.goToNavigatorScreen(context, ProfileMoments(currentUser: widget.postModel!.getAuthor , mProfile: userViewModel.currentUser, otherProfile: true,));
                        },
                        child: Align(
                          child: SizedBox(
                            width: 70*fem,
                            height: 70*fem,
                            child: Container(
                              decoration: BoxDecoration (
                                // borderRadius: BorderRadius.circular(18*fem)
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xffffffff)),
                                image: DecorationImage (
                                  fit: BoxFit.contain,
                                  image: NetworkImage (
                                    widget.postModel!.getAuthor!.getAvatar!.url!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // group52951eN1 (3:841)
                      left: 27.3*fem,
                      bottom: 0*fem,
                      right: -5*fem,
                      child: userViewModel.currentUser!.objectId!=widget.postModel!.getAuthor!.objectId?GestureDetector(
                        behavior: HitTestBehavior.opaque ,
                        onTap: (){
                          if(userViewModel.currentUser!.getFollowing!.contains(widget.postModel!.getAuthor!.objectId)){
                            print(following);

                            userViewModel.currentUser!.removeFollowing=widget.postModel!.getAuthor!.objectId!;
                            userViewModel.currentUser!.save();


                          }
                          else{

                            userViewModel.currentUser!.setFollowing=widget.postModel!.getAuthor!.objectId!;
                            userViewModel.currentUser!.save();

                          }

                        },
                        child: Align(
                          child: Obx(() {
                              return SizedBox(
                                width: 19.44*fem,
                                height: 19.51*fem,
                                child: Image.asset(
                                  followingUser.value ? 'assets/reels/group-52951-T4R.png':
                               "assets/profile/icons-D37.png",
                                  width: 19.44*fem,
                                  height: 19.51*fem,
                                ),
                              );
                            }
                          ),
                        ),
                      ): SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: LikeButton(
              padding: EdgeInsets.only(right: 2),
              size: 32,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.bottom,
              circleColor:
                  CircleColor(start: Colors.red, end: Colors.red),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.red,
                dotSecondaryColor: Colors.red,
              ),
              isLiked: widget.postModel!.getLikes!.contains(userViewModel.currentUser!.objectId),
              likeCountAnimationType: LikeCountAnimationType.all,
              likeBuilder: (bool isLiked) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                  width: 24*fem,
                  height: 24*fem,
                  child: Image.asset(
                    isLiked?'assets/reels/black-heart-suit2665.png': 'assets/reels/bi-heart-fill-taq.png',
                    width: 24*fem,
                    height: 24*fem,
                  ),
                );
              },
              likeCountPadding: EdgeInsets.only(left: 3, top: 4),
              likeCount: widget.postModel!.getLikes!.length,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.white : Colors.white;
                Widget result;

                  result = Text(
                    QuickHelp.convertNumberToK(count!),
                    style: SafeGoogleFont (
                      'DM Sans',
                      fontSize: 12*ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.3333333333*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  );
                return result;
              },
              onTap: (isLiked) {
                print("Liked: $isLiked");

                if (isLiked) {
                  widget.postModel!.removeLike = userViewModel.currentUser!.objectId!;

                  widget.postModel!.save().then((value) {
                    widget.postModel = value.results!.first as PostsModel;
                  });

                  _deleteLike(widget.postModel!);

                  return Future.value(false);
                } else {
                  widget.postModel!.setLikes = userViewModel.currentUser!.objectId!;
                  widget.postModel!.setLastLikeAuthor = userViewModel.currentUser!;

                  widget.postModel!.save().then((value) {
                    widget.postModel = value.results!.first as PostsModel;
                  });

                  _likePost(widget.postModel!);

                  return Future.value(true);
                }
              },
            ),
          ),
          SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: LikeButton(
              size: 32,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.bottom,
              likeCountPadding: EdgeInsets.only(left: 2.7, top: 4),
              circleColor:
                  CircleColor(start: kPrimaryColor, end: kPrimaryColor),
              bubblesColor: BubblesColor(
                dotPrimaryColor: kPrimaryColor,
                dotSecondaryColor: kPrimaryColor,
              ),
              isLiked: false,
              likeCountAnimationType: LikeCountAnimationType.none,
              likeBuilder: (bool isLiked) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                  width: 24*fem,
                  height: 24*fem,
                  child: Image.asset(
                    'assets/reels/fluent-comment-multiple-24-filled.png',
                  width: 24*fem,
                    height: 24*fem,
                  ),
                );
              },
              likeCount: widget.postModel!.getComments!.length,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.white : Colors.white;
                Widget result;

                  result = Text(
                    QuickHelp.convertNumberToK(count!),
                    style: SafeGoogleFont (
                      'DM Sans',
                      fontSize: 12*ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.3333333333*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  );
                return result;
              },
              onTap: (isLiked) {
                print("Liked: $isLiked");

                //openComments(context, currentUser!, postModel!);
                showComments(context,fem,ffem);

                return Future.value(false);

              },
            ),
          ),


          SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: LikeButton(
              size: 32,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.bottom,
              likeCountPadding: EdgeInsets.only(left: 2.7, top: 4),
              circleColor:
                  CircleColor(start: kPrimaryColor, end: kPrimaryColor),
              bubblesColor: BubblesColor(
                dotPrimaryColor: kPrimaryColor,
                dotSecondaryColor: kPrimaryColor,
              ),
              isLiked: false,
              likeCountAnimationType: LikeCountAnimationType.none,
              likeBuilder: (bool isLiked) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                  width: 24*fem,
                  height: 24*fem,
                  child: Image.asset(
                    'assets/reels/teenyicons-gift-solid.png',
                    width: 24*fem,
                    height: 24*fem,
                  ),
                );
              },
              likeCount: widget.postModel!.getGiftsList!.length,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.white : Colors.white;
                Widget result;

                  result = Text(
                    QuickHelp.convertNumberToK(count!),
                    style: SafeGoogleFont (
                      'DM Sans',
                      fontSize: 12*ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.3333333333*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  );
                return result;
              },
              onTap: (isLiked) {
                print("Liked: $isLiked");

                //openComments(context, currentUser!, postModel!);
                giftsContainer(fem, ffem).then((value) => setState((){}));

                return Future.value(false);
                /*if (isLiked) {

                  return Future.value(false);
                } else {

                  return Future.value(false);
                }*/
              },
            ),
          ),
          SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: LikeButton(
              size: 32,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.bottom,
              likeCountPadding: EdgeInsets.only(left: 2.7, top: 4),
              circleColor:
                  CircleColor(start: kPrimaryColor, end: kPrimaryColor),
              bubblesColor: BubblesColor(
                dotPrimaryColor: kPrimaryColor,
                dotSecondaryColor: kPrimaryColor,
              ),
              isLiked: false,
              likeCountAnimationType: LikeCountAnimationType.none,
              likeBuilder: (bool isLiked) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                  width: 24*fem,
                  height: 24*fem,
                  child: Image.asset(
                    'assets/reels/bxs-share.png',
                    width: 24*fem,
                    height: 24*fem,
                  ),
                );
              },
              likeCount: widget.postModel!.getComments!.length,
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.white : Colors.white;
                Widget result;

                  result = Text(
                    QuickHelp.convertNumberToK(count!),
                    style: SafeGoogleFont (
                      'DM Sans',
                      fontSize: 12*ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.3333333333*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  );
                return result;
              },
              onTap: (isLiked) async {
                print("Liked: $isLiked");

                Uri? uri= await DynamicLinkService().createDynamicLink(widget.postModel!.objectId, reels: true);
                if(uri!=null){
                  Share.share("Come and check ${widget.postModel!.getAuthor!.getFirstName!}'s reel in #DINOLIVE! ${uri.host}${uri.path}");
                }
                else{
                  QuickHelp.showAppNotificationAdvanced(title: 'Something went wrong!', context: context);
                  Navigator.of(context).pop();
                }

                 return Future.value(false);

              },
            ),
          ),
        ],
      ),
    );
  }

  Future giftsContainer(double fem,double ffem){
    return showModalBottomSheet(
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20*fem), // Set the radius for the top border
        ),),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState /*You can rename this!*/) {
              return giftsWidget( fem, ffem);
            });
      },
    );
  }
  
  Widget giftsWidget(double fem, double ffem){
    return Container(
      padding: EdgeInsets.fromLTRB(14*fem, 17*fem, 15*fem, 23*fem),
      width: 375*fem,
      height: 391*fem,
      decoration: BoxDecoration (
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only (
          topLeft: Radius.circular(36*fem),
          topRight: Radius.circular(36*fem),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // autogroup7hfkykh (YUbGnMZiMpofu728zX7hfK)
            margin: EdgeInsets.fromLTRB(144*fem, 0*fem, 3.5*fem, 12*fem),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // sendtipJny (3:1500)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 125.5*fem, 0*fem),
                  child: Text(
                    'Send Tip',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont (
                      'DM Sans',
                      fontSize: 14*ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.2857142857*ffem/fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  // frame529601xH (3:1501)
                  width: 15*fem,
                  height: 15*fem,
                  child: Image.asset(
                    'assets/reels/frame-52960.png',
                    width: 15*fem,
                    height: 15*fem,
                  ),
                ),
              ],
            ),
          ),
          Container(
            // givethecreatoratipifyoulikethe (3:1503)
            margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 29*fem),
            child: Text(
              'Give the creator a tip if you like their content',
              style: SafeGoogleFont (
                'DM Sans',
                fontSize: 16*ffem,
                fontWeight: FontWeight.w400,
                height: 1.375*ffem/fem,
                color: Color(0xff1e1e1e),
              ),
            ),
          ),
          Container(
            // autogroupdddfSXo (YUbGvBg12xdqfusomfdDdf)
            margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 24*fem),
            height: 134*fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx((){
                    return InkWell(
                      onTap:(){
                        selectedGiftIndex.value=0;
                      },
                      child: Container(
                        // tipsZsK (3:1504)
                        padding: EdgeInsets.fromLTRB(20*fem, 4*fem, 20*fem, 6*fem),
                        width: 100*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: selectedGiftIndex.value==0 ? Color(0xff57aaff): Colors.transparent),
                          color: Color(0xfff8f8f8),
                          borderRadius: BorderRadius.circular(12*fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // image32sd7 (I3:1504;266:82617)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem),
                              width: 60*fem,
                              height: 60*fem,
                              child: Image.asset(
                                'assets/reels/image-32.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                              child: Text(
                                'Nice !',
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.375*ffem/fem,
                                  color: Color(0xff1e1e1e),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(13.5*fem, 0*fem, 0*fem, 0*fem),
                              padding: EdgeInsets.fromLTRB(2.5*fem, 1*fem, 0*fem, 1*fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // tablerdiamondndb (I3:1504;1008:95285)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.5*fem, 0.2*fem),
                                    width: 15*fem,
                                    height: 11*fem,
                                    child: Image.asset(
                                      'assets/reels/tabler-diamond.png',
                                      width: 15*fem,
                                      height: 11*fem,
                                    ),
                                  ),
                                  Text(
                                    // twX (I3:1504;266:82624)
                                    '5',
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 14*ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2857142857*ffem/fem,
                                      color: Color(0xfff6b545),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(
                  width: 20*fem,
                ),
                Obx(() {
                    return InkWell(
                      onTap: (){
                        selectedGiftIndex.value=1;
                      },
                      child: Container(
                        // tipsQQ5 (3:1509)
                        padding: EdgeInsets.fromLTRB(20*fem, 4*fem, 20*fem, 6*fem),
                        width: 100*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: selectedGiftIndex.value==1 ? Color(0xff57aaff): Colors.transparent),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12*fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem),
                              width: 60*fem,
                              height: 60*fem,
                              child: Image.asset(
                                'assets/reels/image-34.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 12*fem),
                              child: Text(
                                'Good !',
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.375*ffem/fem,
                                  color: Color(0xff1e1e1e),
                                ),
                              ),
                            ),
                            Container(
                              // icbaselinediamondSzy (I3:1509;266:82628)
                              margin: EdgeInsets.fromLTRB(10.5*fem, 0*fem, 0*fem, 0*fem),
                              padding: EdgeInsets.fromLTRB(2.5*fem, 1*fem, 0*fem, 1*fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // tablerdiamondARB (I3:1509;1008:95444)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.5*fem, 0.2*fem),
                                    width: 15*fem,
                                    height: 11*fem,
                                    child: Image.asset(
                                      'assets/reels/tabler-diamond.png',
                                      width: 15*fem,
                                      height: 11*fem,
                                    ),
                                  ),
                                  Text(
                                    // Uwf (I3:1509;266:82633)
                                    "10",
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 14*ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2857142857*ffem/fem,
                                      color: Color(0xfff6b545),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(
                  width: 20*fem,
                ),
                Obx(() {
                    return InkWell(
                      onTap: (){
                        selectedGiftIndex.value=2;
                      },
                      child: Container(
                        // tipsoyw (3:1510)
                        padding: EdgeInsets.fromLTRB(15.5*fem, 4*fem, 15.5*fem, 6*fem),
                        width: 104*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: selectedGiftIndex.value==2 ? Color(0xff57aaff): Colors.transparent),
                          color: Color(0xfff8f8f8),
                          borderRadius: BorderRadius.circular(12*fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // image33iLD (I3:1510;266:82608)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem),
                              width: 60*fem,
                              height: 60*fem,
                              child: Image.asset(
                                'assets/reels/image-33.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              // amazingRkR (I3:1510;266:82609)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                              child: Text(
                                'Amazing!',
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.375*ffem/fem,
                                  color: Color(0xff1e1e1e),
                                ),
                              ),
                            ),
                            Container(
                              // icbaselinediamondkXo (I3:1510;266:82610)
                              margin: EdgeInsets.fromLTRB(18.5*fem, 0*fem, 0.5*fem, 0*fem),
                              padding: EdgeInsets.fromLTRB(2.5*fem, 1*fem, 0*fem, 1*fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // tablerdiamondfuf (I3:1510;1008:95179)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4.5*fem, 0.2*fem),
                                    width: 15*fem,
                                    height: 11*fem,
                                    child: Image.asset(
                                      'assets/reels/tabler-diamond.png',
                                      width: 15*fem,
                                      height: 11*fem,
                                    ),
                                  ),
                                  Text(
                                    // Pqf (I3:1510;266:82615)
                                    '15',
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 14*ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2857142857*ffem/fem,
                                      color: Color(0xfff6b545),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
          Container(
            // icbaselinediamond8YM (3:1505)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 24*fem),
            padding: EdgeInsets.fromLTRB(12.5*fem, 9*fem, 0*fem, 9*fem),
            width: double.infinity,
            decoration: BoxDecoration (
              color: Color(0xfff8f8f8),
              borderRadius: BorderRadius.circular(12*fem),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // tablerdiamondRnM (3:1506)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12.5*fem, 0.2*fem),
                  width: 15*fem,
                  height: 11*fem,
                  child: Image.asset(
                    'assets/reels/tabler-diamond.png',
                    width: 15*fem,
                    height: 11*fem,
                  ),
                ),
                Obx(() {
                    return Text(
                      // LuK (3:1508)
                      userTotalDiamonds.value.toString(),
                      style: SafeGoogleFont (
                        'DM Sans',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.375*ffem/fem,
                        color: Color(0xff1e1e1e),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              int total;
                total= selectedGiftIndex.value==0 ? 5: selectedGiftIndex.value==1 ? 10 : 15;
                if(userTotalDiamonds.value>=total){
                  updateDiamondRecord(widget.postModel!, userViewModel.currentUser!, total);
                }
                else{
                  QuickHelp.showAppNotificationAdvanced(title: 'Insufficient Balance!', context: context, isError: false);

                }
            },
            child: Container(
              // button6db (I3:1511;0:15783)
              margin: EdgeInsets.fromLTRB(11*fem, 0*fem, 10*fem, 0*fem),
              width: double.infinity,
              height: 48*fem,
              decoration: BoxDecoration (
                color: Color(0xff57aaff),
                borderRadius: BorderRadius.circular(24*fem),
              ),
              child: Center(
                child: Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont (
                    'DM Sans',
                    fontSize: 16*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.375*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future updateDiamondRecord(PostsModel postModel, UserModel userModel, int total ) async{

    userModel.decrementCoins=total;

    ParseResponse response= await userModel.save();

    if(response.success){
      Navigator.of(context).pop();

      postModel.addDiamonds= total;
      postModel.setGift={
        "senderId": userModel.objectId!.toString(),
        "total":total.toString(),
      };
      ParseResponse response= await postModel.save();
      if(response.success){
        QuickHelp.showAppNotification(title: 'Gift sent to creator successfully!', context: context, isError: false);
      }
      else{
        QuickHelp.showAppNotificationAdvanced(title: 'Failed! to sent gift to Broadcaster', context: context);
      }
    }
    else{

    }

  }

  Widget _descriptionWidget() {
    return Container(
      width: 220,
      //height: 20,
      child: TextWithTap(
        widget.postModel!.getText!,
        color: Colors.white,
        fontSize: 14,
        selectableText: false,
        urlDetectable: true,
        humanize: true,
        overflow: TextOverflow.fade,
      ),
    );
  }

  /// Rainbow branch information
  Widget _rainBowBrandWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.watch_later_outlined,
          color: Colors.white,
          size: 16,
        ),
//        Image(
//          image: ,
//          width: 16,
//          height: 16,
//          color:  Colors.white,
//        ),
        SizedBox(width: 8.0),
        Container(
          width: 220,
          child: Text(
            QuickHelp.getTimeAgoForFeed(widget.postModel!.createdAt!),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Show user name and the time video uploaded

  goToProfile(BuildContext context, {UserModel? author}){
    if (author!.objectId == userViewModel.currentUser!.objectId!) {
      // QuickHelp.goToNavigatorScreen(
      //   context,
      //   ReelsVideosScreen(
      //     currentUser: currentUser,
      //   ),
      // );
    } else {
      // QuickHelp.goToNavigatorScreen(
      //   context,
      //   ReelsVideosScreen(
      //     currentUser: currentUser,
      //     mUser: author,
      //   ),
      // );
    }
  }

  Widget _userNameAndTimeUploadedWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: ()=> goToProfile(context, author: widget.postModel!.getAuthor!),
          child: QuickActions.avatarWidget(
            widget.postModel!.getAuthor!,
            width: 45,
            height: 45,
            margin: EdgeInsets.only(bottom: 0, top: 0, left: 0, right: 5),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWithTap(
              widget.postModel!.getAuthor!.getFullName!,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(1.0),
              fontSize: 15,
              marginLeft: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                QuickActions.showSVGAsset(
                  "assets/svg/ic_diamond.svg",
                  height: 20,
                ),
                TextWithTap(
                  "${widget.postModel!.getAuthor!.getCoins.toString()}",
                  color: Colors.white,
                  fontSize: 13,
                ),
                VerticalDivider(),
                QuickActions.showSVGAsset(
                  "assets/svg/ic_followers_active.svg",
                  height: 19,
                ),
                TextWithTap(
                  "${widget.postModel!.getAuthor!.getFollowers!.length.toString()}",
                  color: Colors.white,
                  fontSize: 13,
                ),
              ],
            )
          ],
        ),
        Visibility(
          visible: userViewModel.currentUser!.objectId != widget.postModel!.getAuthor!.objectId,
          child: _followWidget(context),
        ),
      ],
    );
    /*return Text(
      postModel!.getAuthor!.getFullName!,
      style: TextStyle(color: Colors.white),
    );*/
  }

  Widget _followWidget(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: LikeButton(
              size: 37,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              countPostion: CountPostion.top,
              circleColor:
                  CircleColor(start: kPrimaryColor, end: kPrimaryColor),
              bubblesColor: BubblesColor(
                dotPrimaryColor: kPrimaryColor,
                dotSecondaryColor: kPrimaryColor,
              ),
              isLiked: following,
              likeCountAnimationType: LikeCountAnimationType.none,
              likeBuilder: (bool isLiked) {
                return ContainerCorner(
                  //marginLeft: 10,
                  //marginRight: 6,
                  colors: [
                    isLiked ? Colors.black.withOpacity(0.4) : kPrimaryColor,
                    isLiked ? Colors.black.withOpacity(0.4) : kPrimaryColor
                  ],
                  child: ContainerCorner(
                      color: kTransparentColor,
                      //marginAll: 5,
                      height: 30,
                      width: 30,
                      child: Icon(
                        isLiked ? Icons.done : Icons.add,
                        color: Colors.white,
                        //isLiked ? kPrimaryColor : Colors.white,
                        size: 24,
                      )),
                  borderRadius: 50,
                  height: 40,
                  width: 40,
                );
              },
              onTap: (isLiked) {
                print("Liked: $isLiked");

                if (isLiked) {
                  followOrUnfollow();

                  return Future.value(false);
                } else {
                  followOrUnfollow();

                  return Future.value(true);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _deleteLike(PostsModel postsModel) async {
    QueryBuilder<NotificationsModel> queryBuilder =
        QueryBuilder<NotificationsModel>(NotificationsModel());
    queryBuilder.whereEqualTo(NotificationsModel.keyAuthor, userViewModel.currentUser);
    queryBuilder.whereEqualTo(NotificationsModel.keyPost, postsModel);

    ParseResponse parseResponse = await queryBuilder.query();

    if (parseResponse.success && parseResponse.results != null) {
      NotificationsModel notification = parseResponse.results!.first;
      await notification.delete();
    }
  }

  _likePost(PostsModel post) {
    QuickActions.createOrDeleteNotification(userViewModel.currentUser!, post.getAuthor!,
        NotificationsModel.notificationTypeLikedReels,
        post: post);
  }

  void openSheet(
      BuildContext context, UserModel author, PostsModel? post) async {
    showModalBottomSheet(
        context: (context),
        //isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        builder: (__) {
          return _showPostOptionsAndReportAuthor(context, author, post: post);
        });
  }

  Widget _showPostOptionsAndReportAuthor(BuildContext context, UserModel author,
      {PostsModel? post}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: post != null
          ? ContainerCorner(
              radiusTopRight: 20.0,
              radiusTopLeft: 20.0,
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: userViewModel.currentUser!.objectId != post.getAuthorId,
                      child: ButtonWithIcon(
                        text: "feed.report_post"
                            .tr(namedArgs: {"name": author.getFullName!}),
                        //iconURL: "assets/svg/ic_blocked_menu.svg",
                        icon: Icons.report_problem_outlined,
                        iconColor: kPrimaryColor,
                        iconSize: 26,
                        height: 60,
                        radiusTopLeft: 25.0,
                        radiusTopRight: 25.0,
                        backgroundColor: Colors.white,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        onTap: () {
                          openReportMessage(context, author, post);
                        },
                      ),
                    ),
                    Visibility(
                        visible: userViewModel.currentUser!.objectId != post.getAuthorId,
                        child: Divider()),
                    Visibility(
                      visible: userViewModel.currentUser!.objectId != post.getAuthorId,
                      child: ButtonWithIcon(
                        text: "feed.block_user"
                            .tr(namedArgs: {"name": author.getFullName!}),
                        textColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        //iconURL: "assets/images/ic_block_user.png",
                        icon: Icons.block,
                        iconColor: kPrimaryColor,
                        iconSize: 26,
                        onTap: () {
                          Navigator.of(context).pop();
                          QuickHelp.showDialogWithButtonCustom(
                            context: context,
                            title: "feed.post_block_title".tr(),
                            message: "feed.post_block_message"
                                .tr(namedArgs: {"name": author.getFullName!}),
                            cancelButtonText: "cancel".tr(),
                            confirmButtonText: "feed.post_block_confirm".tr(),
                            onPressed: () => _blockUser(context, author),
                          );
                        },
                        height: 60,
                        backgroundColor: Colors.white,
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ),
                    Visibility(
                        visible: userViewModel.currentUser!.objectId != post.getAuthorId,
                        child: Divider()),
                    Visibility(
                      visible: userViewModel.currentUser!.objectId == post.getAuthorId ||
                          userViewModel.currentUser!.isAdmin!,
                      child: ButtonWithIcon(
                        text: "feed.delete_post".tr(),
                        iconURL: "assets/svg/config.svg",
                        height: 60,
                        radiusTopLeft: 25.0,
                        radiusTopRight: 25.0,
                        backgroundColor: Colors.white,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textColor: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        onTap: () {
                          _deletePost(context, post);
                        },
                      ),
                    ),
                    Visibility(
                        visible: userViewModel.currentUser!.objectId == post.getAuthorId ||
                            userViewModel.currentUser!.isAdmin!,
                        child: Divider()),
                    Visibility(
                      visible: userViewModel.currentUser!.isAdmin!,
                      child: ButtonWithIcon(
                        text: "feed.suspend_user".tr(),
                        iconURL: "assets/svg/config.svg",
                        height: 60,
                        radiusTopLeft: 25.0,
                        radiusTopRight: 25.0,
                        backgroundColor: Colors.white,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textColor: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        onTap: () {
                          _suspendUser(context, post.getAuthor!);
                        },
                      ),
                    ),
                    Visibility(
                        visible: userViewModel.currentUser!.isAdmin!, child: Divider()),
                  ],
                ),
              ),
            )
          : ContainerCorner(
              radiusTopRight: 20.0,
              radiusTopLeft: 20.0,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: true,
                    child: ButtonWithIcon(
                      text: "feed.block_user"
                          .tr(namedArgs: {"name": author.getFullName!}),
                      textColor: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      iconURL: "assets/images/ic_block_user.png",
                      onTap: () {
                        Navigator.of(context).pop();
                        QuickHelp.showDialogWithButtonCustom(
                          context: context,
                          title: "feed.post_block_title".tr(),
                          message: "feed.post_block_message"
                              .tr(namedArgs: {"name": author.getFullName!}),
                          cancelButtonText: "cancel".tr(),
                          confirmButtonText: "feed.post_block_confirm".tr(),
                          onPressed: () => _blockUser(context, author),
                        );
                      },
                      height: 60,
                      backgroundColor: Colors.white,
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                  Visibility(visible: true, child: Divider()),
                  Visibility(
                    visible: userViewModel.currentUser!.isAdmin!,
                    child: ButtonWithIcon(
                      text: "feed.suspend_user".tr(),
                      iconURL: "assets/svg/config.svg",
                      height: 60,
                      radiusTopLeft: 25.0,
                      radiusTopRight: 25.0,
                      backgroundColor: Colors.white,
                      mainAxisAlignment: MainAxisAlignment.start,
                      textColor: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      onTap: () {
                        _suspendUser(context, post!.getAuthor!);
                      },
                    ),
                  ),
                  Visibility(visible: userViewModel.currentUser!.isAdmin!, child: Divider()),
                ],
              ),
            ),
    );
  }

  _blockUser(BuildContext context, UserModel author) async {
    Navigator.of(context).pop();
    QuickHelp.showLoadingDialog(context);

    userViewModel.currentUser!.setBlockedUser = author;
    userViewModel.currentUser!.setBlockedUserIds = author.getUid!;

    ParseResponse response = await userViewModel.currentUser!.save();
    if (response.success) {
      userViewModel.currentUser = response.results!.first as UserModel;

      QuickHelp.hideLoadingDialog(context);
      //QuickHelp.goToNavigator(context, BlockedUsersScreen.route);
      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "feed.post_block_success_title"
            .tr(namedArgs: {"name": author.getFullName!}),
        message: "feed.post_block_success_message".tr(),
        isError: false,
      );
    } else {
      QuickHelp.hideLoadingDialog(context);
    }
  }

  void openReportMessage(
      BuildContext context, UserModel author, PostsModel post) async {
    showModalBottomSheet(
        context: (context),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        builder: (context) {
          return _showReportMessageBottomSheet(context, author, post);
        });
  }

  Widget _showReportMessageBottomSheet(
      BuildContext context, UserModel author, PostsModel post) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.001),
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.1,
            maxChildSize: 1.0,
            builder: (_, controller) {
              return StatefulBuilder(builder: (context, setState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: ContainerCorner(
                    radiusTopRight: 20.0,
                    radiusTopLeft: 20.0,
                    color: QuickHelp.isDarkMode(context)
                        ? kContentColorLightTheme
                        : Colors.white,
                    child: Column(
                      children: [
                        ContainerCorner(
                          color: kGreyColor1,
                          width: 50,
                          marginTop: 5,
                          borderRadius: 50,
                          marginBottom: 10,
                        ),
                        TextWithTap(
                          "feed.report_".tr(),
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          marginBottom: 50,
                        ),
                        Column(
                          children: List.generate(
                              QuickHelp.getReportCodeMessageList().length,
                              (index) {
                            String code =
                                QuickHelp.getReportCodeMessageList()[index];

                            return TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                print("Message: " +
                                    QuickHelp.getReportMessage(code));
                                Navigator.of(context).pop();
                                _saveReport(context,
                                    QuickHelp.getReportMessage(code), post);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWithTap(
                                        QuickHelp.getReportMessage(code),
                                        color: kGrayColor,
                                        fontSize: 15,
                                        marginBottom: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: kGrayColor,
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1.0,
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                        ContainerCorner(
                          marginTop: 30,
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: TextWithTap(
                              "cancel".tr().toUpperCase(),
                              color: kGrayColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  _saveReport(BuildContext context, String reason, PostsModel post) async {
    QuickHelp.showLoadingDialog(context);

    userViewModel.currentUser?.setReportedPostIDs = post.objectId;
    userViewModel.currentUser?.setReportedPostReason = reason;

    ParseResponse response = await userViewModel.currentUser!.save();
    if (response.success) {
      QuickHelp.hideLoadingDialog(context);
      //setState(() {});
    } else {
      QuickHelp.hideLoadingDialog(context);
    }

    ParseResponse parseResponse = await QuickActions.report(
        type: ReportModel.reportTypePost,
        message: reason,
        accuser: userViewModel.currentUser!,
        accused: post.getAuthor!,
        postsModel: post);

    if (parseResponse.success) {
      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "feed.post_report_success_title"
            .tr(namedArgs: {"name": post.getAuthor!.getFullName!}),
        message: "feed.post_report_success_message".tr(),
        isError: false,
      );
    } else {
      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "error".tr(),
        message: "try_again_later".tr(),
      );
    }
  }

  _deletePost(BuildContext context, PostsModel post) {
    // QuickHelp.goBackToPreviousPage(context);

    QuickActions.showAlertDialog(context, "Are you sure you want to delete this post?", (){_confirmDeletePost(context, post);});

  }

  _suspendUser(BuildContext context, UserModel user) {
    QuickHelp.goBackToPreviousPage(context);

    QuickHelp.showDialogWithButtonCustom(
      context: context,
      title: "feed.suspend_user_alert".tr(),
      message: "feed.suspend_user_message".tr(),
      cancelButtonText: "no".tr(),
      confirmButtonText: "feed.yes_suspend".tr(),
      onPressed: () => _confirmSuspendUser(context, user),
    );
  }

  _confirmSuspendUser(BuildContext context, UserModel userModel) async {
    QuickHelp.goBackToPreviousPage(context);

    QuickHelp.showLoadingDialog(context);

    userModel.setActivationStatus = true;
    ParseResponse parseResponse =
        await QuickCloudCode.suspendUSer(objectId: userModel.objectId!);
    if (parseResponse.success) {
      QuickHelp.goBackToPreviousPage(context);

      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "suspended".tr(),
        message: "feed.user_suspended".tr(),
        user: userModel,
        isError: null,
      );
    } else {
      QuickHelp.goBackToPreviousPage(context);

      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "error".tr(),
        message: "feed.user_not_suspended".tr(),
        user: userModel,
        isError: true,
      );
    }
  }

  _confirmDeletePost(BuildContext context, PostsModel postsModel) async {
    QuickHelp.goBackToPreviousPage(context);

    QuickHelp.showLoadingDialog(context);

    ParseResponse parseResponse = await postsModel.delete();
    if (parseResponse.success) {
      Get.find<CommunityController>().videosList.removeAt(widget.currentIndex!);
      Get.find<CommunityController>().status = Status.Loading;
      Get.find<CommunityController>().update();
      Get.find<CommunityController>().loadFeedsVideo(Get.find<UserViewModel>().currentUser, false, updateBuild: true);

      QuickHelp.goBackToPreviousPage(context);

      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "deleted".tr(),
        message: "feed.post_deleted".tr(),
        user: postsModel.getAuthor,
        isError: false,
      );
    } else {
      QuickHelp.goBackToPreviousPage(context);

      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "error".tr(),
        message: "feed.post_not_deleted".tr(),
        user: postsModel.getAuthor,
        isError: true,
      );
    }
  }

  bool showPost(PostsModel post) {
    if (post.getExclusive!) {
      if (post.getAuthorId == userViewModel.currentUser!.objectId) {
        return true;
      } else if (post.getPaidBy!.contains(userViewModel.currentUser!.objectId)) {
        return true;
      } else if (userViewModel.currentUser!.isAdmin!) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  void followOrUnfollow() async {
    if (userViewModel.currentUser!.getFollowing!.contains(widget.postModel!.getAuthor!.objectId)) {
      userViewModel.currentUser!.removeFollowing = widget.postModel!.getAuthor!.objectId!;

      following = false;
    } else {
      userViewModel.currentUser!.setFollowing = widget.postModel!.getAuthor!.objectId!;

      following = true;
    }

    await userViewModel.currentUser!.save();

    ParseResponse parseResponse = await QuickCloudCode.followUser(
        isFollowing: false,
        author: userViewModel.currentUser!,
        receiver: widget.postModel!.getAuthor!);

    if (parseResponse.success) {
      QuickActions.createOrDeleteNotification(userViewModel.currentUser!,
          widget.postModel!.getAuthor!, NotificationsModel.notificationTypeFollowers);
    }
  }

  void showComments(BuildContext context,double fem, double ffem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useRootNavigator: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      // backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Get.isDarkMode ? Alignment.bottomLeft : Alignment.bottomCenter,
                end: Get.isDarkMode ? Alignment.topRight : Alignment.topCenter,
                stops: Get.isDarkMode ? const [0.7, 0.9] : null,
                colors: Get.isDarkMode ? AppColors.darkBGGradientColor : AppColors.lightBGGradientColor),
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height:18*fem),    
            Text("Comments",
            style: SafeGoogleFont('DM Sans',
              fontSize: 16*ffem,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),),
            SizedBox(height:14*fem),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16*fem),
              child: Divider(color: AppColors.white.withOpacity(0.7),),
            ),

            Expanded(
              child: Comments(postModel: widget.postModel!,currentUser: userViewModel.currentUser,reels: true,),
            ),
          ],
        ),
      ),
    );
  }

  Widget liveComments(BuildContext context,double fem,double ffem) {
    QueryBuilder<CommentsModel> queryBuilder =
        QueryBuilder<CommentsModel>(CommentsModel());
    queryBuilder.whereEqualTo(CommentsModel.keyPostId, widget.postModel!.objectId);

    queryBuilder.includeObject([
      CommentsModel.keyAuthor,
      CommentsModel.keyPost,
    ]);
    queryBuilder.orderByDescending(CommentsModel.keyCreatedAt);

    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: ParseLiveListWidget<CommentsModel>(
        query: queryBuilder,
        key: Key(widget.postModel!.objectId!),
        duration: Duration(microseconds: 500),
        lazyLoading: false,
        shrinkWrap: true,
        //primary: true,
        childBuilder: (BuildContext context,
            ParseLiveListElementSnapshot<CommentsModel> snapshot) {
          CommentsModel comment = snapshot.loadedData!;

          return GestureDetector(
            onTap: (){

              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }

              goToProfile(context, author: comment.getAuthor!);

              //QuickActions.showUserProfile(context, currentUser!, comment.getAuthor!);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10,right: 15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      QuickActions.avatarWidget(comment.getAuthor!,
                          width: 40*fem, height: 40*fem),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(8*fem, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.getAuthor!.getFullName!,
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 14*ffem,
                                  fontWeight: FontWeight.w700,
                                  height: (18/14)*ffem/fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                              SizedBox(height: 1*fem,),

                              Text(
                                QuickHelp.getTimeAgo(comment.createdAt!),
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 12*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2727272727*ffem/fem,
                                  color: Color(0xff080808).withOpacity(0.4),
                                ),
                              ),
                              SizedBox(height: 3*fem,),
                              Text(
                                  comment.getText!,
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 12*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: (16/12)*ffem/fem,
                                  color: Color(0xff080808),
                                ),
                              ),
                              SizedBox(height: 4*fem,),
                              Row(
                                children: [
                                  Text(
                                      'See translation ',
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 12*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: (16/12)*ffem/fem,
                                      color: Color(0xff080808).withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(width: 8*fem,),
                                  Text(
                                    'More',
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 12*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: (16/12)*ffem/fem,
                                      color: Color(0xff080808).withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Align(
                        alignment: Alignment.centerRight,
                        child: LikeButton(
                          padding: EdgeInsets.only(right: 2),
                          size: 20,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          countPostion: CountPostion.bottom,
                          circleColor:
                          CircleColor(start: kPrimaryColor, end: kPrimaryColor),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: kPrimaryColor,
                            dotSecondaryColor: kPrimaryColor,
                          ),
                          isLiked: widget.postModel!.getLikes!.contains(userViewModel.currentUser!.objectId),
                          likeCountAnimationType: LikeCountAnimationType.all,
                          likeBuilder: (bool isLiked) {
                            return Container(
                              // biheartfillUM3 (3:836)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                              width: 20*fem,
                              height: 20*fem,
                              child: Image.asset(
                                isLiked? "assets/reels/bi-heart-fill-taq.png": 'assets/profile/icheart-ozZ.png',
                                color: isLiked? kPrimaryColor: null,
                                width: 20*fem,
                                height: 20*fem,
                              ),
                            );
                          },

                          onTap: (isLiked) {
                            print("Liked: $isLiked");

                            if (isLiked) {
                              widget.postModel!.removeLike = userViewModel.currentUser!.objectId!;

                              widget.postModel!.save().then((value) {
                                widget.postModel = value.results!.first as PostsModel;
                              });

                              _deleteLike(widget.postModel!);

                              return Future.value(false);
                            } else {
                              widget.postModel!.setLikes = userViewModel.currentUser!.objectId!;
                              widget.postModel!.setLastLikeAuthor = userViewModel.currentUser!;

                              widget.postModel!.save().then((value) {
                                widget.postModel = value.results!.first as PostsModel;
                              });

                              _likePost(widget.postModel!);

                              return Future.value(true);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
        listLoadingElement: QuickHelp.showLoadingAnimation(size: 30),
        queryEmptyElement: QuickActions.noContentFound(
            "feed.reels_no_comment_title".tr(),
            "feed.reels_no_comment_explain".tr(),
            "assets/svg/ic_post_comment.svg",
            imageHeight: 80,
            imageWidth: 80,
            color: kGrayColor),
      ),
    );
  }

  Future<void> tools (BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.28,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .139,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.card,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(userViewModel.currentUser!.objectId != widget.postModel!.getAuthorId)
                      GestureDetector(
                      onTap : ()=> Get.toNamed(AppRoutes.chatReportScreen, arguments: widget.postModel!.getAuthor),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Report',
                              style: sfProDisplayRegular.copyWith(
                                color: AppColors.textWhite,
                                fontSize: 18.sp,
                              )),
                        ),
                      ),
                    ),
                    if(userViewModel.currentUser!.objectId != widget.postModel!.getAuthorId)
                      Divider(
                      thickness: 0.1,
                      color: AppColors.grey,
                    ),
                    if(userViewModel.currentUser!.objectId == widget.postModel!.getAuthorId)
                    GestureDetector(
                      onTap: ()=> _deletePost(context, widget.postModel!),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Delete',
                              style: sfProDisplayRegular.copyWith(
                                color: AppColors.textWhite,
                                fontSize: 18.sp,
                              )),
                        ),
                      ),
                    ),
                    if(userViewModel.currentUser!.objectId == widget.postModel!.getAuthorId)
                      Divider(
                      thickness: 0.1,
                      color: AppColors.grey,
                    ),
                    GestureDetector(
                      onTap: ()=> QuickActions.showAlertDialog(context, "Are you sure you want to block this user?",
                              () {
                        Get.back();
                        Get.find<UserViewModel>().addToBlockList(widget.postModel!.getAuthor!.getUid!);
                        QuickHelp.showAppNotificationAdvanced(title: 'User added to block list', context: context);
                      }),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Block User',
                              style: sfProDisplayRegular.copyWith(
                                color: AppColors.textWhite,
                                fontSize: 18.sp,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.yellowBtnColor,
                  ),
                  child: Center(
                    child: Text('Cancel',
                        style: sfProDisplayRegular.copyWith(
                          color: AppColors.black,
                          fontSize: 20.sp,
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _createComment(BuildContext context, PostsModel post, String text) async {
    QuickHelp.showLoadingDialog(context);

    CommentsModel comment = CommentsModel();
    comment.setAuthor = userViewModel.currentUser!;
    comment.setText = text;
    comment.setAuthorId = userViewModel.currentUser!.objectId!;
    comment.setPostId = post.objectId!;
    comment.setPost = post;

    await comment.save();

    post.setComments = comment.objectId!;
    await post.save();

    QuickHelp.hideLoadingDialog(context);

    QuickActions.createOrDeleteNotification(userViewModel.currentUser!, post.getAuthor!,
        NotificationsModel.notificationTypeCommentReels,
        post: post);
  }
}
