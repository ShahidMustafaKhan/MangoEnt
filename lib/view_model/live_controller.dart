import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:teego/parse/BattleStreamingModel.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view_model/gift_contoller.dart';
import 'package:teego/view_model/live_messages_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../data/app/setup.dart';
import '../helpers/quick_help.dart';
import '../parse/TimerModel.dart';
import '../parse/UserModel.dart';
import '../utils/routes/app_routes.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/internal_defines.dart';


class LiveViewModel extends GetxController {
  final ZegoLiveRole role;
  final LiveStreamingModel? liveModel;


  RxString title = ''.obs;
  RxString mode = 'Public'.obs;
  RxList tagList=[].obs;
  RxString selectedLanguage='Language'.obs;
  RxString roomAnnouncement=''.obs;
  LiveStreamingModel liveStreamingModel= LiveStreamingModel();
  LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  int giftListLength=0;
  List giftSendersList=[];
  ParseFileBase? parseFile;
  RxString selectedLiveType='Live'.obs;
  final List bottomTab = [
    'Multi-guest Live',
    'Live',
    'Audio Live',
    'Game Live',
  ];

  int multiLiveIndex=0;
  int singleLiveIndex=1;
  int audioLiveIndex=2;
  int gameLiveIndex=3;


  addParseFile(ParseFileBase? file){
    parseFile = file;
    update();
  }

  updateLiveStreamingModel(){
    update();
  }

  saveLiveStreamingModel(){
    liveStreamingModel.save();
  }


  subscribeLiveStreamingModel() async {
    QueryBuilder<LiveStreamingModel> query =
    QueryBuilder<LiveStreamingModel>(LiveStreamingModel());

    query.whereEqualTo(LiveStreamingModel.keyObjectId, liveStreamingModel.objectId);
    query.includeObject([
      LiveStreamingModel.keyAuthor,
      LiveStreamingModel.keyBattleModel,
    ]);

    subscription = await liveQuery.client.subscribe(query);

    subscription!.on(LiveQueryEvent.update, (LiveStreamingModel value) async {

      if(kDebugMode){
        print('*** livestreaming UPDATE ***');
        print('*** livestreaming UPDATE ***');
      }

      UserModel author = liveStreamingModel.getAuthor!;

      liveStreamingModel = value;
      liveStreamingModel.setAuthor = author;
      if(liveStreamingModel.getGiftsList!.length > giftListLength){
        giftListLength=liveStreamingModel.getGiftsList!.length;
        Map lastGift=liveStreamingModel.getGiftsList!.last;
        String gift= lastGift["gift"];
        String audio = lastGift["audio"];
        Get.find<GiftViewModel>().loadAnimation(gift, audio);
    }
      update();

      if(value.getStreaming==false && role==ZegoLiveRole.audience){
        closeAlert(Get.context!, forceEnded: true);
      }

      });
    }

  unSubscribeLiveStreamingModel() async {
    if (subscription != null) {
      liveQuery.client.unSubscribe(subscription!);
    }
    subscription = null;
  }

  createLive(BuildContext context) async {
    QuickHelp.showLoadingDialog(context, isDismissible: false);
    UserModel currentUser = Get.find<UserViewModel>().currentUser;
    liveStreamingModel.setAuthor =currentUser;
    liveStreamingModel.setAuthorId =currentUser.objectId!;
    liveStreamingModel.setAuthorUid =currentUser.getUid!;
    liveStreamingModel.setStreamerFollowers =currentUser.getFollowers!.length;
    // liveStreamingModel.setImage = parseFile!;
    if (currentUser.getGeoPoint != null) {
      liveStreamingModel.setStreamingGeoPoint =currentUser.getGeoPoint!;
    }
    liveStreamingModel.setStreaming = false;
    liveStreamingModel.addViewersCount = 0;
    liveStreamingModel.addDiamonds = 0;
    liveStreamingModel.setTitle = title.value;
    liveStreamingModel.setTags =  tagList;
    liveStreamingModel.setMode =  mode.value;
    liveStreamingModel.setRoomAnnouncement =  roomAnnouncement.value;
    liveStreamingModel.setLanguage=  selectedLanguage.value;
    liveStreamingModel.setStreamingType =  LiveStreamingModel.keyTypeSingleLive;
    // liveStreamingModel.setSeatNumber =  tabIndex;

    liveStreamingModel.save().then((value){
      if (value.success) {
        QuickHelp.hideLoadingDialog(context);
        Get.toNamed(AppRoutes.streamerSingleLive, arguments: {"role" : ZegoLiveRole.host});
      }
      else {
        QuickHelp.hideLoadingDialog(context);
        QuickHelp.showAppNotificationAdvanced(
            context: context,
            title: "live_streaming.live_set_cover_error".tr(),
            message: value.error!.message,
            isError: true,
            user: Get.find<UserViewModel>().currentUser);
      }

    }).onError((ParseError error, stackTrace) {

      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showAppNotificationAdvanced(
          context: context,
          title: "live_streaming.live_set_cover_error".tr(),
          message: "unknown_error".tr(),
          isError: true,
          user: Get.find<UserViewModel>().currentUser);

    }).catchError((err) {
      if (Setup.isDebug) print("Check live 19: $err");

      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showAppNotificationAdvanced(
          context: context,
          title: "live_streaming.live_set_cover_error".tr(),
          message: "unknown_error".tr(),
          isError: true,
          user: Get.find<UserViewModel>().currentUser);
    });
  }

  Future updateViewers(int uid, updateType, String joinUserName, String roomID) async {

    if(uid!=liveStreamingModel.getAuthor!.getUid!){
      if(updateType == ZegoUpdateType.Add){
        liveStreamingModel.addViewersCount = 1;
        liveStreamingModel.setViewersId = uid;
      }
      else{
        liveStreamingModel.removeViewersCount = 1;
        liveStreamingModel.setRemove("viewers_id", uid);
      }

      final updateResponse = await liveStreamingModel.save();

      if (updateResponse.success) {
        update();
      }
    }

  }

  closeAlert(BuildContext context, {bool forceEnded=false}) {
    if (role!=ZegoLiveRole.host) {
      popBackToHomePage(forceEnded: forceEnded);
    } else {
      QuickHelp.showDialogLivEend(
        context: context,
        title: 'live_streaming.live_'.tr(),
        confirmButtonText: 'live_streaming.finish_live'.tr(),
        message: 'live_streaming.finish_live_ask'.tr(),
        onPressed: () {
          Get.back();
          popBackToHomePage();
          endLive();
        },
      );
    }
  }

  Future<void> endLive() async {
    if(role==ZegoLiveRole.host){
      liveStreamingModel.setStreaming=false;
      liveStreamingModel.save();
    }
  }

  void popBackToHomePage({bool forceEnded=false}){
    Get.back();
    Get.back();
    if(forceEnded==true)
    QuickHelp.showSnackBar(title: 'Streamer Ended Live');
  }

  void startLive(){
    if(role==ZegoLiveRole.host) {
      liveStreamingModel.setStreaming = true;
      liveStreamingModel.save();
      update();
    }
  }

  Future<void> addBattleModel(BattleModel battleModel) async {
    liveStreamingModel.setBattleModel=battleModel;
    ParseResponse response = await liveStreamingModel.save();
    if(response.success){
      update();
    }
  }

  void endPreviousLiveStreaming() async {
    QueryBuilder<LiveStreamingModel> queryBuilder =
    QueryBuilder(LiveStreamingModel());
    queryBuilder.whereEqualTo(
        LiveStreamingModel.keyAuthorUid, Get.find<UserViewModel>().currentUser.getUid);
    queryBuilder.whereEqualTo(LiveStreamingModel.keyStreaming, true);

    ParseResponse parseResponse = await queryBuilder.query();
    if (parseResponse.success) {
      if (parseResponse.results != null) {
        LiveStreamingModel live =
        parseResponse.results!.first! as LiveStreamingModel;

        live.setStreaming = false;
        await live.save();
      }
    }
  }

  sendGift({required String gift, required String audio, required int coins}){
    liveStreamingModel.setGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url!, "coins": coins };
    liveStreamingModel.save();
  }


  LiveViewModel(this.role, this.liveModel);

  @override
  void onInit() {
    if(role==ZegoLiveRole.audience){
      liveStreamingModel=this.liveModel!;
      giftListLength=liveStreamingModel.getGiftsList!.length;
      updateLiveStreamingModel();
    }
    if(role==ZegoLiveRole.host)
      endPreviousLiveStreaming();


    super.onInit();
  }

  @override
  void onClose() {
    endLive();
    super.onClose();
  }


}


