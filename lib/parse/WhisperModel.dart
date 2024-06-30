
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'LiveStreamingModel.dart';
import 'UserModel.dart';
import 'WhisperListModel.dart';

class WhisperModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Whisper";

  WhisperModel() : super(keyTableName);
  WhisperModel.clone() : this();

  @override
  WhisperModel clone(Map<String, dynamic> map) => WhisperModel.clone()..fromJson(map);

  static String messageTypeText = "text";
  static String messageTypeGif = "gif";
  static String messageTypePicture = "picture";
  static String messageTypeCall = "call";

  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAuthor = "Author";
  static String keyAuthorId = "AuthorId";

  static String keyLiveStreaming = "liveObject";
  static String keyLiveStreamingId = "liveObjectId";

  static String keyReceiver = "Receiver";
  static String keyReceiverId = "ReceiverId";

  static final String keyText = "text";
  static final String keyMessageFile = "messageFile";
  static final String keyIsMessageFile = "isMessageFile";

  static final String keyRead = "read";

  static final String keyListMessage = "messageList";
  static final String keyListMessageId = "messageListId";

  static final String keyGifMessage = "gifMessage";
  static final String keyGifCoins = "gifCoins";
  static final String keyGifAmount = "gifAmount";

  static final String keyPictureMessage = "pictureMessage";

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

  String? get getDuration => get<String>(keyText);
  set setDuration(String message) => set<String>(keyText, message);

  ParseFileBase? get getMessageFile => get<ParseFileBase>(keyMessageFile);
  set setMessageFile(ParseFileBase messageFile) => set<ParseFileBase>(keyMessageFile, messageFile);

  bool? get isMessageFile => get<bool>(keyMessageFile);
  set setIsMessageFile(bool isMessageFile) => set<bool>(keyMessageFile, isMessageFile);

  bool? get isRead => get<bool>(keyRead);
  set setIsRead(bool isRead) => set<bool>(keyRead, isRead);

  WhisperListModel? get getMessageList => get<WhisperListModel>(keyListMessage);
  set setMessageList(WhisperListModel messageListModel) => set<WhisperListModel>(keyListMessage, messageListModel);

  String? get getMessageListId => get<String>(keyListMessageId);
  set setMessageListId(String messageListId) => set<String>(keyListMessageId, messageListId);

  String? get getGifUrl => get<String>(keyGifMessage);
  set setGifUrl(String gifMessage) => set<String>(keyGifMessage, gifMessage);

  int? get getGifCoins => get<int>(keyGifCoins);
  set settGifCoins(int coins) => set<int>(keyGifCoins, coins);

  int? get getGifAmount => get<int>(keyGifAmount);
  set setGifAmount(int amount) => set<int>(keyGifAmount, amount);

  String? get getMessageType => get<String>(keyMessageType);
  set setMessageType(String messageType) => set<String>(keyMessageType, messageType);

  ParseFileBase? get getPictureMessage => get<ParseFileBase>(keyPictureMessage);
  set setPictureMessage(ParseFileBase pictureMessage) => set<ParseFileBase>(keyPictureMessage, pictureMessage);



}