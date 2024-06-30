
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:teego/parse/LiveStreamingModel.dart';

import 'MessageModel.dart';
import 'UserModel.dart';
import 'WhisperModel.dart';



class WhisperListModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "WhisperList";

  WhisperListModel() : super(keyTableName);
  WhisperListModel.clone() : this();

  @override
  WhisperListModel clone(Map<String, dynamic> map) => WhisperListModel.clone()..fromJson(map);

  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyListId = "listId";

  static String keyAuthor = "Author";
  static String keyAuthorId = "AuthorId";

  static String keyLiveStreaming = "liveObject";
  static String keyLiveStreamingId = "liveObjectId";

  static String keyReceiver = "Receiver";
  static String keyReceiverId = "ReceiverId";

  static String keyMessageCounter = "Counter";

  static final String keyText = "text";
  static final String keyMessageFile = "messageFile";
  static final String keyIsMessageFile = "isMessageFile";

  static final String keyRead = "read";

  static final String keyMessage = "message";
  static final String keyMessageId = "messageId";

  static final String keyMessageType= "messageType";
  static final String keyCall= "call";



  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  String? get getAuthorId => get<String>(keyAuthorId);
  set setAuthorId(String authorId) => set<String>(keyAuthorId, authorId);

  UserModel? get getReceiver => get<UserModel>(keyReceiver);
  set setReceiver(UserModel author) => set<UserModel>(keyReceiver, author);

  String? get getReceiverId => get<String>(keyReceiverId);
  set setReceiverId(String authorId) => set<String>(keyReceiverId, authorId);

  LiveStreamingModel? get getLiveStreaming => get<LiveStreamingModel>(keyLiveStreaming);
  set setLiveStreaming(LiveStreamingModel live) => set<LiveStreamingModel>(keyLiveStreaming, live);

  String? get getLiveStreamingId => get<String>(keyLiveStreamingId);
  set setLiveStreamingId(String id) => set<String>(keyLiveStreamingId, id);

  String? get getText => get<String>(keyText);
  set setText(String text) => set<String>(keyText, text);

  String? get getMessageId => get<String>(keyMessageId);
  set setMessageId(String messageId) => set<String>(keyMessageId, messageId);

  String? get getListId => get<String>(keyListId);
  set setListId(String listId) => set<String>(keyListId, listId);

  ParseFileBase? get getMessageFile => get<ParseFileBase>(keyMessageFile);
  set setMessageFile(ParseFileBase messageFile) => set<ParseFileBase>(keyMessageFile, messageFile);

  bool? get isMessageFile => get<bool>(keyMessageFile);
  set setIsMessageFile(bool isMessageFile) => set<bool>(keyMessageFile, isMessageFile);

  bool? get isRead => get<bool>(keyRead);
  set setIsRead(bool isRead) => set<bool>(keyRead, isRead);

  WhisperModel? get getMessage => get<WhisperModel>(keyMessage);
  set setMessage(WhisperModel whisperModel) => set<WhisperModel>(keyMessage, whisperModel);

  String? get getMessageType => get<String>(keyMessageType);
  set setMessageType(String messageType) => set<String>(keyMessageType, messageType);

  int? get getCounter => get<int>(keyMessageCounter);
  set setCounter(int count) => set<int>(keyMessageCounter, count);
  set incrementCounter(int count) => setIncrement(keyMessageCounter, count);
}