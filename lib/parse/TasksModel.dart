import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class TasksModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Tasks";

  TasksModel() : super(keyTableName);
  TasksModel.clone() : this();

  @override
  TasksModel clone(Map<String, dynamic> map) => TasksModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAuthor = "author";
  static String keyAuthorUid = "authorUid";

  static String keyCheckIn= "checkIn";
  static String keyWatchLive3 = "watchLiveFor3";
  static String keyWatchLive5 = "watchLiveFor5";
  static String keyFollowBroadcaster = "followBroadcaster";
  static String keySendGift = "sendGift";

  static String keyStatusUnfinished = "Unfinished";
  static String keyStatusCompleted = "Completed";
  static String keyStatusReceive = "Receive";


  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  int? get getAuthorUid => get<int>(keyAuthorUid);
  set setAuthorUid(int authorUid) => set<int>(keyAuthorUid, authorUid);

  DateTime? get getCheckInStatus => get<DateTime>(keyCheckIn);
  set setCheckInStatus(DateTime checkIn) => set<DateTime>(keyCheckIn, checkIn);

  String? get getWatchLive3Status => get<String>(keyWatchLive3);
  set setWatchLive3Status(String watchLive3) => set<String>(keyWatchLive3, watchLive3);

  String? get getWatchLive5Status => get<String>(keyWatchLive5);
  set setWatchLive5Status(String status) => set<String>(keyWatchLive5, status);

  String? get getSendGiftStatus=> get<String>(keySendGift);
  set setSendGiftStatus(String status) => set<String>(keySendGift, status);

  String? get getFollowBroadcasterStatus=> get<String>(keyFollowBroadcaster);
  set setFollowBroadcasterStatus(String status) => set<String>(keyFollowBroadcaster, status);





}