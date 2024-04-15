import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../parse/GiftsSentModel.dart';
import '../parse/LiveMessagesModel.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'live_controller.dart';


class LiveMessagesViewModel extends GetxController {
  final ZegoLiveRole role = Get.find<LiveViewModel>().role;

  List liveMessagesModelList=[].obs;
  LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  RxBool showDisclaimerMessage=true.obs;



  updateLiveMessagingModel(){
    update();
  }


  setupLiveMessages() async {
    QueryBuilder<LiveMessagesModel> queryBuilder = QueryBuilder<LiveMessagesModel>(LiveMessagesModel());

    queryBuilder.whereEqualTo(LiveMessagesModel.keyLiveStreamingId,
        Get.find<LiveViewModel>().liveStreamingModel.objectId);
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

      liveMessagesModelList.add(liveMessage as LiveMessagesModel);

    });

  }


  unSubscribeLiveMessageModels() async {
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

    if(messageType==LiveMessagesModel.messageTypeJoin || messageType==LiveMessagesModel.messageTypeComment ){
      liveMessagesModel.setJoinUserName= senderName;
    }
    liveMessagesModel.setAuthorAvatarUrl= senderAvatarUrl ?? '';

    if(messageType==LiveMessagesModel.messageTypeGift){
      liveMessagesModel.setSenderName = senderName;
      liveMessagesModel.setImagePath = imagePath!;
    }

    liveMessagesModel.setLiveStreaming = Get.find<LiveViewModel>().liveStreamingModel;
    liveMessagesModel.setLiveStreamingId =
    Get.find<LiveViewModel>().liveStreamingModel.objectId!;

    if (giftsSent != null) {
      liveMessagesModel.setGiftSent = giftsSent;
      liveMessagesModel.setGiftSentId = giftsSent.objectId!;
      liveMessagesModel.setGiftId = giftsSent.getGiftId!;
    }

    liveMessagesModel.setMessage = message;
    liveMessagesModel.setMessageType = messageType;
    await liveMessagesModel.save();
  }

  Future delayedFunctions() async {
    Future.delayed(Duration(seconds: 6), () {
      showDisclaimerMessage.value=false;
      if(role==ZegoLiveRole.host) {
        Future.delayed(Duration(seconds: 2), () {
          sendMessage(
            LiveMessagesModel.messageTypeSystem,
            "The broadcaster invites you to join PK",
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
        });
      }
    });
  }



  LiveMessagesViewModel();

  @override
  void onInit() {
    setupLiveMessages();
    delayedFunctions();

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


