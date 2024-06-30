import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../parse/GiftsSentModel.dart';
import '../parse/LiveMessagesModel.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'live_controller.dart';


class LiveMessagesViewModel extends GetxController {
  late LiveViewModel liveViewModel;
  late ZegoLiveRole role;

  List<LiveMessagesModel> liveMessagesModelList=[];
  LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  bool showDisclaimerMessage=true;



  updateLiveMessagingModel(){
    update();
  }

  set setDisclaimerMessageValue(bool value){
    showDisclaimerMessage=value;
    update();
  }


  setupLiveMessages() async {
    QueryBuilder<LiveMessagesModel> queryBuilder = QueryBuilder<LiveMessagesModel>(LiveMessagesModel());

    queryBuilder.whereEqualTo(LiveMessagesModel.keyLiveStreamingId,
        liveViewModel.liveStreamingModel.objectId);
    queryBuilder.orderByDescending(LiveMessagesModel.keyCreatedAt);


    queryBuilder.includeObject([
      LiveMessagesModel.keySenderAuthor,
      LiveMessagesModel.keyLiveStreaming,
      LiveMessagesModel.keyGiftSent,
      LiveMessagesModel.keyGiftSentGift
    ]);

    subscription = await liveQuery.client.subscribe(queryBuilder);

    subscription!.on(LiveQueryEvent.create, (liveMessage) async {
      print('*** enter ***setupLiveMessage');
      LiveMessagesModel message = liveMessage as LiveMessagesModel;
      if((message.getMessageType == LiveMessagesModel.messageTypeComment && message.getAuthorId == Get.find<UserViewModel>().currentUser.getUid!.toString())==false) {
        liveMessagesModelList.insert(0, liveMessage);
        update();
      }
    });
  }

  updateLiveMessages({LiveStreamingModel? liveStreamingModel}) async {
    liveMessagesModelList=[];
    QueryBuilder<LiveMessagesModel> queryBuilder = QueryBuilder<LiveMessagesModel>(LiveMessagesModel());

    queryBuilder.whereEqualTo(LiveMessagesModel.keyLiveStreamingId,
        liveStreamingModel!=null ? liveStreamingModel.objectId : liveViewModel.liveStreamingModel.objectId);
    queryBuilder.orderByAscending(LiveMessagesModel.keyCreatedAt);


    queryBuilder.includeObject([
      LiveMessagesModel.keySenderAuthor,
      LiveMessagesModel.keyLiveStreaming,
      LiveMessagesModel.keyGiftSent,
      LiveMessagesModel.keyGiftSentGift
    ]);

    ParseResponse response = await queryBuilder.query();
    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        for (var result in response.results!) {
          // Assuming result is a Map with a 'message' key
          liveMessagesModelList.insert(0,result as LiveMessagesModel);
          update();
        }
      }
    }
  }


  Future<void> unSubscribeLiveMessageModels() async {
    liveMessagesModelList=[];
    if (subscription != null) {
      liveQuery.client.unSubscribe(subscription!);
    }
    subscription = null;
  }


  sendMessage(
      String messageType,
      String message,{
        GiftsSentModel? giftsSent,
        required String senderName,
        required int uid,
        required String senderAvatarUrl,
        String? imagePath
      }) async {

    LiveMessagesModel liveMessagesModel = new LiveMessagesModel();

     liveMessagesModel.setAuthorId = uid.toString();

    liveMessagesModel.setAuthorAvatarUrl= senderAvatarUrl ?? '';

    liveMessagesModel.setSenderName = senderName;

    liveMessagesModel.setLiveStreaming = liveViewModel.liveStreamingModel;
    liveMessagesModel.setLiveStreamingId =
    liveViewModel.liveStreamingModel.objectId!;


    liveMessagesModel.setMessage = message;
    liveMessagesModel.setMessageType = messageType;
    if(liveMessagesModel.getMessageType == LiveMessagesModel.messageTypeComment){
      liveMessagesModelList.insert(0, liveMessagesModel);
      update();}
    await liveMessagesModel.save();

  }

  sendMessageJoinOrLeft(
  String messageType,
  String message,{
  required String senderName,
  required int uid}) async {
    UserModel user;
    if(role == ZegoLiveRole.host) {
      QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
      queryUsers.whereEqualTo(UserModel.keyUid, uid);

      ParseResponse response = await queryUsers.query();
      if (response.success && response.results != null) {
        user = response.results!.first as UserModel;

        sendMessage(messageType, message, senderName: senderName,
            uid: uid,
            senderAvatarUrl: user.getAvatar!.url!);
      }
    }
  }

  Future delayedFunctions() async {
      if(role==ZegoLiveRole.host) {
        // Future.delayed(Duration(seconds: 2), () {
          sendMessage(
            LiveMessagesModel.messageTypeSystem,
            "The broadcaster has started live streaming",
            senderName: Get
                .find<UserViewModel>()
                .currentUser
                .getFullName!,
            uid: Get
                .find<UserViewModel>()
                .currentUser
                .getUid!,
            senderAvatarUrl: Get
                .find<UserViewModel>()
                .currentUser
                .getAvatar!
                .url!,
          );
        // });
      }

  }



  LiveMessagesViewModel(this.liveViewModel);

  @override
  void onInit() {
    liveViewModel = this.liveViewModel;
    role = liveViewModel.role;
    setupLiveMessages();
    delayedFunctions();
    if(role==ZegoLiveRole.audience)
    updateLiveMessages();

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    unSubscribeLiveMessageModels();
    // TODO: implement onClose
    super.onClose();
  }


}


