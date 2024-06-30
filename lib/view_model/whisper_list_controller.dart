import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/WhisperListModel.dart';
import 'package:teego/utils/constants/status.dart';
import 'package:teego/view_model/userViewModel.dart';

import 'live_controller.dart';


class WhisperListViewModel extends GetxController {

  late QueryBuilder<WhisperListModel> queryBuilder;
  final LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  List<dynamic> messagesResults = <dynamic>[];

  Status status = Status.Loading;



  Future<dynamic> loadMessagesList() async {
    disposeLiveQuery();

    QueryBuilder<WhisperListModel> queryFrom = QueryBuilder<WhisperListModel>(WhisperListModel());
    queryFrom.whereEqualTo(WhisperListModel.keyAuthorId, Get.find<UserViewModel>().currentUser.objectId!);

    QueryBuilder<WhisperListModel> queryTo = QueryBuilder<WhisperListModel>(WhisperListModel());
    queryTo.whereEqualTo(WhisperListModel.keyReceiverId, Get.find<UserViewModel>().currentUser.objectId!);


    queryBuilder = QueryBuilder.or(WhisperListModel(), [queryFrom, queryTo]);
    queryBuilder.whereEqualTo(WhisperListModel.keyLiveStreamingId, Get.find<LiveViewModel>().liveStreamingModel!.objectId!);

    queryBuilder.orderByDescending(keyVarUpdatedAt);

    queryBuilder.includeObject([WhisperListModel.keyAuthor, WhisperListModel.keyReceiver, WhisperListModel.keyMessage, WhisperListModel.keyCall]);

    queryBuilder.setLimit(50);
    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      setupLiveQuery();
      if (apiResponse.results != null) {



        messagesResults = apiResponse.results as List<dynamic>;
        status = Status.Completed;
        update();
      } else {
        messagesResults = [];
        status = Status.Completed;
        update();
      }
    } else {
      messagesResults = [];
      status = Status.Completed;
      update();
    }
  }

  Future<void> _objectUpdated(WhisperListModel object) async {
    for (int i = 0; i < messagesResults.length; i++) {
      if (messagesResults[i].get<String>(keyVarObjectId) ==
          object.get<String>(keyVarObjectId)) {
        if (afterMessages(messagesResults[i], object) == null) {
            // ignore: invalid_use_of_protected_member
            messagesResults[i] = object.clone(object.toJson(full: true));
            update();
        }
        break;
      }
    }
  }

  Future<void> _objectDeleted(WhisperListModel object) async {
    for (int i = 0; i < messagesResults.length; i++) {
      if (messagesResults[i].get<String>(keyVarObjectId) ==
          object.get<String>(keyVarObjectId)) {

          // ignore: invalid_use_of_protected_member
          messagesResults.removeAt(i);
          update();

        break;
      }
    }
  }

  setupLiveQuery() async {
    if (subscription == null) {
      subscription = await liveQuery.client.subscribe(queryBuilder);
    }

    subscription!.on(LiveQueryEvent.create, (WhisperListModel whisperListModel) async {
      await whisperListModel.getAuthor!.fetch();
      await whisperListModel.getReceiver!.fetch();
      /*if (post.getLastLikeAuthor != null) {
        await post.getLastLikeAuthor!.fetch();
      }*/

        messagesResults.add(whisperListModel);
        update();
    });

    subscription!.on(LiveQueryEvent.enter, (WhisperListModel whisperListModel) async {
      await whisperListModel.getAuthor!.fetch();
      await whisperListModel.getReceiver!.fetch();

      /*if (post.getLastLikeAuthor != null) {
        await post.getLastLikeAuthor!.fetch();
      }*/

        messagesResults.add(whisperListModel);
        update();

    });

    subscription!.on(LiveQueryEvent.update, (WhisperListModel whisperListModel) async {

      await whisperListModel.getAuthor!.fetch();
      await whisperListModel.getReceiver!.fetch();

      /*if (post.getLastLikeAuthor != null) {
        await post.getLastLikeAuthor!.fetch();
      }*/

      _objectUpdated(whisperListModel);
    });

    subscription!.on(LiveQueryEvent.delete, (WhisperListModel post) {

      _objectDeleted(post);
    });
  }


  disposeLiveQuery() {
    if (subscription != null) {
      liveQuery.client.unSubscribe(subscription!);
      subscription = null;
    }
  }


  static bool? afterMessages(WhisperListModel object1, WhisperListModel object2) {
    List<String> fields = <String>[];


    fields.add(keyVarCreatedAt);
    for (String key in fields) {
      bool reverse = false;
      if (key.startsWith('-')) {
        reverse = true;
        key = key.substring(1);
      }
      final dynamic val1 = object1.get<dynamic>(key);
      final dynamic val2 = object2.get<dynamic>(key);

      if (val1 == null && val2 == null) {
        break;
      }
      if (val1 == null) {
        return reverse;
      }
      if (val2 == null) {
        return !reverse;
      }

      if (val1 is num && val2 is num) {
        if (val1 < val2) {
          return reverse;
        }
        if (val1 > val2) {
          return !reverse;
        }
      } else if (val1 is String && val2 is String) {
        if (val1.toString().compareTo(val2) < 0) {
          return reverse;
        }
        if (val1.toString().compareTo(val2) > 0) {
          return !reverse;
        }
      } else if (val1 is DateTime && val2 is DateTime) {
        if (val1.isAfter(val2)) {
          return !reverse;
        }
        if (val1.isBefore(val2)) {
          return reverse;
        }
      }
    }
    return null;
  }


  WhisperListViewModel();

  @override
  void onInit() {
    loadMessagesList();
    super.onInit();
  }

  @override
  void onClose() {
    disposeLiveQuery();
    // TODO: implement onClose
    super.onClose();
  }


}


