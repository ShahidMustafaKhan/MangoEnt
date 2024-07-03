import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/parse/BattleStreamingModel.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view_model/gift_contoller.dart';
import 'package:teego/view_model/live_messages_controller.dart';
import 'package:teego/view_model/ranking_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:teego/view_model/youtube_controller.dart';
import 'package:teego/view_model/zego_controller.dart';
import 'package:wakelock/wakelock.dart';
import '../data/app/setup.dart';
import '../helpers/quick_help.dart';
import '../parse/TimerModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/status.dart';
import '../utils/routes/app_routes.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/internal_defines.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import 'multi_guest_grid_controller.dart';


class LiveViewModel extends GetxController {
  ZegoLiveRole role;
  final LiveStreamingModel? liveModel;

  //---- live preview-------
  final List bottomTab = [
    LiveStreamingModel.keyTypeMultiGuestLive,
    LiveStreamingModel.keyTypeSingleLive,
    LiveStreamingModel.keyTypeAudioLive,
    LiveStreamingModel.keyTypeGameLive,
  ];


  late Timer liveTimer;
  RxInt liveTime=0.obs;


  int multiLiveIndex=0;
  int singleLiveIndex=1;
  int audioLiveIndex=2;
  int gameLiveIndex=3;

  int? receiverUid;


  final RxInt nineMemberIndex = 0.obs;
  final RxString selectedGuestSeat = "4P".obs;
  //--------------------

  RxString title = ''.obs;
  RxString mode = 'Public'.obs;
  RxString backgroundImage=''.obs;
  RxList tagList=[].obs;
  RxString selectedLanguage='Language'.obs;
  RxString roomAnnouncement=''.obs;
  LiveStreamingModel liveStreamingModel= LiveStreamingModel();
  late LiveStreamingModel tempLiveStreamingModel;
  LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  int giftListLength=0;
  List giftSendersList=[];
  RxBool isCameraOn = true.obs;
  ParseFileBase? parseFile;
  RxString selectedLiveType=LiveStreamingModel.keyTypeSingleLive.obs;
  List viewerList=[];
  RxBool giftAnimation = true.obs;

  //------ people who are live list
  List<UserModel> liveUsers=[];

  //------ people who are live list
  List<UserModel> friendsList=[];

  Widget? video;

  List<UserModel> multiGuestCoHostList=[];
  List<UserModel> audioCoHostList=[];

  List? myWishList = [];

  List blockList=[];
  List disableList=[];
  List adminList=[];

  Status status = Status.Completed;

  RxBool dislike = false.obs;

  RxBool chatField = false.obs;
  TextEditingController chatEditingController = TextEditingController();

  List<Map> hostGifters = [];
  List<String> hostGiftersAvatar = [];
  Map<String,dynamic> senderDetail = {};
  RxBool showGiftBanner = false.obs;

  bool get isSingleLive {
    return liveStreamingModel.getStreamingType == LiveStreamingModel.keyTypeSingleLive;
  }

  bool get isAudioLive {
    return liveStreamingModel.getStreamingType == LiveStreamingModel.keyTypeAudioLive;
  }

  bool get isMultiGuest{
    return liveStreamingModel.getStreamingType == LiveStreamingModel.keyTypeMultiGuestLive;
  }

  bool get isMultiSeat3{
    return liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiThreeSeat;
  }
  bool get isMultiSeat4{
    return liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiFourSeat;
  }
  bool get isMultiSeat6{
    return liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiSixSeat;
  }
  bool get isMultiSeat9{
    return liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiNineSeat;
  }
  bool get isMultiSeat12{
    return liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiTwelveSeat;
  }


  set toggleDislike(bool value){
    dislike.value = !dislike.value;
  }



  addParseFile(ParseFileBase? file, File imageFile, BuildContext context) async {
    parseFile = file;
    liveStreamingModel.setImage = file!;
    ParseResponse response = await liveStreamingModel.save();
    if(response.success && response.results!= null ){
      liveStreamingModel = response.results!.first;
      QuickHelp.hideLoadingDialog(context);
      QuickHelp.hideLoadingDialog(context);
      update();

    }
    else{
      QuickHelp.hideLoadingDialog(context);
      QuickHelp.hideLoadingDialog(context);
    }

  }

  updateLiveStreamingModel(){
    update();
  }

  saveLiveStreamingModel(){
    liveStreamingModel.save();
  }

  Future<void> toggleCamera(CameraController cameraController) async {
    if (isCameraOn.value) {
      await cameraController.pausePreview();
    } else {
      await cameraController.resumePreview();
    }

      isCameraOn.value = !isCameraOn.value;

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
        addGifterList(lastGift);
        addGiftCoins(lastGift);
        showGiftReceiverBanner(lastGift);
    }
      if(liveStreamingModel.getMyWishList!= null){
      myWishList = liveStreamingModel.getMyWishList!;}
      update();

      updateViewersList(value.getViewersId ?? []);
      isExpandedFeatureActive();

      if(value.getStreaming==false && role==ZegoLiveRole.audience){
        closeAlert(Get.context!, forceEnded: true);
      }
      setYoutubeControllerValue();
      checkKickOutUserList(value);
      blockUserList(value);
      getDisableChatUsers(value);
      getAdminList(value);
      changeBackgroundImage(value);

      });
    }

  Future unSubscribeLiveStreamingModel() async {
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
    if(parseFile != null)
    liveStreamingModel.setImage = parseFile!;
    if (currentUser.getGeoPoint != null) {
      liveStreamingModel.setStreamingGeoPoint =currentUser.getGeoPoint!;
    }
    liveStreamingModel.setStreaming = false;
    liveStreamingModel.setStreamingType= selectedLiveType.value;
    liveStreamingModel.addViewersCount = 0;
    liveStreamingModel.addDiamonds = 0;
    liveStreamingModel.setTitle = title.value;
    liveStreamingModel.setTags =  tagList;
    liveStreamingModel.setMode =  mode.value;
    liveStreamingModel.setRoomAnnouncement =  roomAnnouncement.value;
    liveStreamingModel.setLanguage=  selectedLanguage.value;
    liveStreamingModel.setBackgroundImage =  backgroundImage.value;

    if(selectedLiveType.value == bottomTab[audioLiveIndex])
    liveStreamingModel.setAudioSeats= nineMemberIndex.value == 0 ? 8 : 11;

    if(selectedLiveType.value == bottomTab[multiLiveIndex])
      liveStreamingModel.setMultiSeats= selectedGuestSeat.value;

    liveStreamingModel.save().then((value){
      if (value.success) {
        QuickHelp.hideLoadingDialog(context);
        if(selectedLiveType.value==bottomTab[singleLiveIndex])
        Get.toNamed(AppRoutes.streamerSingleLive, arguments: {"role" : ZegoLiveRole.host});
        else if(selectedLiveType.value==bottomTab[multiLiveIndex])
          Get.toNamed(AppRoutes.streamerMultiLive, arguments: {"role" : ZegoLiveRole.host});
        else if(selectedLiveType.value==bottomTab[audioLiveIndex])
          Get.toNamed(AppRoutes.streamerAudioLive, arguments: {"role" : ZegoLiveRole.host});
        else
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
          message: error!.message,
          isError: true,
          user: Get.find<UserViewModel>().currentUser);

    }).catchError((err) {
      if (Setup.isDebug) print("Check live 19: $err");

      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showAppNotificationAdvanced(
          context: context,
          title: "live_streaming.live_set_cover_error".tr(),
          message: err,
          isError: true,
          user: Get.find<UserViewModel>().currentUser);
    });
  }

  Future updateViewers(int uid, updateType, String joinUserName, String roomID) async {

    if(uid!=liveStreamingModel.getAuthor!.getUid!){
      if(updateType == ZegoUpdateType.Add){
        liveStreamingModel.addViewersCount = 1;
        liveStreamingModel.setViewsCount = 1;
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

  closeAlert(BuildContext context, {bool forceEnded=false, bool kickOut = false}) {
    if (role!=ZegoLiveRole.host) {
      if(forceEnded==true)
      Get.toNamed(AppRoutes.endScreen, arguments: kickOut);
      else
      popBackToHomePage(forceEnded: forceEnded);
    } else {
      QuickHelp.showDialogLivEend(
        context: context,
        title: 'live_streaming.live_'.tr(),
        confirmButtonText: 'live_streaming.finish_live'.tr(),
        message: 'live_streaming.finish_live_ask'.tr(),
        onPressed: () {
          Get.back();
          Get.toNamed(AppRoutes.endScreen);
          endLive();
        },
      );
    }
  }

  Future<void> endLive() async {
    if(role==ZegoLiveRole.host){
      liveStreamingModel.setStreaming=false;
      liveStreamingModel.setLiveTime=liveTime.value.toString();
      liveStreamingModel.save();
    }
  }

  void popBackToHomePage({bool forceEnded=false}){
    if(forceEnded==true){
    Get.back();
    Get.back();
    Get.back();
    }
    else{
      Get.back();
      Get.back();
      Get.back();

    }
  }

  Future<void> startLive() async {
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

  sendGift({required String gift, required String audio, required int senderUid, required int coins, required String quantity, required String giftName,
    required String giftPath}){
    liveStreamingModel.setGift={
      LiveStreamingModel.keyGift: gift,
      LiveStreamingModel.keyGiftName: giftName,
      LiveStreamingModel.keyGiftPath: giftPath,
      LiveStreamingModel.keyReceiverUid : senderUid,
      LiveStreamingModel.keyAudio : audio,
      LiveStreamingModel.keySenderName : Get.find<UserViewModel>().currentUser.getFullName,
      LiveStreamingModel.keySenderAvatar : Get.find<UserViewModel>().currentUser.getAvatar!.url!,
      LiveStreamingModel.keySenderUid : Get.find<UserViewModel>().currentUser.getUid,
      LiveStreamingModel.keyCoins: coins ,
      LiveStreamingModel.keyQuantity: quantity ,
      LiveStreamingModel.keySenderCountry : QuickActions.getCountryFlag(Get.find<UserViewModel>().currentUser) };
    liveStreamingModel.setGifterCount = 1;
    liveStreamingModel.setTotalCoins = coins;
    liveStreamingModel.addDiamonds = coins;
    liveStreamingModel.save();
    Get.find<RankingViewModel>().addRecord(coins);
    Get.find<UserViewModel>().deductBalance(coins);
  }

  fetchViewersList() async {
    QueryBuilder<UserModel> query = QueryBuilder(UserModel.forQuery());

    query.whereContainedIn(UserModel.keyUid, liveStreamingModel.getViewersId ?? []);
    ParseResponse response = await query.query();
    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        viewerList= response.results!;
        update();
      }
      else{
        viewerList=[];
        update();
      }
    }
  }

  updateViewersList(List list){
    if(viewerList.length!=list.length)
      fetchViewersList();
  }

  //--------------  for fetching details of waiting users----------

  Future<List?> fetchUserdataRequest(List requestList) async {
    List<int> intList = requestList.map((str) => int.parse(str)).toList();

    QueryBuilder<UserModel> query = QueryBuilder(UserModel.forQuery());
    query.whereContainedIn(UserModel.keyUid, intList);
    query.includeObject([
      UserModel.keyFirstName
    ]);


    try {
      final response = await query.query();
      print("response result${response.results}");

      if (response.success) {
        List? userList = response.results ;

        return userList;

      } else {
        print('No data found.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return null;
  }

  //---------- people who are live

  Future<void> peopleWhoAreLive() async {
    List<UserModel> temp=[];
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);
    QueryBuilder<LiveStreamingModel> queryBuilder = QueryBuilder<LiveStreamingModel>(LiveStreamingModel());
    queryBuilder.whereEqualTo(LiveStreamingModel.keyStreaming, true);
    queryBuilder.whereNotEqualTo(
        LiveStreamingModel.keyAuthorUid, Get.find<UserViewModel>().currentUser.getUid);
    queryBuilder.whereNotContainedIn(
        LiveStreamingModel.keyAuthorUid, Get.find<UserViewModel>().currentUser.getBlockedUsersIds!);
    queryBuilder.whereValueExists(LiveStreamingModel.keyAuthor, true);
    queryBuilder.whereDoesNotMatchQuery(
        LiveStreamingModel.keyAuthor, queryUsers);
    queryBuilder.orderByDescending(LiveStreamingModel.keyCreatedAt);
    queryBuilder.setLimit(25);
    queryBuilder.includeObject([
      LiveStreamingModel.keyAuthor,
    ]);
    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {
        apiResponse.results!.forEach((value) {
          LiveStreamingModel liveModel = value as LiveStreamingModel;
          if(liveModel.getAuthor != null)
            temp.add(liveModel.getAuthor!);
        });
        liveUsers=temp;
        update();
      }
      else {
        liveUsers=[];
        update();
      }
    }
    else {
      liveUsers=[];
      update();
    }
  }

  // ----------------- friends------------
  Future<void> peopleWhoAreFriends() async {
    List<UserModel> temp=[];
    List result = await Get.find<UserViewModel>().getFollowersUserModel();
    result.forEach((value) {
      UserModel userModel = value as UserModel;
      temp.add(userModel);
    });
    friendsList=temp;
    update();
  }

  // ----------- multi Guest------------

  void isExpandedFeatureActive(){
    if(role == ZegoLiveRole.audience && isMultiGuest){
      Get.find<GridController>().isExpanded.value= liveStreamingModel.getExpandedFeatureActive ?? false;
      Get.find<GridController>().seat= liveStreamingModel.getExpandedFeatureIndex;
      update();}
  }

  void setExpandedFeature(bool value, int? seat){
    liveStreamingModel.setExpandedFeatureActive = value ;
    if(seat != null)
    liveStreamingModel.setExpandedFeatureIndex = seat ;
    liveStreamingModel.save();
  }

  void setYoutube(bool value, String? id){
    liveStreamingModel.setYoutube = value;
    if(id != null)
      liveStreamingModel.setYoutubeVideoId = id;

    liveStreamingModel.save();
    update();
  }

  void setYoutubeControllerValue(){
    if(isMultiGuest && role == ZegoLiveRole.audience) {
      if (liveStreamingModel.getYoutube == true) {
        if (liveStreamingModel.getYoutubeVideoId != null && Get
            .find<YoutubeController>()
            .videoId != liveStreamingModel.getYoutubeVideoId){
          Get.find<YoutubeController>().videoId=liveStreamingModel.getYoutubeVideoId!;
          Get.find<YoutubeController>().youtubePlayerController.load(liveStreamingModel.getYoutubeVideoId!);}
      if(Get.find<YoutubeController>().youtubePlayerController.value.isPlaying!=liveStreamingModel.getYoutubeVideoPlaying){
        if(liveStreamingModel.getYoutubeVideoPlaying == true)
          Get.find<YoutubeController>().youtubePlayerController.play();
        else
          Get.find<YoutubeController>().youtubePlayerController.pause();
        }
      }
    }
  }

  void youtubePlaying(bool value){
    liveStreamingModel.setYoutubeVideoPlaying = value;
    liveStreamingModel.save();
  }

  void changeMultiGuestSeatView(int seat){
    liveStreamingModel.setYoutube = false;
    Get.find<GridController>().isExpanded.value=false;
    setExpandedFeature(false,seat);
    if(seat == 3)
    liveStreamingModel.setMultiSeats = LiveStreamingModel.keyTypeMultiThreeSeat;
    else if(seat == 4)
      liveStreamingModel.setMultiSeats = LiveStreamingModel.keyTypeMultiFourSeat;
    else if(seat == 6)
      liveStreamingModel.setMultiSeats = LiveStreamingModel.keyTypeMultiSixSeat;
    else if(seat == 9)
      liveStreamingModel.setMultiSeats = LiveStreamingModel.keyTypeMultiNineSeat;
    else if(seat == 12)
      liveStreamingModel.setMultiSeats = LiveStreamingModel.keyTypeMultiTwelveSeat;
    Get.back();
    liveStreamingModel.save();
    update();
  }

  Future<void> addMultiHostUserModel(List<ZegoSDKUser> coHostList) async {
    List<int> userIDs = [];

    // Iterate through coHostList and extract userID from each item
    for (var item in coHostList) {
      userIDs.add(int.parse(item.userID));
    }

    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereContainedIn(UserModel.keyUid, userIDs);


    ParseResponse response = await queryUsers.query();
    if(response.success){
      if(response.results!=null){
        for (var item in response.results!) {
          multiGuestCoHostList.add(item as UserModel);
        }
        update();
      }
      else{
        multiGuestCoHostList=[];
        update();
      }
    }
    else{
      multiGuestCoHostList=[];
      update();
    }
    }


  void changeAudioSeatView(int seat){

    if(seat == 9)
      liveStreamingModel.setAudioSeats = 8;
    else if(seat == 12)
      liveStreamingModel.setAudioSeats = 11;
    Get.back();
    liveStreamingModel.save();
    update();
  }


  //----------------------

  // ------------

  joinOtherHostSession(String objectId){

    unSubscribeLiveStreamingModel().then((value) async {
      endLive().then((value) async {
        tempLiveStreamingModel = liveStreamingModel;
        LiveStreamingModel? otherSessionLiveStreamingModel = await getOtherHostLiveObject(objectId);
            // .then((otherSessionLiveStreamingModel){
          tempLiveStreamingModel = liveStreamingModel;
          if(otherSessionLiveStreamingModel!.objectId  !=null) {
            liveStreamingModel = otherSessionLiveStreamingModel;
            Get.find<LiveMessagesViewModel>().role= ZegoLiveRole.audience;
            role= ZegoLiveRole.audience;
            Get.find<ZegoController>().update();
            update();
            Get.find<ZegoController>().role= ZegoLiveRole.audience;
            subscribeLiveStreamingModel();
            Get.find<LiveMessagesViewModel>().unSubscribeLiveMessageModels().then((value){
              Get.find<LiveMessagesViewModel>().updateLiveMessages(
                  liveStreamingModel: otherSessionLiveStreamingModel);
              Get.find<LiveMessagesViewModel>().setupLiveMessages();
            });
          }
        });
      // });
    });


  }

  Future<LiveStreamingModel?> getOtherHostLiveObject(String objectId) async {
    QueryBuilder<LiveStreamingModel> queryBuilder = QueryBuilder<
        LiveStreamingModel>(LiveStreamingModel());

    queryBuilder.whereEqualTo(LiveStreamingModel.keyObjectId, objectId);
    queryBuilder.includeObject([
      LiveStreamingModel.keyAuthor,
      LiveStreamingModel.keyAuthorInvited,
      LiveStreamingModel.keyPrivateLiveGift,
    ]);
    ParseResponse response = await queryBuilder.query();
    if (response.success) {
      if (response.results != null){
        LiveStreamingModel live = response.results!.first! as LiveStreamingModel;
        return live;

      }

    }
  }

  backToLiveSession(){
    unSubscribeLiveStreamingModel().then((value) async {
      liveStreamingModel = tempLiveStreamingModel;
      role=ZegoLiveRole.host;
      startLive().then((value){
        update();
        Get.find<ZegoController>().role= ZegoLiveRole.host;
        Get.find<LiveMessagesViewModel>().role= ZegoLiveRole.host;
        Get.find<ZegoController>().update();
        update();
        subscribeLiveStreamingModel();
        Get.find<LiveMessagesViewModel>().unSubscribeLiveMessageModels().then((value){
          Get.find<LiveMessagesViewModel>().updateLiveMessages(
              liveStreamingModel: liveStreamingModel);
          Get.find<LiveMessagesViewModel>().setupLiveMessages();
        });


      });
    });

  }



  //---------------- join other streamer Live Session

  joinOtherStreamerLiveSession(LiveStreamingModel? otherSessionLiveStreamingModel){
    if(otherSessionLiveStreamingModel!=null){
      liveStreamingModel=otherSessionLiveStreamingModel;
      update();
      subscribeLiveStreamingModel();
      Get.find<LiveMessagesViewModel>().updateLiveMessages(liveStreamingModel:otherSessionLiveStreamingModel);
      Get.find<LiveMessagesViewModel>().setupLiveMessages();
      if(!isAudioLive)
      Get.find<ZegoController>().exitCurrentJoinOtherSession(otherSessionLiveStreamingModel);
      else
        Get.find<ZegoController>().exitAudioCurrentJoinOtherSession(otherSessionLiveStreamingModel);


    }
  }

  endLiveStreamingAndJoinOtherSession(BuildContext context, LiveStreamingModel? otherSessionLiveStreamingModel){
    if(role==ZegoLiveRole.host){
      QuickHelp.showDialogLivEend(
        context: context,
        title: 'live_streaming.live_'.tr(),
        confirmButtonText: 'live_streaming.finish_live'.tr(),
        message: 'End Stream to Join New Session?',
        onPressed: () {
          Get.back();
          endLive().then((value){
            role=ZegoLiveRole.audience;
            update();
            Get.find<ZegoController>().role= ZegoLiveRole.audience;
            Get.find<LiveMessagesViewModel>().role= ZegoLiveRole.audience;
            Get.find<ZegoController>().update();
            joinOtherStreamerLiveSession(otherSessionLiveStreamingModel);
          });
        },
      );
    }
  }


  void incrementNewFansCount(){
    liveStreamingModel.setFansCount = 1;
    liveStreamingModel.save();
  }

  void incrementCount(int coins){
    liveStreamingModel.setGifterCount = 1;
    liveStreamingModel.setTotalCoins = coins;
    liveStreamingModel.save();
  }

  void subscriberCount(){
    liveStreamingModel.setSubscriberGain = 1;
    liveStreamingModel.save();
  }

  void addComment(){
    liveStreamingModel.setComments = 1;
    liveStreamingModel.save();
  }


  runLiveTimer(){
    liveTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      liveTime.value = liveTime.value+1;
    });
  }

  cancelLiveTimer(){
    if(liveTimer.isActive)
    liveTimer.cancel();
  }

  disableRecordFeature(bool disable){
    liveStreamingModel.setDisableRecord = disable;
    liveStreamingModel.save();
  }

  disableScreenShotFeature(bool disable){
    liveStreamingModel.setDisableScreenShot = disable;
    liveStreamingModel.save();
  }

  disableGiftAnimation(bool disable){
    giftAnimation.value = true;
    update();
  }

  String filterMessage(String message) {
    List<String> words = message.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (liveStreamingModel.getFilteredList!.contains(words[i])) {
        words[i] = "******";
      }
    }
    return words.join(' ');
  }

  blockUserList(LiveStreamingModel value) async {
    if(value.getBlockedList!.length != blockList.length) {
      QueryBuilder<UserModel> query = QueryBuilder(UserModel.forQuery());
      query.whereContainedIn(
          UserModel.keyUid, value.getBlockedList!);
      ParseResponse response = await query.query();
      if (response.success) {
        if (response.results != null && response.results!.isNotEmpty) {
          blockList = response.results!;
          status = Status.Completed;
          update();
        }
        else {
          blockList = [];
          status = Status.Completed;
          update();
        }
      }
      else{
        status = Status.Completed;
        update();
      }
    }
  }

  addBlockUser(int uid){
    liveStreamingModel.setBlockedList = uid;
    liveStreamingModel.save();
    Get.find<UserViewModel>().addToBlockList(uid);

  }

  removeBlockUser(int uid){
    liveStreamingModel.removeBlockedUser = uid;
    liveStreamingModel.save();
    Get.find<UserViewModel>().removeFromBlockList(uid);
  }

  getAdminList(LiveStreamingModel value) async {
    if(value.getAdminList!.length != adminList.length) {
      QueryBuilder<UserModel> query = QueryBuilder(UserModel.forQuery());
      query.whereContainedIn(
          UserModel.keyUid, value.getAdminList!);
      ParseResponse response = await query.query();
      if (response.success) {
        if (response.results != null && response.results!.isNotEmpty) {
          adminList = response.results!;
          status = Status.Completed;
          update();
        }
        else {
          adminList = [];
          status = Status.Completed;
          update();
        }
      }
      else{
        adminList = [];
        status = Status.Completed;
        update();
      }
    }
  }

  bool isCurrentUserInAdminList() {
    return adminList.any((element) {
      UserModel user = element as UserModel;
      return user.getUid == Get.find<UserViewModel>().currentUser.getUid;
    });
  }


  addAdmin(int uid){
    liveStreamingModel.setAdminList = uid;
    liveStreamingModel.save();
  }

  removeAdmin(int uid){
    liveStreamingModel.removeAdminUser = uid;
    liveStreamingModel.save();
  }

  getDisableChatUsers(LiveStreamingModel value) async {
    if(value.getDisableChatList!.length != disableList.length) {
      QueryBuilder<UserModel> query = QueryBuilder(UserModel.forQuery());
      query.whereContainedIn(
          UserModel.keyUid, value.getDisableChatList!);
      ParseResponse response = await query.query();
      if (response.success) {
        if (response.results != null && response.results!.isNotEmpty) {
          disableList = response.results!;
          status = Status.Completed;
          update();
        }
        else {
          disableList = [];
          status = Status.Completed;
          update();
        }
      }
      else{
        status = Status.Completed;
        update();
      }
    }
  }

  addDisableChatUser(int uid){
    liveStreamingModel.setDisableChatList = uid;
    liveStreamingModel.save();
  }

  removeDisableChatUser(int uid){
    liveStreamingModel.removeDisableChatUser = uid;
    liveStreamingModel.save();
  }

  addKickOutUser(int uid){
    liveStreamingModel.setKickOutList = uid;
    liveStreamingModel.setLiveTime = liveTime.value.toString();
    liveStreamingModel.save();
  }

  checkKickOutUserList(LiveStreamingModel value) async {
    if(role == ZegoLiveRole.audience)
    if(value.getKickOutList!.contains(Get.find<UserViewModel>().currentUser.getUid)){
      closeAlert(Get.context!, forceEnded: true , kickOut: true);
    }
  }

  bool isUserInChatDisableList() {
    if(role == ZegoLiveRole.audience)
      if(liveStreamingModel.getDisableChatList!.contains(Get.find<UserViewModel>().currentUser.getUid)){
        return true;
      }
    else{
      return false;
      }
    else
      return false;
  }

  changeBackgroundImage(LiveStreamingModel value){
    if(value.getBackgroundImage != null && value.getBackgroundImage == backgroundImage.value)
    backgroundImage.value = value.getBackgroundImage!;
  }

  addGifterList(Map value){
    if(value[LiveStreamingModel.keyReceiverUid] == liveStreamingModel.getAuthorUid){
      if(hostGiftersAvatar.contains(value[LiveStreamingModel.keySenderAvatar])==false)
      hostGiftersAvatar.insert(0,value[LiveStreamingModel.keySenderAvatar]);
      addValueToHostGifters(value);
      update();
      saveGifterList(value,value[LiveStreamingModel.keySenderAvatar] );
    }
  }

  void addValueToHostGifters(Map value) {
    bool found = false;

    for (var gifter in hostGifters) {
      if (gifter[LiveStreamingModel.keySenderUid] == value[LiveStreamingModel.keySenderUid]) {
        gifter[LiveStreamingModel.keyCoins] += value[LiveStreamingModel.keyCoins];
        found = true;
        break;
      }
    }

    if (!found) {
      hostGifters.add(value);
    }
  }

  saveGifterList(Map gifter, String avatar){
   liveStreamingModel.setGifterAvatarList = avatar;
   liveStreamingModel.setGifterList = gifter;
   liveStreamingModel.save();
  }

  setGifterList(){
    if(liveStreamingModel.getGifterAvatarList!.isNotEmpty){
      liveStreamingModel.getGifterAvatarList!.forEach((element) {
        String value = element;
        if(hostGiftersAvatar.contains(value)==false)
          hostGiftersAvatar.insert(0,value);
      }) ;
    }
    if(liveStreamingModel.getGifterList!.isNotEmpty){
      liveStreamingModel.getGifterList!.forEach((element) {
        Map value = element;
        addValueToHostGifters(value);
      }) ;
    }
  }

  addGiftCoins(Map value){
    if(value[LiveStreamingModel.keyReceiverUid] == Get.find<UserViewModel>().currentUser.getUid) {
      Get.find<UserViewModel>().addBalance(value[LiveStreamingModel.keyCoins]).then((value) => update());
      }
    }


    showGiftReceiverBanner(Map value){
    if(Get.find<UserViewModel>().currentUser.getUid == value[LiveStreamingModel.keyReceiverUid]){
     senderDetail = {
       LiveStreamingModel.keySenderName : value[LiveStreamingModel.keySenderName],
       LiveStreamingModel.keySenderAvatar : value[LiveStreamingModel.keySenderAvatar],
       LiveStreamingModel.keyGiftPath : value[LiveStreamingModel.keyGiftPath],
       LiveStreamingModel.keyGiftName : value[LiveStreamingModel.keyGiftName],
       LiveStreamingModel.keyQuantity : value[LiveStreamingModel.keyQuantity],
     } ;
     showGiftBanner.value = true;
     Future.delayed(Duration(seconds: 10), () {
       showGiftBanner.value = false;
     });
    }}

  LiveViewModel(this.role, this.liveModel);

  @override
  void onInit() {
    role=this.role;
    if(role==ZegoLiveRole.audience){
      liveStreamingModel=this.liveModel!;
      giftListLength=liveStreamingModel.getGiftsList!.length;
      if(liveStreamingModel.getMyWishList!= null)
        myWishList = liveStreamingModel.getMyWishList!;
      setGifterList();
      updateLiveStreamingModel();
    }
    if(role==ZegoLiveRole.host){
      runLiveTimer();
      endPreviousLiveStreaming();
     }
    Wakelock.enable();


    super.onInit();
  }

  @override
  void onClose() {
    endLive();
    if(role == ZegoLiveRole.host)
    cancelLiveTimer();
    Wakelock.disable();

    super.onClose();
  }


}


