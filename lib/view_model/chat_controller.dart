
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:teego/parse/MessageListModel.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../helpers/quick_help.dart';
import '../helpers/send_notifications.dart';
import '../parse/MessageModel.dart';
import '../parse/UserModel.dart';
import '../utils/utilsConstants.dart';
import 'dart:io';


class ChatViewModel extends GetxController {

  TextEditingController messageController = TextEditingController();

  UserModel? currentUser, mUser;

  String? sendButtonIcon = "assets/svg/ic_menu_gifters.svg";
  Color sendButtonBackground = AppColors.yellowBtnColor;

  var uploadPhoto;
  ParseFileBase? parseFile;
  int? _countSelectedPictures = 0;

  RxString text= ''.obs;


  int currentView = 0;
  List<Widget>? pages;

  var initialLoad;

  //Live query stuff
  late QueryBuilder<MessageModel> queryBuilder;
  final LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  List<dynamic> results = <dynamic>[];

  GroupedItemScrollController listScrollController =
  GroupedItemScrollController();


  updateMessageList(MessageListModel messageListModel) async {
    messageListModel.setIsRead = true;
    messageListModel.setCounter = 0;
    await messageListModel.save();
  }

  updateMessageStatus(MessageModel messageModel) async {
    messageModel.setIsRead = true;
    await messageModel.save();
  }

  Future<void> _objectUpdated(MessageModel object) async {
    for (int i = 0; i < results.length; i++) {
      if (results[i].get<String>(keyVarObjectId) ==
          object.get<String>(keyVarObjectId)) {
        if (UtilsConstant.after(results[i], object) == null) {
            // ignore: invalid_use_of_protected_member
            results[i] = object.clone(object.toJson(full: true));
            update();
        }
        break;
      }
    }
  }

  setupLiveQuery() async {
    if (subscription == null) {
      subscription = await liveQuery.client.subscribe(queryBuilder);
    }

    subscription!.on(LiveQueryEvent.create, (MessageModel message) {
      if (message.getAuthorId == mUser!.objectId) {
          results.add(message);
          update();

      } else {
        update();
      }
    });

    subscription!.on(LiveQueryEvent.update, (MessageModel message) {
      _objectUpdated(message);
    });
  }

  Future<List<dynamic>?> loadMessages() async {

    QueryBuilder<MessageModel> queryFrom =
    QueryBuilder<MessageModel>(MessageModel());

    queryFrom.whereEqualTo(MessageModel.keyAuthor, currentUser!);

    queryFrom.whereEqualTo(MessageModel.keyReceiver, mUser!);

    QueryBuilder<MessageModel> queryTo =
    QueryBuilder<MessageModel>(MessageModel());
    queryTo.whereEqualTo(MessageModel.keyAuthor, mUser!);
    queryTo.whereEqualTo(MessageModel.keyReceiver, currentUser!);

    queryBuilder = QueryBuilder.or(MessageModel(), [queryFrom, queryTo]);
    queryBuilder.orderByDescending(MessageModel.keyCreatedAt);

    setupLiveQuery();

    queryBuilder.includeObject([
      MessageModel.keyCall,
      MessageModel.keyAuthor,
      MessageModel.keyReceiver,
      MessageModel.keyListMessage,
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
      MessageModel message = MessageModel();

      message.setAuthor = currentUser!;
      message.setAuthorId = currentUser!.objectId!;

      if (pictureFile != null) {
        message.setPictureMessage = pictureFile;
      }

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
      update();


      await message.save();


      _saveList(message);

      // SendNotifications.sendPush(
      //     currentUser!, mUser!, SendNotifications.typeChat,
      //     message: getMessageType(messageType, currentUser!.getFullName!,
      //         message: messageText));
    }
  }

  String getMessageType(String type, String name, {String? message}) {
    if (type == MessageModel.messageTypeGif) {
      return "push_notifications.new_gif_title".tr(namedArgs: {"name": name});
    } else if (type == MessageModel.messageTypePicture) {
      return "push_notifications.new_picture_title"
          .tr(namedArgs: {"name": name});
    } else {
      return message!;
    }
  }

  // Update or Create message list
  _saveList(MessageModel messageModel) async {
    QueryBuilder<MessageListModel> queryFrom =
    QueryBuilder<MessageListModel>(MessageListModel());
    queryFrom.whereEqualTo(
        MessageListModel.keyListId, currentUser!.objectId! + mUser!.objectId!);

    QueryBuilder<MessageListModel> queryTo =
    QueryBuilder<MessageListModel>(MessageListModel());
    queryTo.whereEqualTo(
        MessageListModel.keyListId, mUser!.objectId! + currentUser!.objectId!);

    QueryBuilder<MessageListModel> queryBuilder =
    QueryBuilder.or(MessageListModel(), [queryFrom, queryTo]);

    ParseResponse parseResponse = await queryBuilder.query();

    if (parseResponse.success) {
      if (parseResponse.results != null) {
        MessageListModel messageListModel = parseResponse.results!.first;

        messageListModel.setAuthor = currentUser!;
        messageListModel.setAuthorId = currentUser!.objectId!;

        messageListModel.setReceiver = mUser!;
        messageListModel.setReceiverId = mUser!.objectId!;

        messageListModel.setMessage = messageModel;
        messageListModel.setMessageId = messageModel.objectId!;
        messageListModel.setText = messageModel.getDuration!;
        messageListModel.setIsMessageFile = false;

        messageListModel.setMessageType = messageModel.getMessageType!;

        messageListModel.setIsRead = false;
        messageListModel.setListId = currentUser!.objectId! + mUser!.objectId!;

        messageListModel.incrementCounter = 1;
        await messageListModel.save();

        messageModel.setMessageList = messageListModel;
        messageModel.setMessageListId = messageListModel.objectId!;

        await messageModel.save();
      } else {
        MessageListModel messageListModel = MessageListModel();

        messageListModel.setAuthor = currentUser!;
        messageListModel.setAuthorId = currentUser!.objectId!;

        messageListModel.setReceiver = mUser!;
        messageListModel.setReceiverId = mUser!.objectId!;

        messageListModel.setMessage = messageModel;
        messageListModel.setMessageId = messageModel.objectId!;
        messageListModel.setText = messageModel.getDuration!;
        messageListModel.setIsMessageFile = false;

        messageListModel.setMessageType = messageModel.getMessageType!;

        messageListModel.setListId = currentUser!.objectId! + mUser!.objectId!;
        messageListModel.setIsRead = false;

        messageListModel.incrementCounter = 1;
        await messageListModel.save();

        messageModel.setMessageList = messageListModel;
        messageModel.setMessageListId = messageListModel.objectId!;
        await messageModel.save();
      }
    }
  }

  choosePhotoFromCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      cropPhoto(image.path,context);
    } else {
      print("Photos null");
    }



    // final List<AssetEntity>? result = await AssetPicker.pickAssets(
    //   context,
    //   pickerConfig: AssetPickerConfig(
    //       maxAssets: 1,
    //       requestType: RequestType.image,
    //       filterOptions: FilterOptionGroup(
    //         containsLivePhotos: false,
    //       )),
    // );
    //
    // if (result != null && result.length > 0) {
    //   final File? image = await result.first.file;
    //   cropPhoto(image!.path, context);
    // } else {
    //   print("Photos null");
    // }
  }

  choosePhotoFromGallery(BuildContext context, {bool upload=false}) async {

    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          filterOptions: FilterOptionGroup(
            containsLivePhotos: false,
          )),
    );

    if (result != null && result.length > 0) {
      final File? image = await result.first.file;
      cropPhoto(image!.path, context, upload: upload);
    } else {
      print("Photos null");
    }
  }

  void cropPhoto(String path, BuildContext context, {bool upload=false}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "edit_photo".tr(),
              toolbarColor: AppColors.navBarColor,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: false),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ]);

    if (croppedFile != null) {
      compressImage(croppedFile.path, context, upload: upload);
    }
  }

  void compressImage(String path, BuildContext context, {bool upload=false}) {

    // QuickHelp.showLoadingAnimation();

    Future.delayed(Duration(seconds: 1), () async{
      var result = await QuickHelp.compressImage(path);

      if(result != null){

        uploadFile(result, upload: upload);

      } else {

        QuickHelp.hideLoadingDialog(context);

        QuickHelp.showAppNotificationAdvanced(
          context: context,
          title: "crop_image_scree.cancelled_by_user".tr(),
          message: "crop_image_scree.image_not_cropped_error".tr(),
        );
      }
    });
  }



  uploadFile(File imageFile, {bool upload=false}) async {

    // if(imageFile.absolute.path.isNotEmpty){
    //   parseFile = ParseFile(File(imageFile.absolute.path), name: "avatar.jpg");
    //
    //   //print("Image path ${imageFile.absolute.path}");
    //
    //   setState(() {
    //     uploadPhoto = imageFile.absolute.path;
    //   });
    //
    // } else {

    if(upload==true){
    uploadPhoto = await imageFile.readAsBytes();
    update();}
    else{
      parseFile = ParseWebFile(imageFile.readAsBytesSync(), name: "avatar.jpg");
      if (parseFile != null) {
        saveMessage(
            MessageModel.messageTypePicture,
            messageType:
            MessageModel.messageTypePicture,
            pictureFile: parseFile, onTap: () {  });
        // QuickHelp.hideLoadingDialog(context);
        parseFile = null;
        uploadPhoto = null;
        update();
        // Navigator.of(context).pop();
      }
    }


    // }

    // QuickHelp.showLoadingDialog(context);
    //
    // ParseResponse parseResponse = await parseFile!.save();
    // if (parseResponse.success) {
    //   QuickHelp.hideLoadingDialog(context);
    // } else {
    //   QuickHelp.showLoadingDialog(context);
    //   QuickHelp.showAppNotification(
    //       context: context, title: parseResponse.error!.message);
    //
    // }
  }


  void changeButtonIcon(String text) {
      if (text.isNotEmpty) {
        sendButtonIcon = "assets/svg/ic_send_message.svg";
        sendButtonBackground = Color(0xFFFFC107);
      } else {
        sendButtonIcon = "assets/svg/ic_menu_gifters.svg";
        sendButtonBackground =  Color(0xFF42A5F5);
      }
      update();
  }

  void setInitialLoad(){
    Future.delayed(Duration(microseconds: 100), () async {
      initialLoad = await loadMessages();
      update();
    });
  }

  ChatViewModel(this.mUser);

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


