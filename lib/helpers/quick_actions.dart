import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:teego/helpers/send_notifications.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/parse/NotificationsModel.dart';
import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/ReportModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/ui/container_with_corner.dart';
import 'package:teego/ui/text_with_tap.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:flutter/material.dart';

import '../utils/Utils.dart';
import '../utils/constants/app_constants.dart';
import '../view/widgets/AvatarInitials.dart';
import '../view/widgets/custom_buttons.dart';
import '../view_model/live_controller.dart';


class QuickActions {


  static Widget avatarWidgetNotification(
      {double? width, double? height, EdgeInsets? margin, String? imageUrl, UserModel? currentUser,}) {
    if (imageUrl != null) {
      return Container(
        margin: margin,
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) =>
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                ),
              ),
          //placeholder: (context, url) => _avatarInitials(currentUser),
          //errorWidget: (context, url, error) => _avatarInitials(currentUser),
        ),
      );
    } else if (currentUser != null && currentUser.getAvatar != null) {
      return Container(
        margin: margin,
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: currentUser.getAvatar!.url!,
          imageBuilder: (context, imageProvider) =>
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                ),
              ),
          placeholder: (context, url) => _avatarInitials(currentUser),
          errorWidget: (context, url, error) => _avatarInitials(currentUser),
        ),
      );
    } else {
      return Container();
    }
  }

  static Widget avatarWidget(UserModel currentUser,
      {double? width, double? height, EdgeInsets? margin, String? imageUrl}) {
    if (currentUser.getAvatar != null) {
      return Container(
        margin: margin,
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: currentUser.getAvatar!.url!,
          imageBuilder: (context, imageProvider) =>
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                ),
              ),
          placeholder: (context, url) => _avatarInitials(currentUser),
          errorWidget: (context, url, error) => _avatarInitials(currentUser),
        ),
      );
    } else if (imageUrl != null) {
      return Container(
        margin: margin,
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) =>
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                ),
              ),
          //placeholder: (context, url) => _avatarInitials(currentUser),
          //errorWidget: (context, url, error) => _avatarInitials(currentUser),
        ),
      );
    } else {
      return _avatarInitials(currentUser);
    }
  }

  static Widget _avatarInitials(UserModel currentUser) {
    return AvatarInitials(
      name: '${currentUser.getFirstName}',
      textSize: 14,
      avatarRadius: 8,
      backgroundColor:
      QuickHelp.isDarkModeNoContext() ? Colors.white : Color(0xFFFFC107),
      textColor: QuickHelp.isDarkModeNoContext()
          ? Color(0xFF000000)
          : Color(0xFFFFFFFF),
    );
  }

  static Widget photosWidget(String? imageUrl,
      {double? borderRadius = 8, BoxFit? fit = BoxFit
          .cover, double? width, double? height, EdgeInsets? margin}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl != null ? imageUrl : "",
        imageBuilder: (context, imageProvider) =>
            Container(
              decoration: BoxDecoration(
                //shape: boxShape!,
                borderRadius: BorderRadius.circular(borderRadius!),
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
            ),
        placeholder: (context, url) =>
            _loadingWidget(width: width, height: height, radius: borderRadius),
        errorWidget: (context, url, error) =>
            _loadingWidget(width: width, height: height, radius: borderRadius),
      ),
    );
  }

  static Widget photosWidgetCircle(String imageUrl,
      {double? borderRadius = 8, BoxFit? fit = BoxFit
          .cover, double? width, double? height, EdgeInsets? margin, BoxShape? boxShape = BoxShape
          .rectangle, Widget? errorWidget}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) =>
            Container(
              decoration: BoxDecoration(
                shape: boxShape!,
                //borderRadius: BorderRadius.circular(borderRadius!),
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
            ),
        placeholder: (context, url) =>
            _loadingWidget(width: width, height: height, radius: borderRadius),
        errorWidget: (context, url, error) =>
            _loadingWidget(width: width, height: height, radius: borderRadius),
      ),
    );
  }

  static Widget profileAvatar(String imageUrl,
      {double? borderRadius = 0, BoxFit? fit = BoxFit
          .cover, double? width, double? height, EdgeInsets? margin, BoxShape? boxShape = BoxShape
          .rectangle}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) =>
            Container(
              decoration: BoxDecoration(
                shape: boxShape!,
                //borderRadius: BorderRadius.circular(borderRadius!),
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
            ),
        placeholder: (context, url) =>
            _loadingWidget(width: width, height: height, radius: borderRadius),
        errorWidget: (context, url, error) =>
            QuickActions.showSVGAsset("assets/svg/ic_avatar.svg"),
      ),
    );
  }

  static Widget profileCover(String imageUrl,
      {double? borderRadius = 0, BoxFit? fit = BoxFit
          .cover, double? width, double? height, EdgeInsets? margin}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) =>
            Container(
              decoration: BoxDecoration(
                //shape: boxShape!,
                borderRadius: BorderRadius.circular(borderRadius!),
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
            ),
        placeholder: (context, url) =>
            _loadingWidget(width: width, height: height, radius: borderRadius),
        errorWidget: (context, url, error) => Center(
          child: QuickActions.showSVGAsset("assets/svg/ic_avatar.svg"),),
      ),
    );
  }

  static Widget profileImage(String imageUPath,
      {double? borderRadius = 0, BoxFit? fit = BoxFit
          .cover, double? width, double? height, EdgeInsets? margin}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          //shape: boxShape!,
          borderRadius: BorderRadius.circular(borderRadius!),
          image: DecorationImage(image: AssetImage(imageUPath), fit: fit),
        ),
      ),
    );
  }


  static Widget _loadingWidget(
      {double? width, double? height, double? radius}) {

    /* return FadeShimmer(
      width: width != null ? width : 60,
      height: height != null ? height : 60,
      radius: radius != null ? radius : 0,
      fadeTheme: QuickHelp.isDarkModeNoContext() ? FadeTheme.dark : FadeTheme.light,
    );*/
    return Center(child: CircularProgressIndicator.adaptive());
  }


  static Widget noContentFound(String title, String explain, String image,
      {MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.center,
        CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center,
        double? imageWidth = 91,
        double? imageHeight = 91, Color? color}) {
    return Column(
      mainAxisAlignment: mainAxisAlignment!,
      crossAxisAlignment: crossAxisAlignment!,
      children: [
        ContainerCorner(
          height: imageHeight,
          width: imageWidth,
          marginBottom: 20,
          color: Colors.transparent,
          child: image.endsWith(".svg") ? QuickActions.showSVGAsset(
            image, color: color,) : Image.asset(image, color: color,),
        ),
        TextWithTap(
          title,
          marginBottom: 0,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
        TextWithTap(
          explain,
          marginLeft: 10,
          marginRight: 10,
          marginBottom: 17,
          marginTop: 5,
          fontSize: 18,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          color: AppColors.grey,
        )
      ],
    );
  }


  static Widget noContentFoundReels(String title, String explain,
      {MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.center,
        CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center,
        double? imageWidth = 91,
        double? imageHeight = 91}) {
    return Column(
      mainAxisAlignment: mainAxisAlignment!,
      crossAxisAlignment: crossAxisAlignment!,
      children: [
        ContainerCorner(
          height: imageHeight,
          width: imageWidth,
          marginBottom: 20,
          color: Colors.transparent,
          child: Icon(Icons.refresh_rounded, size: 90, color: Colors.white,),
        ),
        TextWithTap(
          title,
          marginBottom: 0,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        TextWithTap(
          explain,
          marginLeft: 10,
          marginRight: 10,
          marginBottom: 17,
          marginTop: 5,
          fontSize: 14,
          textAlign: TextAlign.center,
          color: Colors.white,
        )
      ],
    );
  }


  static createOrDeleteNotification(UserModel currentUser, UserModel toUser,
      String type, {PostsModel? post, LiveStreamingModel? live}) async {
    QueryBuilder<NotificationsModel> queryBuilder = QueryBuilder<
        NotificationsModel>(NotificationsModel());
    queryBuilder.whereEqualTo(NotificationsModel.keyAuthor, currentUser);
    queryBuilder.whereEqualTo(NotificationsModel.keyNotificationType, type);
    if (post != null) {
      queryBuilder.whereEqualTo(NotificationsModel.keyPost, post);
    }

    ParseResponse parseResponse = await queryBuilder.query();

    if (parseResponse.success) {
      if (parseResponse.results != null) {
        NotificationsModel notification = parseResponse.results!.first;
        await notification.delete();
      } else {
        NotificationsModel notificationsModel = NotificationsModel();
        notificationsModel.setAuthor = currentUser;
        notificationsModel.setAuthorId = currentUser.objectId!;

        notificationsModel.setReceiver = toUser;
        notificationsModel.setReceiverId = toUser.objectId!;

        notificationsModel.setNotificationType = type;
        notificationsModel.setRead = false;

        if (post != null) {
          notificationsModel.setPost = post;
        }

        if (live != null) {
          notificationsModel.setLive = live;
        }

        await notificationsModel.save();

        if (post != null) {
          if (post.getAuthorId != currentUser.objectId) {
            SendNotifications.sendPush(
                currentUser, toUser, type, objectId: post.objectId!);
          }
        } else if (live != null) {
          SendNotifications.sendPush(
              currentUser, toUser, type, objectId: live.objectId!);
        } else {
          SendNotifications.sendPush(currentUser, toUser, type);
        }
      }
    }
  }

  static Future<ParseResponse> report(
      {required String type, required String message, String? description, required UserModel accuser, required UserModel accused, LiveStreamingModel? liveStreamingModel, PostsModel? postsModel}) async {
    ReportModel reportModel = ReportModel();

    reportModel.setReportType = type;

    reportModel.setAccuser = accuser;
    reportModel.setAccuserId = accuser.objectId!;

    reportModel.setAccused = accused;
    reportModel.setAccusedId = accused.objectId!;

    if (liveStreamingModel != null)
      reportModel.setLiveStreaming = liveStreamingModel;
    if (postsModel != null) reportModel.setPost = postsModel;

    reportModel.setMessage = message;
    if (description != null) reportModel.setDescription = description;

    return await reportModel.save();
  }

  static Widget getVideoPlaceHolder(String url,
      {bool adaptive = false, bool showLoading = false}) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (ctx, value) {
        if (showLoading) {
          return adaptive
              ? CircularProgressIndicator.adaptive()
              : CircularProgressIndicator();
        } else {
          return Container();
        }
      },
    );
  }

  static Widget getImageFeed(BuildContext context, PostsModel post,
      {bool? cache = true}) {
    return SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: cache! ? CachedNetworkImage(
          imageUrl: post.isVideo!
              ? post.getVideoThumbnail!.url!
              : post.getImage!.url!,
          fit: BoxFit.contain,
          placeholder: (ctx, value) {
            return FadeShimmer(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .width,
              fadeTheme: QuickHelp.isDarkMode(context)
                  ? FadeTheme.dark
                  : FadeTheme.light,
            );
          },

        ) : Image.network(
          post.isVideo!
              ? post.getVideoThumbnail!.url!
              : post.getImage!.url!,
          fit: BoxFit.contain,
          loadingBuilder:
              (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFC107),
                  ),
                ),
              );
            } else {
              return child;
            }
          },
        )
    );
  }


  static Widget getVideoPlayer(PostsModel post) {
    return Container();
  }

  static Widget showSVGAsset(String asset,
      {Color? color, double? width, double? height, double? size}) {
    return SvgPicture.asset(
      asset,
      width: size != null ? size : width,
      height: size != null ? size : height,
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        color != null ? color : Colors.transparent,
        color != null ? BlendMode.srcIn : BlendMode.dst,
      ),
    );
  }

  static showSuccessPaymentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(
              // Set the colors for AlertDialogTheme
              dialogBackgroundColor: Colors.white,
              colorScheme: ColorScheme.light(
                primary: Colors.black, // Button text color
                onPrimary: Colors.white, // Button background color
              ),
            ),
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                height: 280,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animation/payment_success.json',
                      // Replace with your Lottie animation file
                      width: 100,
                      height: 100,
                      repeat: false,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Payment Complete!',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM Sans'
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Thank you for your purchase.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'DM Sans'
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          gradient: const LinearGradient (
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1),
                            colors: <Color>[
                              Color(0xff3d8ee1),
                              Color(0xff68c5e2)
                            ],
                            stops: <double>[0, 1],
                          ),
                        ),
                        child: Center(child: Text('OK', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DM Sans'
                        ),)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  static Future<void> showPaymentConfirmationSheet(BuildContext context,
      double fem, double ffem, Function() confirm,
      {bool subscription = false, bool byDiamond = false}) async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20 * fem), // Set the radius for the top border
        ),),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              return Container(
                padding: EdgeInsets.fromLTRB(
                    21 * fem, 21.26 * fem, 17 * fem, 12.14 * fem),
                width: 376 * fem,
                height: 284 * fem,
                child: Column(
                  children: [
                    Align(
                      child: SizedBox(
                        width: 154 * fem,
                        height: 24 * fem,
                        child: Text(
                          'Confirm Payment',
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.3333333333 * ffem / fem,
                            color: Color(0xff1e1e1e),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 39.24 * fem),

                    Row(
                      children: [
                        SizedBox(
                          height: 22 * fem,
                          child: Text(
                            !byDiamond ? 'Subscription' : 'Diamond',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.375 * ffem / fem,
                              color: Color(0xff8e9094),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Visibility(
                          visible: byDiamond != false,
                          child: Align(
                            child: SizedBox(
                              width: 21.82 * fem,
                              height: 16.2 * fem,
                              child: Opacity(
                                opacity: 0.9,
                                child: Image.asset(
                                  'assets/vip/gemstones.png',
                                  width: 21.82 * fem,
                                  height: 16.2 * fem,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3 * fem,),
                        Align(
                          child: SizedBox(
                            height: 22 * fem,
                            child: Text(
                              subscription
                                  ? byDiamond ? '300' : "7,99 \$"
                                  : '30',
                              style: SafeGoogleFont(
                                'DM Sans',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.375 * ffem / fem,
                                color: Color(0xff8e9094),
                              ),
                            ),
                          ),),


                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 12 * fem, 0, 20 * fem),
                      child: Row(
                        children: [
                          Align(
                            child: SizedBox(
                              width: 39 * fem,
                              height: 22 * fem,
                              child: Text(
                                'Total',
                                style: SafeGoogleFont(
                                  'DM Sans',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.375 * ffem / fem,
                                  color: Color(0xff1e1e1e),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Visibility(
                            visible: byDiamond != false,
                            child: Align(
                              child: SizedBox(
                                width: 21.82 * fem,
                                height: 16.2 * fem,
                                child: Opacity(
                                  opacity: 0.9,
                                  child: Image.asset(
                                    'assets/vip/gemstones.png',
                                    width: 21.82 * fem,
                                    height: 16.2 * fem,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3 * fem,),
                          Align(
                            child: SizedBox(
                              height: 22 * fem,
                              child: Text(
                                subscription
                                    ? byDiamond ? '300' : "7,99 \$"
                                    : '30',
                                style: SafeGoogleFont(
                                  'DM Sans',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.375 * ffem / fem,
                                  color: Color(0xff1e1e1e),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    InkWell(
                      onTap: confirm,
                      child: Container(
                        width: 325 * fem,
                        height: 48.59 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24 * fem),
                          gradient: LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1),
                            colors: <Color>[
                              Color(0xff3d8ee1),
                              Color(0xff68c5e2)
                            ],
                            stops: <double>[0.063, 0.938],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            subscription ? 'Confirm to pay' :
                            'Confirm to pay 0,99 \$ ',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.375 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.49 * fem,),
                    Container(
                      width: 325 * fem,
                      height: 48.59 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        borderRadius: BorderRadius.circular(24 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.375 * ffem / fem,
                            color: Color(0xff080808),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  static void showCongratulationsDialog(BuildContext context, double fem,
      double ffem,
      {String description = 'Your account is ready to use', Function()? onPressedDone}) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // contentPadding: EdgeInsets.zero,
          shape: const CircleBorder(
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(
                20 * fem, 40 * fem, 20 * fem, 0 * fem),
            width: 360 * fem,
            height: 482 * fem,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(24 * fem),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // dinoshy2LLV (1:4593)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, 32 * fem),
                  width: 212.73 * fem,
                  height: 180 * fem,
                  child: Image.asset(
                    'assets/dino/dino-shy.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // autolayoutvertical41b (1:4594)
                  margin: EdgeInsets.fromLTRB(
                      25 * fem, 0 * fem, 25 * fem, 31 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // congratulationsaEq (1:4595)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        child: Text(
                          'Congratulations!',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Urbanist',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.2000000477 * ffem / fem,
                          ),
                        ),
                      ),
                      Text(
                        // loremipsumdolorsitamethuaquilo (1:4596)
                        description,
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Urbanist',
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3999999364 * ffem / fem,
                          letterSpacing: 0.200000003 * fem,
                          color: Color(0xff212121),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onPressedDone ?? () {
                    QuickHelp.goBack(context);
                  },
                  child: Container(
                    // autolayoutverticalb9w (1:4597)
                    width: double.infinity,
                    height: 58 * fem,
                    child: Container(
                      // typebuttontype2primarytype3rou (1:4598)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 5 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      height: 58 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100 * fem),
                        gradient: const LinearGradient (
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                          colors: <Color>[
                            Color(0xff3d8ee1),
                            Color(0xff68c5e2)
                          ],
                          stops: <double>[0, 1],
                        ),
                      ),
                      child: Center(
                        child: Center(
                          child: Text(
                            'Done',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Urbanist',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.3999999762 * ffem / fem,
                              letterSpacing: 0.200000003 * fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
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


  static Widget myAvatar(double fem, double ffem, UserModel currentUser,
      {double height = 141, double width = 141, double padding = 16}) {
    return Visibility(
      visible: currentUser.getIsAvatarSelected == true,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "assets/avatar/avatarFrame${currentUser.getAvatarId}.png")
            )
        ),
        height: height * fem,
        width: width * fem,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(currentUser.getAvatar!.url!),
          ),
        ),
      ),
    );
  }


  static Future<void> privateKeyDialog(BuildContext context, double fem,
      double ffem, TextEditingController privateKeyController,
      Function() onCancel, Function() onContinue, {bool set = true}) async {
    RxString errorText = ''.obs;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // Dialog background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0 * fem),
          ),
          child: Container(
            height: 139 * fem,
            width: 325 * fem,
            // pop59A (1:4055)
            padding: EdgeInsets.fromLTRB(
                20 * fem, 20 * fem, 25 * fem, 20 * fem),
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(20 * fem),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // areyousureyouwanttodisconnecta (1:4057)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 6 * fem, 12 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 252 * fem,
                  ),
                  child: Text(
                    'Please ${set ? 'set' : 'enter'} the private key ${set
                        ? 'to proceed.'
                        : '.'}',
                    style: SafeGoogleFont(
                      'DM Sans',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: (18 / 14) * ffem / fem,
                      color: Color(0xff080808),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      // statusdefaulttypepasswordstate (1:1662)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          22.92 * fem, 0, 0 * fem, 0 * fem),
                      height: 34 * fem,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,

                        borderRadius: BorderRadius.circular(12 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconlyboldlockf9P (I1:1662;124:252)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 14.92 * fem, 0 * fem),
                            width: 14.17 * fem,
                            height: 16.67 * fem,
                            child: Image.asset(
                              'assets/dino/iconly-bold-lock.png',
                              width: 14.17 * fem,
                              height: 16.67 * fem,
                            ),
                          ),
                          Container(
                            height: 20 * fem,
                            width: 199 * fem,
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: TextFormField(
                              controller: privateKeyController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: false,
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  errorText.value = 'Private Key is required';
                                }
                                else if (value.length <= 6) {
                                  errorText.value =
                                  'Private Key should be 6+ characters';
                                }
                                else {
                                  errorText.value = '';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Private Key',
                                hintStyle: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4000000272 * ffem / fem,
                                  letterSpacing: 0.200000003 * fem,
                                  color: Color(0xff9e9e9e),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(
                                    0, 0, 0, 10.5 * fem),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.4000000272 * ffem / fem,
                                letterSpacing: 0.200000003 * fem,
                                color: Color(0xff9e9e9e),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    // SizedBox(height: 31-15*fem,)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12 * fem, 2, 0, 0),
                  child: Obx(() {
                    return Text(errorText.value, style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 10 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.4000000272 * ffem / fem,
                      letterSpacing: 0.200000003 * fem,
                      color: Colors.red.shade300,
                    ),);
                  }
                  ),
                ),

                Expanded(child: SizedBox()),
                Container(
                  // autogroupaibsGDe (L7zAR5omfoHPfurQJXAibS)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          privateKeyController.text = '';
                          errorText.value = '';
                          QuickHelp.goBack(context);
                        },
                        child: Container(
                          // cancelCNC (1:4058)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 38 * fem, 0 * fem),
                          child: Text(
                            'Cancel',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2857142857 * ffem / fem,
                              color: Color(0xff51B1EE),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (errorText.value.isNotEmpty) {
                            QuickHelp.showAppNotificationAdvanced(
                                title: errorText.value, context: context);
                          }
                          else if (privateKeyController.text == '') {
                            QuickHelp.showAppNotificationAdvanced(
                                title: "Private Key is required",
                                context: context);
                          }
                          else {
                            onContinue();
                          }
                        },
                        child: Text(
                          // confirmj7E (1:4059)
                          'Confirm',
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.2857142857 * ffem / fem,
                            color: Color(0xff51B1EE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> paidEntryDialog(BuildContext context, double fem,
      double ffem, TextEditingController diamondEntryController,
      Function() onCancel, Function() onContinue, {bool set = true}) async {
    RxString errorText = ''.obs;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // Dialog background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0 * fem),
          ),
          child: Container(
            height: 170 * fem,
            width: 325 * fem,
            // pop59A (1:4055)
            padding: EdgeInsets.fromLTRB(20 * fem, 20 * fem, 18 * fem, 0 * fem),
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(20 * fem),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // areyousureyouwanttodisconnecta (1:4057)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 6 * fem, 14 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 252 * fem,
                  ),
                  child: Text(
                    'Please specify the diamond amount required for users to access the live streaming.',
                    style: SafeGoogleFont(
                      'DM Sans',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: (18 / 14) * ffem / fem,
                      color: Color(0xff080808),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      // statusdefaulttypepasswordstate (1:1662)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          22.92 - 12 * fem, 0, 0 * fem, 0 * fem),
                      height: 34 * fem,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,

                        borderRadius: BorderRadius.circular(12 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconlyboldlockf9P (I1:1662;124:252)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 14.92 - 4 * fem, 1.5 * fem),
                            width: 31.14 * fem,
                            height: 31.14 * fem,
                            child: Image.asset(
                              'assets/livestreaming/diamond.png',
                              fit: BoxFit.cover,
                              width: 31.14 * fem,
                              height: 31.14 * fem,
                            ),
                          ),
                          Container(
                            height: 20 * fem,
                            width: 199 * fem,
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: TextFormField(
                              controller: diamondEntryController,
                              keyboardType: TextInputType.numberWithOptions(),
                              obscureText: false,
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  errorText.value = 'Amount is required';
                                }
                                else if (value == '0') {
                                  errorText.value =
                                  'Amount should be greater than zero';
                                }
                                else {
                                  errorText.value = '';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4000000272 * ffem / fem,
                                  letterSpacing: 0.200000003 * fem,
                                  color: Color(0xff9e9e9e),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(
                                    0, 0, 0, 10.5 * fem),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.4000000272 * ffem / fem,
                                letterSpacing: 0.200000003 * fem,
                                color: Color(0xff9e9e9e),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    // SizedBox(height: 31-15*fem,)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12 * fem, 2, 0, 0),
                  child: Obx(() {
                    return Text(errorText.value, style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 10 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.4000000272 * ffem / fem,
                      letterSpacing: 0.200000003 * fem,
                      color: Colors.red.shade300,
                    ),);
                  }
                  ),
                ),

                Expanded(child: SizedBox()),
                Container(
                  // autogroupaibsGDe (L7zAR5omfoHPfurQJXAibS)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, 15 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          diamondEntryController.text = '';
                          errorText.value = '';
                          QuickHelp.goBack(context);
                        },
                        child: Container(
                          // cancelCNC (1:4058)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 38 * fem, 0 * fem),
                          child: Text(
                            'Cancel',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2857142857 * ffem / fem,
                              color: Color(0xff51B1EE),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (errorText.value.isNotEmpty) {
                            QuickHelp.showAppNotificationAdvanced(
                                title: errorText.value, context: context);
                          }
                          else if (diamondEntryController.text == '') {
                            QuickHelp.showAppNotificationAdvanced(
                                title: "Private Key is required",
                                context: context);
                          }
                          else {
                            onContinue();
                          }
                        },
                        child: Text(
                          // confirmj7E (1:4059)
                          'Confirm',
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.2857142857 * ffem / fem,
                            color: Color(0xff51B1EE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static Future<void> confirmPaymentDialog(BuildContext context, double fem,
      double ffem, int amount, Function() onContinue) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // Dialog background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0 * fem),
          ),
          child: Container(
            height: 170 * fem,
            width: 325 * fem,
            // pop59A (1:4055)
            padding: EdgeInsets.fromLTRB(
                20 * fem, 20 * fem, 25 * fem, 19 * fem),
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(20 * fem),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  // areyousureyouwanttodisconnecta (1:4057)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 6 * fem, 36 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 252 * fem,
                  ),
                  child: Text(
                    'The broadcaster has set the price at $amount diamonds to access the live streaming. Are you sure you want to make the payment?',
                    style: SafeGoogleFont(
                      'DM Sans',
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.375 * ffem / fem,
                      color: Color(0xff080808),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  // autogroupaibsGDe (L7zAR5omfoHPfurQJXAibS)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          QuickHelp.goBack(context);
                        },
                        child: Container(
                          // cancelCNC (1:4058)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 38 * fem, 0 * fem),
                          child: Text(
                            'Cancel',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2857142857 * ffem / fem,
                              color: Color(0xff51B1EE),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onContinue,
                        child: Text(
                          // confirmj7E (1:4059)
                          'Confirm',
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.2857142857 * ffem / fem,
                            color: Color(0xff51B1EE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static Widget myWishBroadcasterWidget(double fem, double ffem,
      BuildContext context, UserModel currentUser,
      LiveStreamingModel liveStreamingModel,
      {double? bottom, double? right, double? top, double? left}) {
    return Positioned(
      left: right == null ? left ?? 7 * fem : null,
      top: bottom == null ? top ?? 148 * fem : null,
      bottom: bottom == null ? null : bottom,
      right: right == null ? null : right,
      child: InkWell(
        onTap: () {
          QuickActions.myWishListBroadcaster(
              fem, ffem, context, liveStreamingModel);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(1 * fem, 7 * fem, 3.06 * fem, 3 * fem),
          width: 102.06 * fem,
          height: 41 * fem,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10 * fem),
            gradient: const LinearGradient (
              begin: Alignment(0.352, -0.415),
              end: Alignment(-0.961, 0.098),
              colors: <Color>[Color(0xffff4084), Color(0xff403ebd)],
              stops: <double>[0, 0.878],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x3f6949ff),
                offset: Offset(4 * fem, 8 * fem),
                blurRadius: 12 * fem,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // ZbD (1:24747)
                margin: EdgeInsets.fromLTRB(
                    0 * fem, 0 * fem, 11.13 * fem, 6.43 * fem),
                width: 38.87 * fem,
                height: 24.57 * fem,
                child: Image.asset(
                  'assets/dino/-qZZ.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                // autogroup9rfvR7d (7eFXi4RUnikRuu2otf9RfV)
                margin: EdgeInsets.fromLTRB(0 * fem, 2 * fem, 0 * fem, 0 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // wishlistt1D (1:24748)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 1 * fem),
                      child: Text(
                        'Wish List',
                        style: SafeGoogleFont(
                          'Fredoka One',
                          fontSize: 11 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2727272727 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    RichText(
                      // addKsD (1:24749)
                      text: TextSpan(
                        style: SafeGoogleFont(
                          'DM Sans',
                          fontSize: 10 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.4 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                        children: [
                          TextSpan(
                            text: 'Add ',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.4 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                          TextSpan(
                            text: '>',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.4 * ffem / fem,
                              color: Color(0xffffffff),
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
    );
  }

  static Widget myWishAudienceWidget(double fem, double ffem,
      BuildContext context, UserModel broadcasterModel, UserModel currentUser,
      LiveStreamingModel liveStreamingModel,
      {double? bottom, double? right, double? top, double? left}) {
    return Positioned(
      left: right == null ? left ?? 10 * fem : null,
      top: bottom == null ? top ?? 148 * fem : null,
      bottom: bottom == null ? null : bottom,
      right: right == null ? null : right,
      child: Visibility(
        visible: liveStreamingModel.getMyWishList != null &&
            liveStreamingModel.getMyWishList!.length > 0,
        child: InkWell(
          onTap: () {
            myWishListAudience(
                fem, ffem, context, broadcasterModel, currentUser,
                liveStreamingModel);
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(1 * fem, 7 * fem, 7.06 * fem, 6 * fem),
            width: 102.06 * fem,
            height: 41 * fem,
            decoration: BoxDecoration(
              color: Color(0x42000000),
              borderRadius: BorderRadius.circular(10 * fem),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3f6949ff),
                  offset: Offset(4 * fem, 8 * fem),
                  blurRadius: 12 * fem,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // 5Qb (1:23872)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 3.13 * fem, 0.43 * fem),
                  width: 38.87 * fem,
                  height: 24.57 * fem,
                  child: Image.asset(
                    'assets/dino/-qZZ.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // autogroupi9v97s5 (7eFQhgGHFq6p5c1Uivi9V9)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 4 * fem, 0 * fem, 0 * fem),
                  width: 52 * fem,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // wishlistQLP (1:23873)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 4.5 * fem),
                        child: Text(
                          'Wish List',
                          style: SafeGoogleFont(
                            'Fredoka One',
                            fontSize: 11 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2727272727 * ffem / fem,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 48 * fem, // 52% of screen width
                      //   height: 4 * fem, // 4% of screen height
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(14 * fem),
                      //     // 14% of screen width
                      //     color: Color(0xFF777777), // Background color
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(14 * fem),
                      //     // 14% of screen width
                      //     // child: LinearProgressIndicator(
                      //     //   value: QuickActions.wishListProgressValue(
                      //     //       liveStreamingModel),
                      //       // Change this value to set the progress
                      //       backgroundColor: Colors.transparent,
                      //       valueColor: AlwaysStoppedAnimation<Color>(
                      //           Color(0xFFFFBD2B)), // Active color
                      //     ),
                      //   ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static double wishListProgressValue(LiveViewModel liveViewModel) {
    double totalReceived = 0.0;
    double totalAmount = 0.0;
    if (liveViewModel.myWishList != null && liveViewModel.myWishList!.isNotEmpty) {
      for (int i = 0; i < liveViewModel.myWishList!.length; i++) {
        totalReceived = totalReceived + double.parse(
            liveViewModel.myWishList![i][LiveStreamingModel
                .keyReceived].toString());
        totalAmount = totalAmount + double.parse(
            liveViewModel.myWishList![i][LiveStreamingModel.keyAmount].toString());
      }
      return (totalReceived / totalAmount);
    }
    else {
      return 0;
    }
  }

  static myWishListAudience(double fem, double ffem, BuildContext context,
      UserModel broadcasterModel, UserModel currentUser,
      LiveStreamingModel liveStreamingModel) {
    List wishList = liveStreamingModel.getMyWishList ?? [];
    ;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20 * fem), // Set the radius for the top border
        ),),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              return Container(
                width: 377 * fem,
                height: 613 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      // overlay3iT1 (1:24789)
                      left: 0 * fem,
                      top: 3 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 376 * fem,
                          height: 610 * fem,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1 * fem),
                              color: Color(0xff1d1927),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // overlay3ZNf (1:24868)
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 377 * fem,
                          height: 113 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13 * fem),
                            child: Image.asset(
                              'assets/dino/overlay-3-5af.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // baggagexvb (1:24869)
                      left: 176 * fem,
                      top: 23.677734375 * fem,
                      child: Container(
                        width: 26 * fem,
                        height: 22.4 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21 * fem),
                        ),
                        child: Container(
                          // frame395Sas (1:24870)
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21 * fem),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // top10B2f (1:24871)
                      left: 23 * fem,
                      top: 73.9736843109 * fem,
                      child: Container(
                        width: 343 * fem,
                        height: 46.03 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11 * fem),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              // btnbgbs5 (1:24872)
                              left: 0 * fem,
                              top: 12.0263156891 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 343 * fem,
                                  height: 34 * fem,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          11 * fem),
                                      color: Color(0x632a2634),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // jeanettekingUAB (1:24873)
                              left: 4 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  height: 42 * fem,
                                  child: Text(
                                    'Broadcasters Wish List. Help achieve the wishes And surprise\nthe broadcaster! ',
                                    style: SafeGoogleFont(
                                      'DM Sans',
                                      fontSize: 11 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2727272727 * ffem / fem,
                                      color: Color(0xffffbd2b),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // group52970aMd (1:24874)
                      left: 21 * fem,
                      top: 128.87890625 * fem,
                      child: Container(
                        height: 550 * fem,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: EdgeInsets.fromLTRB(0, 0, 32.42 * fem, 34.42),
                        child: GridView.builder(
                            padding: EdgeInsets.fromLTRB(0, 0, 0 * fem,
                                85 * fem),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Adjust as needed
                              mainAxisSpacing: 14.64 * fem,
                              crossAxisSpacing: 12 * fem,
                              childAspectRatio: 0.75, // Adjust this ratio to fit your needs
                            ),
                            itemCount: wishList.length,
                            // Set itemCount to the number of items you have
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.fromLTRB(
                                    9 * fem, 2.12 * fem, 9.58 * fem,
                                    3.46 * fem),
                                width: 106.58 * fem,
                                height: 140.58 * fem,
                                decoration: BoxDecoration(
                                  color: const Color(0xff2a2634),
                                  borderRadius: BorderRadius.circular(5 * fem),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3f000000),
                                      offset: Offset(0 * fem, 4 * fem),
                                      blurRadius: 2 * fem,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // autogrouphvvswbV (7eFgctQec6BEVdVmBtHvvs)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                                      width: double.infinity,
                                      height: 88 * fem,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // contentEKh (1:24877)
                                            left: 23 * fem,
                                            top: 54 * fem,
                                            child: Container(
                                              width: 38 * fem,
                                              height: 30.21 * fem,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Container(
                                                    // aeroplanegBh (1:24879)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem, 0 * fem,
                                                        0 * fem, 2.21 * fem),
                                                    child: Text(
                                                      'Aeroplane',
                                                      style: SafeGoogleFont(
                                                        'DM Sans',
                                                        fontSize: 8 * ffem,
                                                        fontWeight: FontWeight
                                                            .w400,
                                                        height: 1.75 * ffem /
                                                            fem,
                                                        color: Color(
                                                            0xff9e9e9e),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // autogroupuem5ZFV (7eFgky1X8brT3gBujfUeM5)
                                                    margin: EdgeInsets.fromLTRB(
                                                        7 * fem, 0 * fem,
                                                        10 * fem, 0 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Opacity(
                                                          // gemstones4CF (1:24880)
                                                          opacity: 0.9,
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                0 * fem,
                                                                1.19 * fem,
                                                                2.73 * fem,
                                                                0 * fem),
                                                            width: 12.27 * fem,
                                                            height: 9 * fem,
                                                            child: Image.asset(
                                                              'assets/dino/gemstones.png',
                                                              width: 12.27 *
                                                                  fem,
                                                              height: 9 * fem,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          // fbM (1:24878)
                                                          '3',
                                                          style: SafeGoogleFont(
                                                            'DM Sans',
                                                            fontSize: 10 * ffem,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            height: 1.4 * ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff9e9e9e),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // wYs (1:24881)
                                            left: 11 * fem,
                                            top: 0 * fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 56.12 * fem,
                                                height: 56.12 * fem,
                                                child: Image.asset(
                                                  "assets/dino/${wishList[index][LiveStreamingModel
                                                      .keyName]}.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // progbarDuZ (1:24907)
                                            left: 0 * fem,
                                            top: 83 * fem,
                                            child: Align(
                                              child: Container(
                                                width: 88 * fem,
                                                height: 5 * fem,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(14 * fem),
                                                  border: Border.all(
                                                      color: Color(0xff50b0ed),
                                                      width: 1),
                                                ),
                                                child: LinearProgressIndicator( //audience
                                                  backgroundColor: Color(
                                                      0xff777777),
                                                  valueColor: AlwaysStoppedAnimation<
                                                      Color>(Color(0xff50b0ed)),
                                                  value: double.parse(
                                                      wishList[index][LiveStreamingModel
                                                          .keyReceived]) /
                                                      double.parse(
                                                          wishList[index][LiveStreamingModel
                                                              .keyAmount]), // Set the value of the progress bar (between 0.0 and 1.0)
                                                  // Set the progress value here (0.0 to 1.0)
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Positioned(
                                          //   // progbarP9y (1:24882)
                                          //   left: 0*fem,
                                          //   top: 83*fem,
                                          //   child: Align(
                                          //     child: SizedBox(
                                          //       width: 88*fem,
                                          //       height: 5*fem,
                                          //       child: Image.asset(
                                          //         'assets/dino/prog-bar-UUF.png',
                                          //         width: 88*fem,
                                          //         height: 5*fem,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // buttonWh5 (1:24897)
                                      margin: EdgeInsets.fromLTRB(int.parse(
                                          wishList[index][LiveStreamingModel
                                              .keyAmount]) <= int.parse(
                                          wishList[index][LiveStreamingModel
                                              .keyReceived]) ? 5 * fem : 18 *
                                          fem, 0 * fem, int.parse(
                                          wishList[index][LiveStreamingModel
                                              .keyAmount]) <= int.parse(
                                          wishList[index][LiveStreamingModel
                                              .keyReceived]) ? 0 : 24.47 * fem,
                                          0 * fem),
                                      width: double.infinity,
                                      height: 22 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            24 * fem),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // btnbgBoD (1:24898)
                                            left: 0 * fem,
                                            top: 2 * fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: int.parse(
                                                    wishList[index][LiveStreamingModel
                                                        .keyAmount]) <=
                                                    int.parse(
                                                        wishList[index][LiveStreamingModel
                                                            .keyReceived])
                                                    ? 45.53 + 30 * fem
                                                    : 45.53 * fem,
                                                height: 18 * fem,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(24 * fem),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xff50b0ed)),
                                                    gradient: const LinearGradient (
                                                      begin: Alignment(0, -1),
                                                      end: Alignment(0, 1),
                                                      colors: <Color>[Color(
                                                          0xff3d8ee1), Color(
                                                          0xff68c5e2)
                                                      ],
                                                      stops: <double>[0, 1],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // signuploginwithphone97m (1:24899)
                                            left: 10.6470537186 * fem,
                                            top: 0 * fem,
                                            child: Align(
                                              child: InkWell(
                                                onTap: () {
                                                  if (currentUser
                                                      .getDiamondsTotal! >= 3) {
                                                    if (int.parse(
                                                        wishList[index][LiveStreamingModel
                                                            .keyAmount]) !=
                                                        int.parse(
                                                            wishList[index][LiveStreamingModel
                                                                .keyReceived])) {
                                                      Map<String,
                                                          dynamic> item = {
                                                        LiveStreamingModel
                                                            .keyName: wishList[index][LiveStreamingModel
                                                            .keyName],
                                                        LiveStreamingModel
                                                            .keyAmount: wishList[index][LiveStreamingModel
                                                            .keyAmount],
                                                        LiveStreamingModel
                                                            .keyReceived: (int
                                                            .parse(
                                                            wishList[index][LiveStreamingModel
                                                                .keyReceived]) +
                                                            1).toString(),
                                                      };
                                                      wishList[index] = item;
                                                      setModalState(() {});
                                                      liveStreamingModel
                                                          .setMyWishWholeList =
                                                          wishList;
                                                      liveStreamingModel
                                                          .addDiamonds = 3;
                                                      liveStreamingModel
                                                          .save().then((value) {
                                                        currentUser
                                                            .decrementDiamondsTotal =
                                                        3;

                                                        currentUser.save();
                                                      });
                                                      // });
                                                    }
                                                  }
                                                  else {
                                                    QuickHelp
                                                        .showAppNotificationAdvanced(
                                                        title: 'Insufficient diamonds!',
                                                        context: context);
                                                  }
                                                },
                                                child: SizedBox(
                                                  width: int.parse(
                                                      wishList[index][LiveStreamingModel
                                                          .keyAmount]) <=
                                                      int.parse(
                                                          wishList[index][LiveStreamingModel
                                                              .keyReceived])
                                                      ? 25 + 30
                                                      : 25 * fem,
                                                  height: 22 * fem,
                                                  child: Text(
                                                    int.parse(
                                                        wishList[index][LiveStreamingModel
                                                            .keyAmount]) <=
                                                        int.parse(
                                                            wishList[index][LiveStreamingModel
                                                                .keyReceived])
                                                        ? 'Completed'
                                                        : 'Send',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'DM Sans',
                                                      fontSize: 10 * ffem,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      height: 2.2 * ffem / fem,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        // WQw (1:24876)
                                        margin: EdgeInsets.fromLTRB(
                                            3 * fem, 0 * fem, 9 * fem, 0 * fem),
                                        child: Text(
                                          '${wishList[index][LiveStreamingModel
                                              .keyReceived]}/${wishList[index][LiveStreamingModel
                                              .keyAmount]}',
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 10 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.4 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    ),

                    Positioned(
                      // topuserleftEtX (1:24913)
                      left: 72 * fem,
                      top: 17 * fem,
                      child: Container(
                        width: 239 * fem,
                        height: 39.12 * fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // bgW5M (1:24914)
                              left: 0 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 239 * fem,
                                  height: 36 * fem,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          18 * fem),
                                      color: Color(0x3f000000),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // userwAf (1:24915)
                              left: 1.8515625 * fem,
                              top: 0.1427307129 * fem,
                              child: Container(
                                width: 38.58 * fem,
                                height: 38.98 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // ovalcnb (1:24916)
                                      left: 3.4340820312 * fem,
                                      top: 1.8572692871 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 31.71 * fem,
                                          height: 30 * fem,
                                          child: Image.network(
                                            broadcasterModel.getAvatar!.url!,
                                            width: 31.71 * fem,
                                            height: 30 * fem,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // levelbadges205RH (1:24917)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 38.58 * fem,
                                          height: 38.98 * fem,
                                          child: Image.asset(
                                            'assets/dino/level-badges-20-9Fu.png',
                                            width: 38.58 * fem,
                                            height: 38.98 * fem,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              // frame31JJ3 (1:24921)
                              left: 41.5 * fem,
                              top: 10 * fem,
                              child: Row(
                                children: [
                                  Container(
                                    height: 25 * fem,
                                    child: Text(
                                      broadcasterModel.getFullName!,
                                      style: SafeGoogleFont(
                                        'DM Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.1666666667 * ffem / fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5 * fem),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: SizedBox(
                                      height: 14 * fem,
                                      child: Text(
                                        ' Wish List',
                                        style: SafeGoogleFont(
                                          'DM Sans',
                                          fontSize: 19 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 0.7368421053 * ffem / fem,
                                          color: Color(0xffffffff),
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
                ),
              );
            });
      },
    );
  }

  static myWishListBroadcaster(double fem, double ffem, BuildContext context,
      LiveStreamingModel liveStreamingModel) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(20*fem), // Set the radius for the top border
      //   ),),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              List wishItems = liveStreamingModel.getMyWishList ?? [];

              int length;

              if (liveStreamingModel.getMyWishList != null) {
                length = liveStreamingModel.getMyWishList!.length + 1;
              }
              else {
                length = 1;
              }

              int diamondWorth = 0;
              int temp = 0;

              for (int i = 0; i < wishItems.length; i++) {
                temp = temp +
                    (int.parse(wishItems[i][LiveStreamingModel.keyAmount]) * 3);
                if (i == (wishItems.length - 1)) {
                  diamondWorth = temp;
                }
              }


              return Container(
                width: 377.65 * fem,
                height: 613 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      // overlay3Tao (1:19970)
                      left: 0 * fem,
                      top: 3 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 376 * fem,
                          height: 610 * fem,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14 * fem),
                              color: Color(0xff1d1927),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // contentxXZ (1:19971)
                      left: 93 * fem,
                      top: 584 * fem,
                      child: Container(
                        width: 171 * fem,
                        height: 14 * fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // aeroplaneVGb (1:19972)
                              left: 0 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 157 * fem,
                                  height: 14 * fem,
                                  child: Text(
                                    'You have added ${wishItems
                                        .length} gifts worth ',
                                    style: SafeGoogleFont(
                                      'DM Sans',
                                      fontSize: 11 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2727272727 * ffem / fem,
                                      color: Color(0xff9e9e9e),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // gemstonesAtX (1:19973)
                              left: 156 * fem,
                              top: 3 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 15 * fem,
                                  height: 11 * fem,
                                  child: Opacity(
                                    opacity: 0.9,
                                    child: Image.asset(
                                      AppImagePath.coinsIcon,
                                      width: 15 * fem,
                                      height: 11 * fem,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // overlay39kT (1:19974)
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 377 * fem,
                          height: 113 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13 * fem),
                            child: Image.asset(
                              'assets/png/overlay.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // giftsvectorTFM (1:19975)
                      left: 110 * fem,
                      top: 249.4127960205 * fem,
                      child: Container(
                        width: 62.26 * fem,
                        height: 142.4 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21 * fem),
                        ),
                      ),
                    ),
                    Positioned(
                      // baggageBh9 (1:19976)
                      left: 176 * fem,
                      top: 23.6778869629 * fem,
                      child: Container(
                        width: 26 * fem,
                        height: 22.4 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21 * fem),
                        ),
                        child: Container(
                          // frame395ut3 (1:19977)
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21 * fem),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // top104kw (1:19978)
                      left: 30 * fem,
                      top: 75 * fem,
                      child: Container(
                        width: 355.65 * fem,
                        height: 34 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11 * fem),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              // btnbgmvF (1:19979)
                              left: 0 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 335 * fem,
                                  height: 34 * fem,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          11 * fem),
                                      color: Color(0x632a2634),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // jeanettekingVbM (1:19980)
                              left: 26 * fem,
                              top: 12.0596218109 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 300 * fem,
                                  height: 14 * fem,
                                  child: Text(
                                    ' Make a Wish And your Audience will help you Achieve it ',
                                    style: SafeGoogleFont(
                                      'DM Sans',
                                      fontSize: 11 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2727272727 * ffem / fem,
                                      color: Color(0xffffbd2b),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // asset154x1Byy (1:20000)
                              left: 6 * fem,
                              top: 8 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 12.55 * fem,
                                  height: 19.71 * fem,
                                  child: Image.asset(
                                    'assets/png/zee',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // group52970K4b (1:19981)
                      left: 21 * fem,
                      right: 15 * fem,
                      top: 128 * fem,
                      child: Container(
                        height: 420 * fem,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: GridView.builder(
                          padding: EdgeInsets.only(bottom: 10 * fem),
                          itemCount: length,
                          shrinkWrap: true,
                          // Provide the number of items in your grid
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.75,
                            // Set the number of columns
                            crossAxisSpacing: 12.42 * fem,
                            // Set spacing between columns
                            mainAxisSpacing: 12 *
                                fem, // Set spacing between rows
                          ),
                          itemBuilder: (context, index) {
                            return index != (length - 1) ? SizedBox(
                              width: 106.58 * fem,
                              height: 141.46 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // bg2jh (1:19982)
                                    left: 0 * fem,
                                    top: 0.879119873 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 106.58 * fem,
                                        height: 140.58 * fem,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                5 * fem),
                                            color: const Color(0xff2a2634),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x3f000000),
                                                offset: Offset(
                                                    0 * fem, 4 * fem),
                                                blurRadius: 2 * fem,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // Wes (1:19983)
                                    left: 47 * fem,
                                    top: 124 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        height: 14 * fem,
                                        child: Text(
                                          '${wishItems[index][LiveStreamingModel
                                              .keyReceived]}/${wishItems[index][LiveStreamingModel
                                              .keyAmount].toString()}',
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 10 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.4 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // contentDpB (1:19984)
                                    left: 32 * fem,
                                    top: 77 * fem,
                                    child: Container(
                                      width: 47 * fem,
                                      height: 30.21 * fem,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            // aeroplanek3R (1:19986)
                                            margin: EdgeInsets.fromLTRB(
                                                0 * fem, 0 * fem, 0 * fem,
                                                2.21 * fem),
                                            child: Text(
                                              'Aeroplane',
                                              style: SafeGoogleFont(
                                                'DM Sans',
                                                fontSize: 10 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.4 * ffem / fem,
                                                color: Color(0xff9e9e9e),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // autogroupn38kGGf (7eF653eDaHGCHHwZTbN38K)
                                            margin: EdgeInsets.fromLTRB(
                                                7 * fem, 0 * fem, 14 * fem,
                                                0 * fem),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Opacity(
                                                  // gemstoneszTZ (1:19987)
                                                  opacity: 0.9,
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem, 0 * fem,
                                                        5 * fem, 0.63 * fem),
                                                    width: 15 * fem,
                                                    height: 11 * fem,
                                                    child: Image.asset(
                                                      AppImagePath.coinsIcon,
                                                      width: 15 * fem,
                                                      height: 11 * fem,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  // Pkb (1:19985)
                                                  '3',
                                                  style: SafeGoogleFont(
                                                    'DM Sans',
                                                    fontSize: 10 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.4 * ffem / fem,
                                                    color: Color(0xff9e9e9e),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // 9Dy (1:19988)
                                    left: 17 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 76.12 * fem,
                                        height: 76.12 * fem,
                                        child: Image.asset(
                                          'assets/dino/${wishItems[index][LiveStreamingModel
                                              .keyName]}.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // progbarreB (1:19989)
                                    left: 9 * fem,
                                    top: 112 * fem,
                                    child: SizedBox(
                                      width: 88 * fem,
                                      height: 5 * fem,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              14 * fem),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              14 * fem),
                                          child: LinearProgressIndicator(
                                            backgroundColor: Color(0xff777777),
                                            // Background color of the progress bar
                                            valueColor: AlwaysStoppedAnimation<
                                                Color>(Color(0xff50b0ed)),
                                            // Color of the progress indicator
                                            value: double.parse(
                                                wishItems[index][LiveStreamingModel
                                                    .keyReceived]) /
                                                double.parse(
                                                    wishItems[index][LiveStreamingModel
                                                        .keyAmount]), // Set the value of the progress bar (between 0.0 and 1.0)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    // iccross74K (1:19995)
                                    left: 86 * fem,
                                    top: 5 * fem,
                                    child: InkWell(
                                      onTap: () {
                                        liveStreamingModel.removeMyWishList =
                                        wishItems[index];
                                        liveStreamingModel.save();
                                        wishItems.removeAt(index);
                                        length = length - 1;
                                        setModalState(() {});
                                      },
                                      child: Align(
                                        child: SizedBox(
                                          width: 14 * fem,
                                          height: 14 * fem,
                                          child: Image.asset(
                                            'assets/dino/iccross.png',
                                            width: 14 * fem,
                                            height: 14 * fem,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ) :
                            InkWell(
                              onTap: () {
                                QuickActions.myWishListOptionsBroadcaster(
                                    fem, ffem, context, liveStreamingModel)
                                    .then((value) => setModalState(() {}));
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    27 * fem, 52.45 * fem, 22.58 * fem,
                                    44.13 * fem),
                                width: 106.58 * fem,
                                height: 140.58 * fem,
                                decoration: BoxDecoration(
                                  color: Color(0xff2a2634),
                                  borderRadius: BorderRadius.circular(5 * fem),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3f000000),
                                      offset: Offset(0 * fem, 4 * fem),
                                      blurRadius: 2 * fem,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // signuploginwithphoneGbR (1:19992)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 3 * fem, 8 * fem),
                                      child: Text(
                                        '+ ',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'DM Sans',
                                          fontSize: 41 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 0.5365853659 * ffem / fem,
                                          color: Color(0xff777777),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      // aeroplaneNuM (1:19993)
                                      'Add wishes',
                                      style: SafeGoogleFont(
                                        'DM Sans',
                                        fontSize: 10 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.4 * ffem / fem,
                                        color: Color(0xff9e9e9e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),),
                    Positioned(
                      // button87q (I1:19994;0:15783)
                      left: 21 * fem,
                      top: 529 * fem,
                      child: InkWell(
                        onTap: () {
                          QuickHelp.goBack(context);
                          QuickHelp.showAppNotification(
                              title: "Items Published Successfully!",
                              context: context,
                              isError: false);
                        },
                        child: Container(
                          width: 337 * fem,
                          height: 49 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff50b0ed)),
                            borderRadius: BorderRadius.circular(24 * fem),
                            gradient: LinearGradient(
                              begin: Alignment(0, -1),
                              end: Alignment(0, 1),
                              colors: <Color>[
                                Color(0xff3d8ee1),
                                Color(0xff68c5e2)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Publish',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'DM Sans',
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // jeanetteking8X9 (1:19998)
                      left: 123 * fem,
                      top: 25 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 118 * fem,
                          height: 14 * fem,
                          child: Text(
                            'My Wish List',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 19 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 0.7368421053 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // aeroplanedD1 (1:19999)
                      left: 265 * fem,
                      top: 585 * fem,
                      child: Align(
                        child: SizedBox(
                          height: 14 * fem,
                          child: Text(
                            '$diamondWorth',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.4 * ffem / fem,
                              color: Color(0xff9e9e9e),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }


  static Future myWishListOptionsBroadcaster(double fem, double ffem,
      BuildContext context, LiveStreamingModel liveStreamingModel) {
    int selected = -1;
    int amount = 1;
    String category = 'popular';
    List images = [AppImagePath.lamborghini, AppImagePath.bearCastle , AppImagePath.yachtIsland,
      AppImagePath.babyDragon, AppImagePath.hearts, AppImagePath.kissingGift , AppImagePath.motorCycleEntry ];

    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20 * fem), // Set the radius for the top border
        ),),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              return SizedBox(
                width: 555 * fem,
                height: 535 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 376 * fem,
                      height: 73 * fem,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(
                              25 * fem, 2 * fem, 19.27 * fem, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff777777)),
                            color: const Color(0xff2a2634),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20 * fem),
                              topRight: Radius.circular(20 * fem),
                              bottomRight: Radius.circular(1 * fem),
                              bottomLeft: Radius.circular(1 * fem),
                            ),
                          ),
                          child: Row(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 20 * fem,
                                    height: 20 * fem,
                                    child: Image.asset(
                                      'assets/dino/icons-d2o.png',
                                      width: 20 * fem,
                                      height: 20 * fem,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10 * fem),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: SizedBox(
                                      width: 211 * fem,
                                      height: 25 * fem,
                                      child: Center(
                                        child: Text(
                                          'Select gifts and amount',
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 0.7777777778 * ffem / fem,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                InkWell(
                                  onTap: () {
                                    String name;
                                    if (selected == 0) {
                                      name = 'heart';
                                    }
                                    else if (selected == 1) {
                                      name = 'cake';
                                    }
                                    else if (selected == 2) {
                                      name = 'car';
                                    }
                                    else if (selected == 3) {
                                      name = 'parachute';
                                    }
                                    else if (selected == 4) {
                                      name = 'play';
                                    }
                                    else {
                                      name = 'castle';
                                    }

                                    if (selected != -1) {
                                      Map<String, dynamic> item = {
                                        LiveStreamingModel.keyAmount: amount
                                            .toString(),
                                        LiveStreamingModel.keyReceived: "0",
                                        LiveStreamingModel.keyName: name,
                                      };
                                      liveStreamingModel.setMyWishList = item;
                                      liveStreamingModel.save().then((value) =>
                                          QuickHelp.goBack(context));
                                    }
                                    else {
                                      QuickHelp.goBack(context);
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 66.73 * fem,
                                      height: 30 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff50b0ed)),
                                        borderRadius: BorderRadius.circular(
                                            24 * fem),
                                        gradient: const LinearGradient (
                                          begin: Alignment(0, -1),
                                          end: Alignment(0, 1),
                                          colors: <Color>[
                                            Color(0xff3d8ee1),
                                            Color(0xff68c5e2)
                                          ],
                                          stops: <double>[0, 1],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Done',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.4666666667 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            4 * fem, 0 * fem, 0 * fem, 33 - 13 * fem),
                        width: 555 * fem,
                        height: 555 - 44.81 * fem,
                        decoration: const BoxDecoration (
                          color: Color(0xff1d1927),
                          // borderRadius: BorderRadius.circular(14*fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // decoration: BoxDecoration(border: Border.all(color:Colors.red)),
                              // autogrouppzlbFPd (7eFAjq2h87LUBU3jhWPZLB)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0.35 * fem),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 115 - 20 - 20 - 10 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // baggagekrB (1:21156)
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 115 - 20 - 20 - 10 - 10 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            21 * fem),
                                        // border: Border.all(color:Colors.green)
                                      ),
                                      child: Container(
                                        // frame3955Nf (1:21157)
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 51.19 - 20 * fem, 0 * fem,
                                            49.81 - 20 - 10 - 10 * fem),
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              21 * fem),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                category = "popular";
                                                setModalState(() {});
                                              },
                                              child: Text(
                                                'Popular',
                                                style: SafeGoogleFont(
                                                  'DM Sans',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.0769230769 * ffem /
                                                      fem,
                                                  color: category == "popular"
                                                      ? Color(0xffffffff)
                                                      : Color(0xff777777),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                category = "special";
                                                setModalState(() {});
                                              },
                                              child: Container(
                                                // baggagezEj (1:21188)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem, 0 * fem, 0 * fem,
                                                    0 * fem),
                                                child: Text(
                                                  'Special',
                                                  style: SafeGoogleFont(
                                                    'DM Sans',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.0769230769 *
                                                        ffem / fem,
                                                    color: category == "special"
                                                        ? Color(0xffffffff)
                                                        : Color(0xff777777),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                category = "vip";
                                                setModalState(() {});
                                              },
                                              child: Container(
                                                // baggagezEj (1:21188)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem, 0 * fem, 0 * fem,
                                                    0 * fem),
                                                child: Text(
                                                  'VIP',
                                                  style: SafeGoogleFont(
                                                    'DM Sans',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.0769230769 *
                                                        ffem / fem,
                                                    color: category == "vip"
                                                        ? Color(0xffffffff)
                                                        : Color(0xff777777),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                category = "classic";
                                                setModalState(() {});
                                              },
                                              child: Container(
                                                // baggageJWK (1:21191)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem, 0 * fem, 0 * fem,
                                                    0 * fem),
                                                child: Text(
                                                  'Classic',
                                                  style: SafeGoogleFont(
                                                    'DM Sans',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.0769230769 *
                                                        ffem / fem,
                                                    color: category == "classic"
                                                        ? Color(0xffffffff)
                                                        : Color(0xff777777),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                category = "new";
                                                setModalState(() {});
                                              },
                                              child: Text(
                                                // baggageDdH (1:21194)
                                                'New',
                                                style: SafeGoogleFont(
                                                  'DM Sans',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.0769230769 * ffem /
                                                      fem,
                                                  color: category == "new"
                                                      ? Color(0xffffffff)
                                                      : Color(0xff777777),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300 * fem,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  // You can adjust the cross axis count as needed
                                  mainAxisSpacing: 3.0,
                                  crossAxisSpacing: 0.0,
                                  childAspectRatio: 0.87, // Adjust this ratio to fit your needs
                                ),
                                itemCount: 6,
                                // Set itemCount to the number of items you have
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      selected = index;
                                      setModalState(() {});
                                    },
                                    child: Container(
                                      width: 124.58 * fem,
                                      height: 149.51 * fem,
                                      decoration: BoxDecoration(
                                        border: selected == index
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 3)
                                            : null,
                                        color: const Color(0xff1d1927),
                                        borderRadius: BorderRadius.circular(
                                            5 * fem),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x3f000000),
                                            offset: Offset(0 * fem, 4 * fem),
                                            blurRadius: 2 * fem,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // button5rP (1:21205)
                                            right: 0 * fem,
                                            top: 0 * fem,
                                            child: Visibility(
                                              visible: selected != -1 &&
                                                  selected == index,
                                              child: Container(
                                                width: amount == 200
                                                    ? 38
                                                    : 32.73 * fem,
                                                height: 22 * fem,
                                                child: SizedBox(
                                                  width: amount == 200
                                                      ? 38
                                                      : 32.73 * fem,
                                                  height: 18 * fem,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff3991ec)),
                                                      borderRadius: BorderRadius
                                                          .only(
                                                        topLeft: Radius
                                                            .circular(1 * fem),
                                                        topRight: Radius
                                                            .circular(1 * fem),
                                                        bottomRight: Radius
                                                            .circular(1 * fem),
                                                        bottomLeft: Radius
                                                            .circular(9 * fem),
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin: Alignment(0, -1),
                                                        end: Alignment(0, 1),
                                                        colors: <Color>[
                                                          Color(0xff3d8ee1),
                                                          Color(0xff68c5e2)
                                                        ],
                                                        stops: <double>[0, 1],
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'x$amount',
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: SafeGoogleFont(
                                                          'DM Sans',
                                                          fontSize: amount ==
                                                              200
                                                              ? 12 * fem
                                                              : 15 * ffem,
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          height: 1.4666666667 *
                                                              ffem / fem,
                                                          color: Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10.52 * fem, selected == index
                                                ? 5.58
                                                : 14.58 * fem, 16.9 * fem, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Container(
                                                  // Qhm (1:21164)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem, 0 * fem, 0 * fem,
                                                      2.77 * fem),
                                                  width: 97.16 * fem,
                                                  height: 88.4 * fem,
                                                  child: Image.asset(
                                                    images[index],
                                                    // fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  // contentWVu (1:21160)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem, 0 * fem, 0 * fem,
                                                      0 * fem),
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                        // aeroplane3Vq (1:21162)
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0 * fem, 0 * fem,
                                                            0 * fem,
                                                            3.25 * fem),
                                                        child: Text(
                                                          'Aeroplane',
                                                          style: SafeGoogleFont(
                                                            'DM Sans',
                                                            fontSize: 10 * ffem,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            height: 1.4 * ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff9e9e9e),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        // autogroupxs2bN2K (7eFBGUpHYyjgXPuoRjxS2b)
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0.18 * fem, 0 * fem,
                                                            0 * fem, 0 * fem),
                                                        width: double.infinity,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Opacity(
                                                              // gemstonestWT (1:21163)
                                                              opacity: 0.9,
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                    0 * fem,
                                                                    0.21 * fem,
                                                                    5.85 * fem,
                                                                    0 * fem),
                                                                width: 17.53 *
                                                                    fem,
                                                                height: 11.7 *
                                                                    fem,
                                                                child: Image
                                                                    .asset(
                                                                  'assets/dino/gemstones.png',
                                                                  width: 17.53 *
                                                                      fem,
                                                                  height: 11.7 *
                                                                      fem,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              // hTu (1:21161)
                                                              '3',
                                                              style: SafeGoogleFont(
                                                                'DM Sans',
                                                                fontSize: 10 *
                                                                    ffem,
                                                                fontWeight: FontWeight
                                                                    .w400,
                                                                height: 1.4 *
                                                                    ffem / fem,
                                                                color: Color(
                                                                    0xff9e9e9e),
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
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ),
                            Container(
                              // dotsgf9 (1:21195)
                              margin: EdgeInsets.fromLTRB(
                                  171 * fem, 12 * fem, 0 * fem, 17.1 * fem),
                              width: 31.04 * fem,
                              height: 6.9 * fem,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Container(
                                    width: 6.9 * fem,
                                    height: 6.9 * fem,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 6.9 * fem,
                                    height: 6.9 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF605B69),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 6.9 * fem,
                                    height: 6.9 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF605B69),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // autogrouproujny5 (7eFDGAzWiNGsequUiWroUj)
                              margin: EdgeInsets.fromLTRB(
                                  10 * fem, 0 * fem, 0 * fem, 0 * fem),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // aeroplane7VZ (1:21123)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 9 * fem, 0 * fem),
                                    child: Text(
                                      'Amount',
                                      style: SafeGoogleFont(
                                        'DM Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.1666666667 * ffem / fem,
                                        color: Color(0xff9e9e9e),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 1;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroup5qgkdio (7eFDXR47eLroEPtgf65qgK)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 12 * fem, 0 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 1
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '1',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8235294118 * ffem / fem,
                                            color: selected != -1 && amount == 1
                                                ? Color(0xffffffff)
                                                : Color(0xff9e9e9e),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 5;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroupsy1qxPh (7eFDeL2GCRvTUfMGHFSy1q)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 10 * fem, 0 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 5
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '5',
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8235294118 * ffem / fem,
                                            color: selected != -1 && amount == 5
                                                ? Color(0xffffffff)
                                                : Color(0xff9e9e9e),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 10;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroupshyrS3y (7eFDjuhJDB9CEKgd8hshyR)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 10 * fem, 0 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 10
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '10',
                                          style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 17 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 0.8235294118 * ffem / fem,
                                              color: selected != -1 &&
                                                  amount == 10 ? Color(
                                                  0xffffffff) : Color(
                                                  0xff9e9e9e)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 50;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),
                                      // autogroupurrkfxK (7eFDpKjcFVkNgCnR4YUrrK)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 10 * fem, 1 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 50
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '50',
                                          style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 17 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 0.8235294118 * ffem / fem,
                                              color: selected != -1 &&
                                                  amount == 50 ? Color(
                                                  0xffffffff) : Color(
                                                  0xff9e9e9e)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 200;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroupeqsqvNT (7eFDtpc7aGyEiVq2uveQsq)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 200
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '200',
                                          style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 17 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 0.8235294118 * ffem / fem,
                                              color: selected != -1 &&
                                                  amount == 200 ? Color(
                                                  0xffffffff) : Color(
                                                  0xff9e9e9e)
                                          ),
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
                ),
              );
            });
      },
    );
  }


  static Widget goalWidget(double fem, double ffem, BuildContext context,
      LiveStreamingModel liveStreamingModel,
      {double? left, double? top, double? right, double? bottom }) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      right: right,
      child: Visibility(
        visible: liveStreamingModel.getGoal != null &&
            liveStreamingModel.getGoal != 0,
        child: liveStreamingModel.getDiamonds! / liveStreamingModel.getGoal! >=
            1.0 ? QuickActions.goalCompletedWidget(
            fem, ffem, context, liveStreamingModel) :
        Container(
          // licv3 (5:38216)
          padding: EdgeInsets.fromLTRB(10 * fem, 2 * fem, 8.48 * fem, 0 * fem),
          width: 132 * fem,
          decoration: BoxDecoration(
            color: const Color(0x66000000),
            borderRadius: BorderRadius.circular(10 * fem),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // autogroupe8ydueF (7eJAvKoQ438Ja171X5e8yd)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 2 * fem),
                width: 98 * fem,
                constraints: BoxConstraints(
                  minHeight: 18 * fem,
                  // maxHeight : 23*fem,
                ),
                child: Align(
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        liveStreamingModel.getGoalTile ?? '',
                        style: SafeGoogleFont(
                          'Content',
                          fontSize: 8 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.375 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 5 * fem,
                margin: EdgeInsets.fromLTRB(
                    2.11 * fem, 2 * fem, 0 * fem, 1 * fem),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14 * fem),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14 * fem),
                  child: LinearProgressIndicator(
                    minHeight: 5 * fem,
                    // Set the height
                    backgroundColor: const Color(0xFF777777),
                    // Set the inactive color
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFBD2B)),
                    // Set the active color
                    value: liveStreamingModel.getDiamonds! / liveStreamingModel
                        .getGoal!, // Set the value of the progress (0.0 to 1.0)
                    // Set the border radius
                  ),
                ),
              ),
              Container(
                // autogroupqqt3zSj (7eJB5EiDR8xM4BFRJJQqt3)
                margin: EdgeInsets.fromLTRB(
                    1.71 * fem, 0 * fem, 44.52 * fem, 0 * fem),
                padding: EdgeInsets.fromLTRB(
                    0 * fem, 3 * fem, 2 * fem, 3 * fem),
                width: double.infinity,
                height: 22 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // goaltHD (5:38232)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 1.29 * fem, 0 * fem),
                      child: Text(
                        'Goal:',
                        style: SafeGoogleFont(
                          'Fredoka',
                          fontSize: 9 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5555555556 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      // tablerdiamondtRd (5:38235)
                      margin: EdgeInsets.fromLTRB(
                          1.88 * fem, 2.65 * fem, 3.87 * fem, 0 * fem),
                      width: 11.25 * fem,
                      height: 8.25 * fem,
                      child: Image.asset(
                        'assets/dino/gemstones.png',
                        width: 11.25 * fem,
                        height: 8.25 * fem,
                      ),
                    ),
                    Text(
                      // bL3 (5:38237)
                      liveStreamingModel.getGoal.toString() ?? "0",
                      style: SafeGoogleFont(
                        'DM Sans',
                        fontSize: 10 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.8 * ffem / fem,
                        color: Color(0xfff8f8f8),
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: Colors.red
                    //     )
                    //   ),
                    //   // icbaselinediamondNCP (5:38234)
                    //   padding: EdgeInsets.fromLTRB(1.88*fem, 0*fem, 0*fem, 0*fem),
                    //   height: double.infinity,
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget goalCompletedWidget(double fem, double ffem,
      BuildContext context,
      LiveStreamingModel liveStreamingModel) {
    return Positioned(
      left: 7 * fem,
      top: 148 * fem,
      child: Visibility(
        visible: liveStreamingModel.getGoal != null &&
            liveStreamingModel.getGoal != 0,
        child: Column(
          children: [
            Container(
              // liasy (5:39974)
              padding: EdgeInsets.fromLTRB(
                  6 * fem, 9 * fem, 4.57 * fem, 0 * fem),
              width: 141 * fem,
              decoration: BoxDecoration(
                color: Color(0x66000000),
                borderRadius: BorderRadius.circular(10 * fem),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // autogroupbhmz5Jw (7eJTrLb7kGYfsVxdkBbhMZ)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 6.92 * fem),
                    width: 138 * fem,
                    child: Container(
                      // iwantbuynewiphonehelpmeMXM (5:39975)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 14.34 * fem, 0 * fem),
                      child: Text(
                        liveStreamingModel.getGoalTile ?? '',
                        maxLines: 2,
                        style: SafeGoogleFont(
                          'Content',
                          fontSize: 7 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.5714285714 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // dividerUVV (5:39981)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 1.43 * fem, 0.49 * fem),
                    width: 129 * fem,
                    height: 1 * fem,
                    child: Image.asset(
                      'assets/dino/divide.png',
                      width: 129 * fem,
                      height: 1 * fem,
                    ),
                  ),
                  Container(
                    // autogroupnqifwts (7eJTwawNdBJgFWWguTnqif)
                    margin: EdgeInsets.fromLTRB(
                        1 * fem, 0 * fem, 7.43 * fem, 0 * fem),
                    padding: EdgeInsets.fromLTRB(
                        2 * fem, 2 * fem, 0 * fem, 3 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // icbaselinediamondDrP (5:39977)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 1 * fem, 63 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              1.88 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // tablerdiamondH5Z (5:39978)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 3.87 * fem, 0.15 * fem),
                                width: 11.25 * fem,
                                height: 8.25 * fem,
                                child: Image.asset(
                                  'assets/dino/gemstones.png',
                                  width: 11.25 * fem,
                                  height: 8.25 * fem,
                                ),
                              ),
                              Text(
                                // yUB (5:39980)
                                '${liveStreamingModel.getGoal ?? 0}',
                                style: SafeGoogleFont(
                                  'DM Sans',
                                  fontSize: 10 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.8 * ffem / fem,
                                  color: Color(0xfff8f8f8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // groupGy5 (5:39996)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 4 * fem),
                          width: 15 * fem,
                          height: 15 * fem,
                          child: Image.asset(
                            'assets/dino/tick.png',
                            width: 15 * fem,
                            height: 15 * fem,
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
    );
  }


  static setGoal(double fem, double ffem, BuildContext context,
      LiveStreamingModel liveStreamingModel) {
    RxInt amount = 10.obs;
    RxBool other = false.obs;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20 * fem), // Set the radius for the top border
        ),),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              return Container(
                padding: EdgeInsets.fromLTRB(
                    8 * fem, 5.41 * fem, 0 * fem, 22 * fem),
                width: 375 * fem,
                height: 490 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20 * fem),
                    topRight: Radius.circular(20 * fem),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogrouptritAfh (7eHinKrS5uYWTj4DpfTriT)
                      margin: EdgeInsets.fromLTRB(
                          9 * fem, 0 * fem, 153.88 * fem, 6.49 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              QuickHelp.goBack(context);
                            },
                            child: Container(
                              // iconsHVR (4:34645)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 14.11 * fem, 124 * fem, 0 * fem),
                              width: 20 * fem,
                              height: 19.29 * fem,
                              child: Image.asset(
                                'assets/dino/back_black.png',
                                width: 20 * fem,
                                height: 19.29 * fem,
                              ),
                            ),
                          ),
                          Container(
                            // tropystarbW7 (4:34632)
                            width: 52.12 * fem,
                            height: 86.53 * fem,
                            child: Image.asset(
                              'assets/dino/trophy_star.png',
                              width: 52.12 * fem,
                              height: 86.53 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // recentHtj (4:34631)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 33.92 * fem),
                      child: Text(
                        'Your goal',
                        style: SafeGoogleFont(
                          'DM Sans',
                          fontSize: 17 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.0588235294 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      // recentoMH (4:34644)
                      margin: EdgeInsets.fromLTRB(
                          3 * fem, 0 * fem, 0 * fem, 34.65 * fem),
                      child: Text(
                        'Select your target amount',
                        style: SafeGoogleFont(
                          'DM Sans',
                          fontSize: 17 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.0588235294 * ffem / fem,
                          color: Color(0x72000000),
                        ),
                      ),
                    ),
                    Container(
                      // frame53003JYw (4:34650)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 15 * fem, 40 * fem),
                      width: 350 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Container(
                              // frame52999d5R (4:34651)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 17 * fem),
                              width: double.infinity,
                              height: 80 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  amountWidget(
                                      fem, ffem, 10, amount.value == 10, amount,
                                      other),
                                  SizedBox(
                                    width: 7 * fem,
                                  ),
                                  amountWidget(
                                      fem, ffem, 50, amount.value == 50, amount,
                                      other),
                                  SizedBox(
                                    width: 7 * fem,
                                  ),
                                  amountWidget(
                                      fem, ffem, 100, amount.value == 100,
                                      amount, other),
                                ],
                              ),
                            );
                          }
                          ),
                          Obx(() {
                            return SizedBox(
                              // frame53000Uhd (4:34670)
                              width: double.infinity,
                              height: 80 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  amountWidget(
                                      fem, ffem, 200, amount.value == 200,
                                      amount, other),
                                  SizedBox(
                                    width: 7 * fem,
                                  ),
                                  amountWidget(
                                      fem, ffem, 1000, amount.value == 1000,
                                      amount, other),
                                  SizedBox(
                                    width: 7 * fem,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      other.value = true;
                                      amount.value = 0;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          other.value ? 2 : 0),
                                      width: 110 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: other.value
                                            ? const LinearGradient (
                                          begin: Alignment(0, -1),
                                          end: Alignment(0, 1),
                                          colors: <Color>[
                                            Color(0xff3d8ee1),
                                            Color(0xff68c5e2)
                                          ],
                                          stops: <double>[0, 1],
                                        )
                                            : null,
                                        border: other.value ? null : Border.all(
                                            color: Color(0xffe0e0e0)),
                                        borderRadius: BorderRadius.circular(
                                            10 * fem),
                                      ),
                                      child: Container(
                                        // frame52998kU7 (4:34683)

                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              10 * fem),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Other',
                                            style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 21 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 0.8571428571 * ffem / fem,
                                              color: Color(0x72000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (other.value == true) {
                          QuickHelp.goBack(context);
                          QuickActions.otherAmount(
                              fem, ffem, context, liveStreamingModel);
                        }
                        else {
                          QuickHelp.goBack(context);
                          QuickActions.addGoalMessage(
                              fem, ffem, context, liveStreamingModel, amount
                              .value);
                        }
                      },
                      child: Container(
                        // buttonqVZ (4:34646)
                        margin: EdgeInsets.fromLTRB(
                            50 * fem, 0 * fem, 54 * fem, 0 * fem),
                        width: double.infinity,
                        height: 48 * fem,

                        child: Container(
                          // buttonLBR (4:34647)
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0 * fem, 4 * fem),
                                blurRadius: 2 * fem,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24 * fem),
                            gradient: const LinearGradient (
                              begin: Alignment(0, -1),
                              end: Alignment(0, 1),
                              colors: <Color>[
                                Color(0xff3d8ee1),
                                Color(0xff68c5e2)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'DM Sans',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.375 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }


  static Widget amountWidget(double fem, double ffem, int amount, bool active,
      RxInt selectedAmount, RxBool other) {
    return InkWell(
      onTap: () {
        selectedAmount.value = amount;
        other.value = false;
      },
      child: Container(
        width: 110 * fem,
        padding: EdgeInsets.all(active ? 2 * fem : 0),
        decoration: BoxDecoration(
          border: active ? null : Border.all(color: const Color(0xffe0e0e0)),
          gradient: active ? const LinearGradient (
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xff3d8ee1), Color(0xff68c5e2)],
            stops: <double>[0, 1],
          ) : null,
          borderRadius: BorderRadius.circular(10 * fem),

        ),
        child: Container(
          // frame529974xf (4:34677)
          padding: EdgeInsets.fromLTRB(26.5 * fem, 0, 0 * fem, 0),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10 * fem),
          ),
          child: Container(
            // icbaselinediamondzLX (4:34679)
            padding: EdgeInsets.fromLTRB(2.5 * fem, 1 * fem, 0 * fem, 1 * fem),
            width: double.infinity,
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // tablerdiamondK7u (4:34680)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 4.5 * fem, 0.2 * fem),
                  width: 15 * fem,
                  height: 11 * fem,
                  child: Image.asset(
                    'assets/dino/gemstones.png',
                    width: 15 * fem,
                    height: 11 * fem,
                  ),
                ),
                Text(
                  // d8b (4:34682)
                  '$amount',
                  style: SafeGoogleFont(
                    'DM Sans',
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2857142857 * ffem / fem,
                    color: Color(0xff080808),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  static otherAmount(double fem, double ffem, BuildContext context,
      LiveStreamingModel liveStreamingModel) {
    TextEditingController textEditingController = TextEditingController();
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20 * fem), // Set the radius for the top border
        ),),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              return Container(
                padding: EdgeInsets.fromLTRB(
                    0 * fem, 9 * fem, 0 * fem, 0 * fem),
                width: 375 * fem,
                height: 346 * fem,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupqcuxg3H (7eHrxqimkASXdjKS9UqcUX)
                      margin: EdgeInsets.fromLTRB(
                          8 * fem, 0 * fem, 16 * fem, 8 * fem),
                      width: double.infinity,
                      height: 42 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconso7u (5:35687)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 38 * fem, 5.68 * fem),
                            width: 20 * fem,
                            height: 19.29 * fem,
                            child: Image.asset(
                              'assets/dino/back_black.png',
                              width: 20 * fem,
                              height: 19.29 * fem,
                            ),
                          ),
                          Container(
                            // frameUzj (5:35685)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 15 * fem, 0 * fem),
                            padding: EdgeInsets.fromLTRB(
                                10 * fem, 9 * fem, 10 * fem, 13 * fem),
                            width: 207 * fem,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xfff5f6fb),
                              borderRadius: BorderRadius.circular(15 * fem),
                            ),
                            child: TextField(
                              controller: textEditingController,
                              readOnly: true,
                              // Set readOnly to true
                              enableInteractiveSelection: false,
                              // Disable interactive selection
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // Remove the border
                                contentPadding: EdgeInsets.zero,
                                // Remove content padding
                                isCollapsed: true,
                                // Set isCollapsed to true
                                hintText: 'Please Input the number',
                                hintStyle: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4000000272 * ffem / fem,
                                  letterSpacing: 0.200000003 * fem,
                                  color: Color(0xffc6c8cc),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isEmpty) {
                                QuickHelp.showAppNotificationAdvanced(
                                    title: 'Please Input number!',
                                    context: context);
                              }
                              else if (textEditingController.text == '0') {
                                QuickHelp.showAppNotificationAdvanced(
                                    title: 'Number must be greater than zero!',
                                    context: context);
                              }
                              else {
                                QuickHelp.goBack(context);
                                QuickActions.addGoalMessage(
                                    fem, ffem, context, liveStreamingModel,
                                    int.parse(textEditingController.text));
                              }
                            },
                            child: Container(
                              // buttonYDu (5:35688)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 3 * fem, 0 * fem, 4 * fem),
                              width: 71 * fem,
                              height: double.infinity,
                              child: Container(
                                // buttonrEb (5:35689)
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x3f000000),
                                      offset: Offset(0 * fem, 4 * fem),
                                      blurRadius: 2 * fem,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(24 * fem),
                                  gradient: const LinearGradient (
                                    begin: Alignment(0, -1),
                                    end: Alignment(0, 1),
                                    colors: <Color>[
                                      Color(0xff3d8ee1),
                                      Color(0xff68c5e2)
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Ok',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'DM Sans',
                                      fontSize: 17 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2941176471 * ffem / fem,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // goalpopJMV (5:35692)
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 20 * fem, 19 * fem, 19 * fem),
                      width: double.infinity,
                      height: 287 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xffcbd0d7),
                      ),
                      child: Container(
                        // keyboardnumberRwu (5:35694)
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              // autolayouthorizontalAeb (5:35695)
                              width: double.infinity,
                              height: 56 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "1";
                                    },
                                    child: Container(
                                      // autolayoutverticalJVu (5:35696)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '1',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "2";
                                    },
                                    child: Container(
                                      // autolayoutverticalAHD (5:35698)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '2',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "3";
                                    },
                                    child: Container(
                                      // autolayoutverticalF3m (5:35700)
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '3',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8 * fem,
                            ),
                            Container(
                              // autolayouthorizontalKJX (5:35702)
                              width: double.infinity,
                              height: 56 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "4";
                                    },
                                    child: Container(
                                      // autolayoutverticalrZM (5:35703)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '4',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "5";
                                    },
                                    child: Container(
                                      // autolayoutvertical8mm (5:35705)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '5',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "6";
                                    },
                                    child: Container(
                                      // autolayoutverticalQjH (5:35707)
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '6',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8 * fem,
                            ),
                            Container(
                              // autolayouthorizontalteT (5:35709)
                              width: double.infinity,
                              height: 56 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "7";
                                    },
                                    child: Container(
                                      // autolayoutverticalRuH (5:35710)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '7',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "8";
                                    },
                                    child: Container(
                                      // autolayoutverticalKUs (5:35712)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '8',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "9";
                                    },
                                    child: Container(
                                      // autolayoutverticalzL7 (5:35714)
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '9',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8 * fem,
                            ),
                            Container(
                              // autolayouthorizontal5cT (5:35716)
                              margin: EdgeInsets.fromLTRB(
                                  115.33 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              height: 56 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text + "0";
                                    },
                                    child: Container(
                                      // autolayoutverticalDCs (5:35717)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                      width: 107.33 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff1f1f1),
                                        borderRadius: BorderRadius.circular(
                                            12 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '0',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'SF Pro Display',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2575 * ffem / fem,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      textEditingController.text =
                                          textEditingController.text.substring(
                                              0, textEditingController.text
                                              .length - 1);
                                    },
                                    child: Container(
                                      // autolayoutvertical73M (5:35719)
                                      width: 107.33 * fem,
                                      height: 56 * fem,
                                      child: Image.asset(
                                        'assets/dino/remove.png',
                                        width: 107.33 * fem,
                                        height: 56 * fem,
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
                ),
              );
            });
      },
    );
  }


  static addGoalMessage(double fem, double ffem, BuildContext context,
      LiveStreamingModel liveStreamingModel, int amount) {
    TextEditingController textEditingController = TextEditingController();
    RxString errorText = ''.obs;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20 * fem), // Set the radius for the top border
        ),),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20 * fem),
                    topRight: Radius.circular(20 * fem),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom * 0.44),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        17 * fem, 5 * fem, 15 * fem, 22 * fem),
                    width: 375 * fem,
                    height: 453 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20 * fem),
                        topRight: Radius.circular(20 * fem),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupwqqfqQb (7eHzm2tyMSTbo6FD4UWQQF)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem,
                              146.88 * fem, 6 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // iconsZLb (5:36554)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 14.51 * fem, 124 * fem, 0 * fem),
                                width: 20 * fem,
                                height: 19.29 * fem,
                                child: Image.asset(
                                  'assets/dino/back.png',
                                  width: 20 * fem,
                                  height: 19.29 * fem,
                                ),
                              ),
                              Container(
                                // tropystareN3 (5:36535)
                                width: 52.12 * fem,
                                height: 80 * fem,
                                child: Image.asset(
                                  'assets/dino/trophy_star.png',
                                  width: 52.12 * fem,
                                  height: 80 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // recent9pb (5:36534)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem,
                              52 * fem),
                          child: Text(
                            'Your goal',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 17 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.0588235294 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          // recentfY3 (5:36547)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 6 * fem,
                              30 * fem),
                          constraints: BoxConstraints(
                            maxWidth: 295 * fem,
                          ),
                          child: Text(
                            'Type your goal message and make it short',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 17 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.0588235294 * ffem / fem,
                              color: Color(0x72000000),
                            ),
                          ),
                        ),
                        Container(
                          width: 338 * fem,
                          height: 59 * fem,
                          margin: EdgeInsets.fromLTRB(5 * fem, 0 * fem, 0 * fem,
                              0 * fem),
                          padding: EdgeInsets.all(1 * fem),
                          decoration: BoxDecoration(
                            color: const Color(0xfff5f6fb),
                            borderRadius: BorderRadius.circular(15 * fem),
                            gradient: const LinearGradient (
                              begin: Alignment(0, -1),
                              end: Alignment(0, 1),
                              colors: <Color>[
                                Color(0xff3d8ee1),
                                Color(0xff68c5e2)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                10 * fem, 8 * fem, 10 * fem, 8 * fem),
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f6fb),
                              borderRadius: BorderRadius.circular(15 * fem),
                            ),
                            child: TextFormField(
                              controller: textEditingController,
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  errorText.value =
                                  'Please provide a message; it cannot be left empty';
                                }
                                else if (value.length > 40) {
                                  errorText.value =
                                  'Your message must be under 40 characters.';
                                }
                                else {
                                  errorText.value = '';
                                }
                              },
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.4000000272 * ffem / fem,
                                letterSpacing: 0.200000003 * fem,
                                color: Color(0xff9e9e9e),
                              ),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                border: InputBorder.none,
                                // Remove the border
                                contentPadding: EdgeInsets.zero,
                                // Remove content padding
                                hintText: 'Type your goal message...',
                                hintStyle: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4000000272 * ffem / fem,
                                  letterSpacing: 0.200000003 * fem,
                                  color: Color(0xff9e9e9e),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2 * fem,),
                        Obx(() {
                          return Text(errorText.value,
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4000000272 * ffem / fem,
                              letterSpacing: 0.200000003 * fem,
                              color: Colors.red,
                            ),);
                        }
                        ),
                        SizedBox(height: 90 - 11 * fem,),
                        InkWell(
                          onTap: () async {
                            if (textEditingController.text.isEmpty) {
                              QuickHelp.showAppNotificationAdvanced(
                                  title: 'Please provide a message; it cannot be left empty',
                                  context: context);
                            }
                            else if (errorText.value.isNotEmpty) {
                              QuickHelp.showAppNotificationAdvanced(
                                  title: errorText.value, context: context);
                            }
                            else {
                              liveStreamingModel.setGoalTitle =
                                  textEditingController.text;
                              liveStreamingModel.setGoal = amount;
                              ParseResponse response = await liveStreamingModel
                                  .save();
                              if (response.success) {
                                QuickHelp.goBack(context);
                                QuickHelp.goBack(context);
                                // QuickHelp.showAppNotification(title: 'Something went wrong. Plz try again later', context: context,isError: false);
                              }
                              else {
                                QuickHelp.showAppNotificationAdvanced(
                                    title: 'Something went wrong. Plz try again later',
                                    context: context);
                              }
                            }
                          },
                          child: Container(
                            // button1kK (5:36550)
                            margin: EdgeInsets.fromLTRB(
                                41 * fem, 0 * fem, 47 * fem, 0 * fem),
                            width: double.infinity,
                            height: 48 * fem,
                            decoration: BoxDecoration(
                            ),
                            child: Container(
                              // buttonjRR (5:36551)
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0 * fem, 4 * fem),
                                    blurRadius: 2 * fem,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(24 * fem),
                                gradient: const LinearGradient (
                                  begin: Alignment(0, -1),
                                  end: Alignment(0, 1),
                                  colors: <Color>[
                                    Color(0xff3d8ee1),
                                    Color(0xff68c5e2)
                                  ],
                                  stops: <double>[0, 1],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Done',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'DM Sans',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.375 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }


  static String getCountryFlag(UserModel currentUser) {
    String country = currentUser.getCountry ?? 'Pakistan';
    if (country == "Pakistan")
      return AppImagePath.pakistanFlag;
    else if (country == "USA")
      return AppImagePath.americanFlag;
    else if (country == "Canada")
      return AppImagePath.canadaFlag;
    else if (country == "France")
      return AppImagePath.franceFlag;
    else if (country == "Ukraine")
      return AppImagePath.ukraineFlag;
    else
      return AppImagePath.pakistanFlag;
  }

  static String getCountryCode(UserModel currentUser) {
    String country = currentUser.getCountry ?? 'Pakistan';
    switch (country) {
      case 'Pakistan':
        return AppCountryCode.pakistanCode;
      case 'USA':
        return AppCountryCode.americanCode;
      case 'Canada':
        return AppCountryCode.canadaCode;
      case 'France':
        return AppCountryCode.franceCode;
      case 'Ukraine':
        return AppCountryCode.ukraineCode;
      default:
        return AppCountryCode.pakistanCode;
    }
  }


  static void showAlertDialog(BuildContext context, String title, Function() onTap){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF494848),
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0))),
          title: Text(
            title,
            style: TextStyle(
                color: AppColors.white, fontSize: 14),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    title: "No",
                    textColor: AppColors.black,
                    borderRadius: 35,
                    borderColor:
                    AppColors.yellowBtnColor,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: PrimaryButton(
                    title: "Yes",
                    textColor: AppColors.black,
                    borderRadius: 35,
                    bgColor: AppColors.yellowBtnColor,
                    onTap: onTap
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }


}


class AppCountryCode {
  static const String pakistanCode = 'PK';
  static const String americanCode = 'US';
  static const String canadaCode = 'CA';
  static const String franceCode = 'FR';
  static const String ukraineCode = 'UA';
}


void openBottomSheet(Widget widget , BuildContext context, {bool back=false}){
  if(back==true)
    Get.back();

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
        widget,
        // StickerModalSheet(),  // single live create extra sheets
        // FilterWordWidget(), //  filter word sheet
        // LocalMusicWidget(), // local music sheet
        // DataSheetWidget(),       //  data sheet
        // ScreenSharingWidget(), //  screen sharing
        //  ManageSheet(),   // manage sheet
        // LiveSettingSheet(), //  live setting sheet
        // BoostSheet(), //  multi guest boost sheet
        // SubscriberSheet(), // multi guest subscriber sheet
        // WhisperModal(), // whisper modal sheet
        // TopGifters(), // top gifters sheet
      ],
    ),
  );

}
