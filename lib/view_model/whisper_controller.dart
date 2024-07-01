
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:teego/parse/WhisperListModel.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:teego/view_model/whisper_list_controller.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../helpers/quick_help.dart';
import '../helpers/send_notifications.dart';
import '../parse/WhisperModel.dart';
import '../parse/UserModel.dart';
import '../utils/utilsConstants.dart';
import 'dart:io';


class WhisperViewModel extends GetxController {

  TextEditingController messageController = TextEditingController();

  UserModel? currentUser, mUser;


  int currentView = 0;
  List<Widget>? pages;

  var initialLoad;

  //Live query stuff
  late QueryBuilder<WhisperModel> queryBuilder;
  final LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  List<dynamic> results = <dynamic>[];

  GroupedItemScrollController listScrollController =
  GroupedItemScrollController();


  updateMessageList(WhisperListModel whisperListModel) async {
    whisperListModel.setIsRead = true;
    whisperListModel.setCounter = 0;
    await whisperListModel.save();
  }

  updateMessageStatus(WhisperModel whisperModel) async {
    whisperModel.setIsRead = true;
    await whisperModel.save();
  }

  Future<void> _objectUpdated(WhisperModel object) async {
    for (int i = 0; i < results.length; i++) {
      if (results[i].get<String>(keyVarObjectId) ==
          object.get<String>(keyVarObjectId)) {
        if (UtilsConstant.afterForWhisper(results[i], object) == null) {
            // ignore: invalid_use_of_protected_member
            results[i] = object.clone(object.toJson(full: true));
            update();
        }
        break;
      }
    }
  }
  //
  // setupLiveQuery() async {
  //   if (subscription == null) {
  //     subscription = await liveQuery.client.subscribe(queryBuilder);
  //   }
  //
  //   subscription!.on(LiveQueryEvent.create, (WhisperModel message) {
  //     if (message.getAuthorId == mUser!.objectId) {
  //       results.add(message);
  //       // update();
  //     } else {
  //       // update();
  //     }
  //   });
  //
  //   subscription!.on(LiveQueryEvent.update, (WhisperModel message) {
  //     _objectUpdated(message);
  //   });
  // }

  Future<List<dynamic>?> loadMessages() async {

    QueryBuilder<WhisperModel> queryFrom =
    QueryBuilder<WhisperModel>(WhisperModel());

    queryFrom.whereEqualTo(WhisperModel.keyAuthor, currentUser!);

    queryFrom.whereEqualTo(WhisperModel.keyReceiver, mUser!);

    QueryBuilder<WhisperModel> queryTo =
    QueryBuilder<WhisperModel>(WhisperModel());
    queryTo.whereEqualTo(WhisperModel.keyAuthor, mUser!);
    queryTo.whereEqualTo(WhisperModel.keyReceiver, currentUser!);

    queryBuilder = QueryBuilder.or(WhisperModel(), [queryFrom, queryTo]);
    queryBuilder.orderByDescending(WhisperModel.keyCreatedAt);
    queryBuilder.whereEqualTo(WhisperModel.keyLiveStreamingId, Get.find<LiveViewModel>().liveStreamingModel.objectId);


    // setupLiveQuery();

    queryBuilder.includeObject([
      WhisperModel.keyCall,
      WhisperModel.keyAuthor,
      WhisperModel.keyReceiver,
      WhisperModel.keyListMessage,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      print("Messages count: ${apiResponse.results!.length}");
      if (apiResponse.results != null) {
        List result = apiResponse.results!;
        return result;
      } else {
        return AsyncSnapshot.nothing() as dynamic;
      }
    } else {
      return apiResponse.error as dynamic;
    }
  }

  Future saveMessage(String messageText,
      {String? gif, int? coins, int? amount,
        required String messageType,
        ParseFileBase? pictureFile, required Function() onTap}) async {
    if (messageText.isNotEmpty) {
      WhisperModel message = WhisperModel();

      message.setAuthor = currentUser!;
      message.setAuthorId = currentUser!.objectId!;

      if (pictureFile != null) {
        message.setPictureMessage = pictureFile;
      }

      message.setLiveStreamingId = Get.find<LiveViewModel>().liveStreamingModel.objectId!;

      message.setReceiver = mUser!;
      message.setReceiverId = mUser!.objectId!;

      message.setDuration = messageText;
      message.setIsMessageFile = false;

      message.setMessageType = messageType;

      message.setIsRead = false;

      if (gif != null) {
        message.setGifUrl = gif;
        message.settGifCoins= coins!;
        message.setGifAmount= amount!;
      }

      results.insert(0, message as dynamic);


      await message.save();


      _saveList(message);

      // SendNotifications.sendPush(
      //     currentUser!, mUser!, SendNotifications.typeChat,
      //     message: getMessageType(messageType, currentUser!.getFullName!,
      //         message: messageText));
    }
  }

  String getMessageType(String type, String name, {String? message}) {
    if (type == WhisperModel.messageTypeGif) {
      return "push_notifications.new_gif_title".tr(namedArgs: {"name": name});
    } else if (type == WhisperModel.messageTypePicture) {
      return "push_notifications.new_picture_title"
          .tr(namedArgs: {"name": name});
    } else {
      return message!;
    }
  }

  // Update or Create message list
  _saveList(WhisperModel whisperModel) async {
    QueryBuilder<WhisperListModel> queryFrom =
    QueryBuilder<WhisperListModel>(WhisperListModel());
    queryFrom.whereEqualTo(
        WhisperListModel.keyListId, currentUser!.objectId! + mUser!.objectId!);

    QueryBuilder<WhisperListModel> queryTo =
    QueryBuilder<WhisperListModel>(WhisperListModel());
    queryTo.whereEqualTo(
        WhisperListModel.keyListId, mUser!.objectId! + currentUser!.objectId!);

    QueryBuilder<WhisperListModel> queryBuilder =
    QueryBuilder.or(WhisperListModel(), [queryFrom, queryTo]);
    queryBuilder.whereEqualTo(WhisperListModel.keyLiveStreamingId, Get.find<LiveViewModel>().liveStreamingModel!.objectId!);


    ParseResponse parseResponse = await queryBuilder.query();

    if (parseResponse.success) {
      if (parseResponse.results != null) {
        WhisperListModel whisperListModel = parseResponse.results!.first;

        whisperListModel.setAuthor = currentUser!;
        whisperListModel.setAuthorId = currentUser!.objectId!;

        whisperListModel.setReceiver = mUser!;
        whisperListModel.setReceiverId = mUser!.objectId!;

        whisperListModel.setLiveStreamingId = Get.find<LiveViewModel>().liveStreamingModel.objectId!;

        whisperListModel.setMessage = whisperModel;
        whisperListModel.setMessageId = whisperModel.objectId!;
        whisperListModel.setText = whisperModel.getDuration!;
        whisperListModel.setIsMessageFile = false;

        whisperListModel.setMessageType = whisperModel.getMessageType!;

        whisperListModel.setIsRead = false;
        whisperListModel.setListId = currentUser!.objectId! + mUser!.objectId!;

        whisperListModel.incrementCounter = 1;
        await whisperListModel.save();

        whisperModel.setMessageList = whisperListModel;
        whisperModel.setMessageListId = whisperListModel.objectId!;

        await whisperModel.save();
      } else {
        WhisperListModel whisperListModel = WhisperListModel();

        whisperListModel.setAuthor = currentUser!;
        whisperListModel.setAuthorId = currentUser!.objectId!;

        whisperListModel.setReceiver = mUser!;
        whisperListModel.setReceiverId = mUser!.objectId!;

        whisperListModel.setLiveStreamingId = Get.find<LiveViewModel>().liveStreamingModel!.objectId!;


        whisperListModel.setMessage = whisperModel;
        whisperListModel.setMessageId = whisperModel.objectId!;
        whisperListModel.setText = whisperModel.getDuration!;
        whisperListModel.setIsMessageFile = false;

        whisperListModel.setMessageType = whisperModel.getMessageType!;

        whisperListModel.setListId = currentUser!.objectId! + mUser!.objectId!;
        whisperListModel.setIsRead = false;

        whisperListModel.incrementCounter = 1;
        await whisperListModel.save();

        whisperModel.setMessageList = whisperListModel;
        whisperModel.setMessageListId = whisperListModel.objectId!;
        await whisperModel.save();
      }
    }
  }
  
  void setInitialLoad(){
    Future.delayed(Duration(microseconds: 100), () async {
      initialLoad = await loadMessages();
      update();
    });
  }

  WhisperViewModel(this.mUser);

  @override
  void onInit() {
    Future.delayed(Duration(microseconds: 100), (){
        initialLoad = loadMessages();
        update();
    });

      currentUser = Get.find<UserViewModel>().currentUser;
      mUser = this.mUser;

    super.onInit();
  }

  @override
  void onClose() {
    messageController.dispose();

    if (subscription != null) {
      liveQuery.client.unSubscribe(subscription!);
    }

    // TODO: implement onClose
    super.onClose();
  }


}


