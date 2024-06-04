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
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import 'multi_guest_grid_controller.dart';


class LiveViewModel extends GetxController {
  final ZegoLiveRole role;
  final LiveStreamingModel? liveModel;

  //---- live preview-------
  final List bottomTab = [
    LiveStreamingModel.keyTypeMultiGuestLive,
    LiveStreamingModel.keyTypeSingleLive,
    LiveStreamingModel.keyTypeAudioLive,
    LiveStreamingModel.keyTypeGameLive,
  ];

  int multiLiveIndex=0;
  int singleLiveIndex=1;
  int audioLiveIndex=2;
  int gameLiveIndex=3;

  final RxInt nineMemberIndex = 0.obs;
  final RxString selectedGuestSeat = "4P".obs;
  //--------------------

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
  RxString selectedLiveType=LiveStreamingModel.keyTypeSingleLive.obs;
  List viewerList=[];

  //------ people who are live list
  List<UserModel> liveUsers=[];

  //------ people who are live list
  List<UserModel> friendsList=[];

  Widget? video;

  List<UserModel> multiGuestCoHostList=[];
  List<UserModel> audioCoHostList=[];




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

      updateViewersList(value.getViewersId ?? []);
      isExpandedFeatureActive();

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
    // liveStreamingModel.setImage = parseFile!;
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
        LiveStreamingModel.keyAuthor, Get.find<UserViewModel>().currentUser.getBlockedUsers!);
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


