import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../helpers/quick_actions.dart';
import '../../../helpers/quick_help.dart';
import '../../../parse/CommentsModel.dart';
import '../../../parse/PostsModel.dart';
import '../../../parse/ReplyModel.dart';
import '../../../parse/UserModel.dart';
import '../../../utils/Utils.dart';
import '../../../utils/colors.dart';
import '../../../utils/colors_hype.dart';
import '../trending/widgets/report_comment_sheet.dart';

class Comments extends StatefulWidget {
  final PostsModel postModel;
  final UserModel? currentUser;
  final bool reels;

  Comments({Key? key, required this.postModel, this.currentUser, this.reels=false})
      : super(key: key);


  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool isReply=false;
  CommentsModel? selectedCommentModel;

  late PostsModel postModel;
  TextEditingController commentEditingController= TextEditingController();
  RxBool showAll=false.obs;

  List<String> prohibitedCategories = [
    'I just don\'t like it',
    'Nudity or pornography',
    'Hate speech or symbols',
    'Violence or threat of violence',
    'Sale or promotion of firearms',
    'Sale or promotion of drugs',
    'Harassment or bullying',
    'Self injury',
  ];

  int selected=-1;



  @override
  void initState() {
    // TODO: implement initState
    postModel=widget.postModel;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  Widget liveComments(BuildContext context,double fem, double ffem, StateSetter wholeState) {
    QueryBuilder<CommentsModel> queryBuilder =
    QueryBuilder<CommentsModel>(CommentsModel());
    queryBuilder.whereEqualTo(CommentsModel.keyPostId, postModel.objectId);

    queryBuilder.includeObject([
      CommentsModel.keyAuthor,
      CommentsModel.keyPost,
    ]);
    queryBuilder.orderByDescending(CommentsModel.keyCreatedAt);
    // queryBuilder.whereNotEqualTo(CommentsModel.keyReport,widget.currentUser!.objectId);

    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: ParseLiveListWidget<CommentsModel>(
        scrollPhysics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 120*fem),
        query: queryBuilder,
        key: Key(postModel.objectId!),
        duration: Duration(microseconds: 500),
        lazyLoading: false,
        shrinkWrap: true,
        //primary: true,
        childBuilder: (BuildContext context,
            ParseLiveListElementSnapshot<CommentsModel> snapshot) {
          CommentsModel comment = snapshot.loadedData!;


          return comment.getReportList!.contains(widget.currentUser!.objectId!)? SizedBox(): Column(
            children: [
              SizedBox(
                // group51613uus (5:18100)
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){
                       goToProfile(otherProfile: false, mUser: widget.currentUser!);
                      },
                      child: Container(
                        // rectangle25443mB (5:18107)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 17*fem),
                        width: 48*fem,
                        height: 48*fem,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24*fem),
                          child: Image.network(
                            comment.getAuthor!.getAvatar!.url!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // autogroup1tcyYT3 (QrvDPUAj81PnXCL2rE1tcy)
                      margin: EdgeInsets.fromLTRB(0*fem, 5*fem, 0.5*fem, 0*fem),
                      width: 260.5*fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 250*fem,
                                        child: RichText(
                                          maxLines: 7,
                                          text: TextSpan(
                                            style: SafeGoogleFont (
                                              'DM Sans',
                                              fontSize: 12*ffem,
                                              height: 1.1666666667*ffem/fem,
                                              color: Get.isDarkMode ? Colors.white : AppColors.black
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${comment.getAuthor!.getFullName!}',
                                                style: SafeGoogleFont (
                                                  'DM Sans',
                                                  fontSize: 12*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.1666666667*ffem/fem,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ', // Add space between text spans
                                              ),
                                              TextSpan(
                                                text: '${comment.getText ?? ''}',
                                                // text: '  ${comment.getText!}',
                                                style: SafeGoogleFont (
                                                  'DM Sans',
                                                  fontSize: 12*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.23*ffem/fem,
                                                ),
                                                // Add additional text here without any special formatting
                                              ),
                                            ],
                                          ),
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                                SizedBox(height: 2*fem,),
                                Container(
                                  // frame51614KEq (5:18101)
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // mfpV (5:18102)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 0*fem),
                                        child: Text(
                                          QuickHelp.getTimeAgo(comment.createdAt!) ,
                                          style: SafeGoogleFont (
                                            'DM Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2727272727*ffem/fem,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 9*fem, 0*fem),
                                        child: Text(
                                          '${comment.getLikes!.length.toString()} likes',
                                          style: SafeGoogleFont (
                                            'DM Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2727272727*ffem/fem,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          moreDialog(context,fem,ffem,
                                                  (){
                                                    setState(() {
                                                      isReply=true;
                                                      selectedCommentModel=comment;
                                                      Navigator.of(context).pop();
                                                    });
                                                  },
                                                  (){
                                                    Navigator.of(context).pop();
                                                    openBottomSheet(ReportCommentSheet(comment: comment,), context);
                                                  },

                                              (){
                                                Navigator.of(context).pop();
                                              QuickActions.showAlertDialog(context, "Are you sure you want to delete this comment?", (){comment.delete().then((value) {
                                                removeCommentFromList(comment);
                                                Navigator.of(context).pop();
                                                setState((){});
                                                QuickHelp.showAppNotificationAdvanced(title: "comment deleted!", context: context, isError: false);
                                              });});


                                              }, comment.getAuthorId==widget.currentUser!.objectId

                                          );

                                        },
                                        child: Text(
                                          // replyX61 (5:18104)
                                          'More',
                                          style: SafeGoogleFont (
                                            'DM Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2727272727*ffem/fem,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if(comment.getShowAll!.contains(widget.currentUser!.objectId!)){
                                comment.removeShowAll=widget.currentUser!.objectId!;
                                await comment.save();
                                wholeState((){});
                              }
                              else{
                                comment.setShowAll=widget.currentUser!.objectId!;
                                await comment.save();
                                wholeState((){});
                              }




                            },
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    // viewreplies12RhB (5:18110)
                                   comment.getShowAll!.contains(widget.currentUser!.objectId!) ?'Show Less':'View Replies (${comment.getReplyList!.length.toString()})'  ,
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 12*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3333333333*ffem/fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Center(
                      child: _likeWidget(context,comment)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5*fem,),
               Container(
                        // group51621cmf (5:18275)
                        margin: EdgeInsets.fromLTRB(60*fem, 5*fem, 0*fem, 0*fem),
                        child: liveReplies(context,fem,ffem,comment,comment.getShowAll!.contains(widget.currentUser!.objectId)),


              ),
              SizedBox(height: 3*fem,),
            ],
          );
        },
        listLoadingElement: QuickHelp.showLoadingAnimation(size: 30),
        queryEmptyElement: Container(
          height: 330.h,
          child: Center(
            child: QuickActions.noContentFound(
                "feed.reels_no_comment_title".tr(),
                "feed.reels_no_comment_explain".tr(),
                "assets/svg/ic_post_comment.svg",
                mainAxisAlignment: MainAxisAlignment.center,
                imageHeight: 0,
                imageWidth: 0,
                color: kGrayColor),
          ),
        ),
      ),
    );
  }


  Future removeCommentFromList(CommentsModel comment) async{
    postModel.removeComment=comment.objectId!;
    postModel.save();
  }



  void showReportOptions(BuildContext context,double fem, double ffem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useRootNavigator: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height:18*fem),
            Text("${widget.postModel.getComments!.length} Comments",
              style: SafeGoogleFont('DM Sans',
                fontSize: 14*ffem,
                fontWeight: FontWeight.w600,
                color: hBlack,
              ),),
            SizedBox(height:18*fem),
            Expanded(
              child: Comments(postModel: widget.postModel,currentUser: widget.currentUser,reels: true,),
            ),
          ],
        ),
      ),
    );
  }

  Future reportSheet(double fem, double ffem, StateSetter setState,CommentsModel comment){
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.0),
          topRight: Radius.circular(36.0),
        ),),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState /*You can rename this!*/) {
              return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Get.isDarkMode ? Alignment.bottomLeft : Alignment.bottomCenter,
                          end: Get.isDarkMode ? Alignment.topRight : Alignment.topCenter,
                          stops: Get.isDarkMode ? const [0.7, 0.9] : null,
                          colors: Get.isDarkMode ? AppColors.darkBGGradientColor : AppColors.lightBGGradientColor),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36.0),
                        topRight: Radius.circular(36.0),
                      )
                  ),
                  height: MediaQuery.of(context).size.height*0.7,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0, 23*fem, 0, 20*fem),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 163*fem,
                            height: 28*fem,
                            child: Text('Report Comment',
                                style: SafeGoogleFont('DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18*ffem,
                                    color: AppColors.white,
                                    height: (24/18)*(ffem/fem) )),
                          ),
                        ],
                      ),
                      SizedBox(height: 16*fem,),
                      ListView.builder(
                        shrinkWrap: true, // Allow the ListView to shrink-wrap its content
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: prohibitedCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              setModalState(() {
                                selected=index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(21*fem, 0, 17*fem, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.white.withOpacity(0.3), // Set bottom border color here
                                      width: 1.0, // Set border width if needed
                                    ),
                                  ),
                                ),
                                height: 50*fem,
                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0*fem, 0, 0*fem, 0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(prohibitedCategories[index],
                                            style: SafeGoogleFont('DM Sans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16*ffem,
                                                color: AppColors.white,
                                                height: (22/16)*(ffem/fem))),
                                        const Expanded(child: SizedBox()),
                                        Image.asset(selected==index? 'assets/reels/radio_active.png' : 'assets/reels/radio.png',
                                          height: 22*fem, width: 22*fem,)

                                      ],
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          );
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.fromLTRB(18*fem, 0, 18*fem, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 160*fem,
                                height: 40*fem,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x3f000000),
                                      offset: Offset(0*fem, 4*fem),
                                      blurRadius: 2*fem,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(24*fem)
                                  ),
                                  color: const Color(0xffF1F1F1),
                                ),
                                child: Center(
                                  child: Text('Cancel',
                                      style: SafeGoogleFont('DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16*ffem,
                                          color: const Color(0xff000000),
                                          height: (22/16)*(ffem/fem))),
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                comment.setReport=widget.currentUser!.objectId!;
                                comment.save().then((value) {
                                  Navigator.pop(context);
                                  setState((){});
                                  showCustomDialog(fem,ffem,comment);


                                });

                              },
                              child: Container(
                                width: 160*fem,
                                height: 40*fem,
                                decoration: BoxDecoration(
                                  color: AppColors.yellowBtnColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(24*fem)
                                  ),

                                ),
                                child: Center(
                                  child: Text('Submit',
                                      style: SafeGoogleFont('DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16*ffem,
                                          color: const Color(0xffFFFFFF),
                                          height: (22/16)*(ffem/fem))),
                                ),
                              ),
                            )
                          ],
                        ),
                      )



                    ],
                  )
              );
            }
        );
      },
    );
  }


  Future<void> showCustomDialog(double fem, double ffem, CommentsModel comment) async {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.zero,

          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color(0xffF1F1F1), // Dialog background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0*fem),
          ),
          content: Container(
            height:264*fem,
            width:356*fem,
            // pop59A (1:4055)
            padding: EdgeInsets.fromLTRB(21*fem, 48*fem, 21*fem, 18*fem),
            decoration: BoxDecoration (
              color: const Color(0xffF1F1F1),
              borderRadius: BorderRadius.circular(19*fem),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 54*fem,
                  width: 54*fem,
                  child: Image.asset('assets/dino/tick.png'),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0*fem, 31*fem, 0*fem, 0*fem),
                      child: Text(
                        'Thanks for reporting this Comment',
                        style: SafeGoogleFont (
                          'DM Sans',
                          fontSize: 19*ffem,
                          fontWeight: FontWeight.w500,
                          height: (22/19)*ffem/fem,
                          color: const Color(0xff3A3A3A),
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cancel',
                          style: SafeGoogleFont (
                            'DM Sans',
                            fontSize: 19*ffem,
                            fontWeight: FontWeight.w500,
                            height: (22/19)*ffem/fem,
                            color: const Color(0xff000000).withOpacity(0.38),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  Widget liveReplies(BuildContext context,double fem, double ffem, CommentsModel commentModel, bool showAll) {

    QueryBuilder<ReplyModel> queryBuilder =
    QueryBuilder<ReplyModel>(ReplyModel());
    queryBuilder.whereEqualTo(ReplyModel.keyCommentId, commentModel.objectId);

    queryBuilder.includeObject([
      ReplyModel.keyAuthor,
      ReplyModel.keyComment,
    ]);
    queryBuilder.orderByDescending(ReplyModel.keyCreatedAt);
    if(!showAll){
      queryBuilder.setLimit(1);
    }

    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: ParseLiveListWidget<ReplyModel>(
        query: queryBuilder,
        key: Key(postModel.objectId!),
        duration: Duration(microseconds: 500),
        lazyLoading: false,
        shrinkWrap: true,
        //primary: true,
        childBuilder: (BuildContext context,
            ParseLiveListElementSnapshot<ReplyModel> snapshot) {
          ReplyModel replyModel = snapshot.loadedData!;

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // rectangle2544wow (5:18276)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                    width: 36*fem,
                    height: 36*fem,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24*fem),
                      child: Image.network(
                        replyModel.getAuthor!.getAvatar!.url!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0*fem, 5*fem, 0.5*fem, 0*fem),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // autogroupmjghskD (QrvDgsqPRuyTXUtinwmJgh)
                            padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        replyModel.getAuthor!.getFullName!,
                                        style: SafeGoogleFont (
                                          'DM Sans',
                                          fontSize: 12*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1666666667*ffem/fem,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(5*fem, 0, 0, 0*fem),
                                        child: Text(
                                          replyModel.getText!,
                                          maxLines: 7,
                                          style: SafeGoogleFont (
                                            'DM Sans',
                                            fontSize: 12*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.1666666667*ffem/fem,
                                            color: AppColors.white,                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  // frame51614KEq (5:18101)
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // mfpV (5:18102)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 0*fem),
                                        child: Text(
                                          QuickHelp.getTimeAgo(replyModel.createdAt!),
                                          style: SafeGoogleFont (
                                            'DM Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2727272727*ffem/fem,
                                            color: AppColors.white,                                          ),
                                        ),
                                      ),
                                      Container(
                                        // likesnu7 (5:18103)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 9*fem, 0*fem),
                                        child: Text(
                                          '${replyModel.getLikes!.length.toString()} likes',
                                          style: SafeGoogleFont (
                                            'DM Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2727272727*ffem/fem,
                                            color: AppColors.white,                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                      child: _likeWidgetReply(context,replyModel)
                  ),
                ],
              ),
              SizedBox(height: 5*fem,)
            ],
          );
        },
        listLoadingElement: QuickHelp.showLoadingAnimation(size: 30),
        queryEmptyElement: SizedBox()
      ),
    );
  }

  _createComment(BuildContext context, PostsModel post, String text) async {
    QuickHelp.showLoadingDialog(context);

    CommentsModel comment = CommentsModel();
    comment.setAuthor = widget.currentUser!;
    comment.setText = text;
    comment.setAuthorId = widget.currentUser!.objectId!;
    comment.setPostId = post.objectId!;
    comment.setPost = post;

    await comment.save();

    post.setComments = comment.objectId!;
    await post.save().then((value) {
     setState((){});
     commentEditingController.text='';
     if (FocusScope.of(context).hasFocus) {
       FocusScope.of(context).unfocus();
     }
    }
    );

    QuickHelp.hideLoadingDialog(context);

    // QuickActions.createOrDeleteNotification(currentUser!, post.getAuthor!,
    //     NotificationsModel.notificationTypeCommentReels,
    //     post: post);
  }

  _createReply(BuildContext context, String text) async {
    QuickHelp.showLoadingDialog(context);

    ReplyModel replyModel = ReplyModel();
    replyModel.setAuthor = widget.currentUser!;
    replyModel.setText = text;
    replyModel.setAuthorId = widget.currentUser!.objectId!;
    replyModel.setComment = selectedCommentModel!;
    replyModel.setCommentId = selectedCommentModel!.objectId!;

    await replyModel.save();

    selectedCommentModel!.setReply = replyModel.objectId!;

    await selectedCommentModel!.save().then((value) {
      setState((){});
      isReply=false;
      commentEditingController.text='';
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
    }
    );

    QuickHelp.hideLoadingDialog(context);

  }

  Widget _likeWidget(BuildContext context,  CommentsModel commentModel) {
    return LikeButton(
      padding: EdgeInsets.zero,
      size: 18,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      countPostion: CountPostion.top,
      circleColor:
      CircleColor(start: kPrimaryColor, end: kPrimaryColor),
      bubblesColor: BubblesColor(
        dotPrimaryColor: kPrimaryColor,
        dotSecondaryColor: kPrimaryColor,
      ),
      isLiked: commentModel!.getLikes!.contains(widget.currentUser!.objectId),
      likeCountAnimationType: LikeCountAnimationType.all,
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_outline_outlined,
          color: isLiked ? kPrimaryColor :  Get.isDarkMode ? Colors.white.withOpacity(0.8) : AppColors.black.withOpacity(0.8),
          size: 18,
        );
      },
      onTap: (isLiked) {
        print("Liked: $isLiked");

        if (isLiked) {
          commentModel!.removeLike = widget.currentUser!.objectId!;

          commentModel!.save().then((value) {
            commentModel = value.results!.first as CommentsModel;

          });


          return Future.value(false);
        } else {
          commentModel!.setLikes = widget.currentUser!.objectId!;

          commentModel!.save().then((value) {
            commentModel = value.results!.first as CommentsModel;

          });


          return Future.value(true);
        }
      },
    );
  }


  Widget _likeWidgetReply(BuildContext context,  ReplyModel replyModel) {
    return LikeButton(
      padding: EdgeInsets.zero,
      size: 18,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      countPostion: CountPostion.top,
      circleColor:
      CircleColor(start: kPrimaryColor, end: kPrimaryColor),
      bubblesColor: BubblesColor(
        dotPrimaryColor: kPrimaryColor,
        dotSecondaryColor: kPrimaryColor,
      ),
      isLiked: replyModel.getLikes!.contains(widget.currentUser!.objectId),
      likeCountAnimationType: LikeCountAnimationType.all,
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_outline_outlined,
          color: isLiked ? kPrimaryColor : Colors.white.withOpacity(0.8),
          size: 18,
        );
      },
      onTap: (isLiked) {
        if (isLiked) {
          replyModel.removeLike = widget.currentUser!.objectId!;

          replyModel.save().then((value) {
            replyModel = value.results!.first as ReplyModel;
            setState(() {

            });

          });


          return Future.value(false);
        } else {
          replyModel!.setLikes = widget.currentUser!.objectId!;

          replyModel!.save().then((value) {
            replyModel = value.results!.first as ReplyModel;
            setState(() {

            });

          });


          return Future.value(true);
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Stack(
      children: [
        SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(15*fem, 11*fem, 15*fem, 80*fem),
              width: double.infinity,
              height: 480*fem,
              child: liveComments(context, fem, ffem, setState),
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 375*fem,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            height: isReply? 113*fem : 70*fem,
            color: isReply ? AppColors.navBarColor : Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: isReply,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15*fem, 14*fem, 16*fem, 13*fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                          child: Text(
                            selectedCommentModel!=null ?'replying to ${selectedCommentModel!.getAuthor!.getFullName}': '',
                            style: SafeGoogleFont (
                              'DM Sans',
                              fontSize: 12*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.3333333333*ffem/fem,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: (){
                            setState(() {
                              isReply=false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                            width: 15*fem,
                            height: 15*fem,
                            child: Image.asset(
                              'assets/png/ic_cross.png',
                              color: AppColors.white,
                              width: 15*fem,
                              height: 15*fem,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15*fem, 10*fem, 15*fem, 5*fem),
                  width: double.infinity,
                  height: 70*fem,
                  decoration: const BoxDecoration (
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          // QuickHelp.goToNavigatorScreen(context, ProfileMoments(currentUser: widget.currentUser , mProfile: widget.currentUser, otherProfile: true,));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 7*fem),
                          width: 36*fem,
                          height: 36*fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24*fem),
                            child: Image.network(
                              widget.currentUser!.getAvatar!.url!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(6*fem, 0*fem, 0*fem, 7*fem),
                        child: Visibility(
                          visible: isReply,
                          child: RichText(
                            text: TextSpan(
                              style: SafeGoogleFont (
                                'DM Sans',
                                fontSize: 13*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2307692308*ffem/fem,
                                color: Color(0xff1e1e1e),
                              ),
                              children: [
                                TextSpan(
                                  text: '@${selectedCommentModel!=null ?'${selectedCommentModel!.getAuthor!.getFirstName}': ''}',
                                  style: SafeGoogleFont (
                                    'DM Sans',
                                    fontSize: 13*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2307692308*ffem/fem,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: isReply ? 6.w : 8.w,),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(isReply ? 5*fem: 2*fem, 0, 0, isReply ?  9*fem : 7*fem),
                          width: isReply ? 170 * fem : 230*fem,
                          height: 36 * fem,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(90.r)
                          ),
                          child: TextField(
                            controller: commentEditingController,
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2307692308 * ffem / fem,
                              color: AppColors.black,
                            ),
                            decoration: InputDecoration(
                              fillColor: AppColors.white.withOpacity(0.7),
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(16*fem, 8*fem, 16*fem, 0),
                              hintText: 'Add a comment', // Placeholder text when the TextField is empty
                              hintStyle: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2307692308 * ffem / fem,
                                color: AppColors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(90.r)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(90.r)
                              ),
                            ),
                            // Add additional properties like onChanged, controller, etc. as needed
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      InkWell(
                        onTap: (){
                          !isReply ? _createComment(context,postModel,commentEditingController.text) : _createReply(context,commentEditingController.text);
                        },
                        child: Container(
                          // postBVs (5:18237)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, isReply ?0 : 5*fem, isReply ? 9.5*fem : 7*fem),
                          child: Text(
                            'Post',
                            style: SafeGoogleFont (
                              'DM Sans',
                              fontSize: 13*ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2307692308*ffem/fem,
                              color: Color(0xff51B1EE),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

 }

  void moreDialog(BuildContext context, double fem ,double ffem, Function() reply, Function() report, Function() delete, bool isAuthor){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter settState) {
                return  AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: Color(0xFF494848),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0*fem),),
                  content: Container(
                    padding: EdgeInsets.fromLTRB(isAuthor==true ? 25*fem : 30*fem, 25*fem, 30*fem, isAuthor==true ? 25-1.2*fem : 0*fem),
                    width: 325*fem,
                    height: 118*fem,
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular(20*fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: reply,
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  // choosefromalbumJhF (5:18354)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                  child: Text(
                                    'Reply',
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 16*ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.375*ffem/fem,
                                      color: Color(0xffFFFFFF).withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if(isAuthor == false)
                        Padding(
                          padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, isAuthor==true ? 0*fem : 0),
                          child: InkWell(
                            onTap: report,
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    'Report',
                                    style: SafeGoogleFont (
                                      'DM Sans',
                                      fontSize: 16*ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.375*ffem/fem,
                                      color: Color(0xffFFFFFF).withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isAuthor==true,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                            child: InkWell(
                              onTap: delete,
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Text(
                                      // takeaphotoqBP (5:18355)
                                      'Delete',
                                      style: SafeGoogleFont (
                                        'DM Sans',
                                        fontSize: 16*ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.375*ffem/fem,
                                        color: Color(0xffFFFFFF).withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        }
    );}

}

