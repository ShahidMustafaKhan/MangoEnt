import 'package:teego/parse/BattleStreamingModel.dart';
import 'package:teego/parse/GiftsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'TimerModel.dart';

class LiveStreamingModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Streaming";

  LiveStreamingModel() : super(keyTableName);
  LiveStreamingModel.clone() : this();

  @override
  LiveStreamingModel clone(Map<String, dynamic> map) => LiveStreamingModel.clone()..fromJson(map);

  static final String privacyTypeAnyone = "anyone";
  static final String privacyTypeFriends = "friends";
  static final String privacyTypeNoOne = "none";

  static final String liveTypeParty = "party";
  static final String liveTypeGoLive = "live";
  static final String liveTypeBattle = "battle";

  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAuthor = "Author";
  static String keyAuthorId = "AuthorId";
  static String keyAuthorUid = "AuthorUid";

  static String keyTypeSingleLive = "Single Live Streaming";
  static String keyTypeMultiGuestLive = "MultiGuest Live Streaming";
  static String keyTypeGameLive = "Game Live Streaming";
  static String keyTypeAudioLive = "Audio Live Streaming";

  static final String keyPKCoHostUid = "PKCoHostUid";
  static final String keyPKCoHost = "PKCoHost";
  static final String keyPKCoHostLiveObject = "PKCoHostLive";

  static String keyViewsCount = "viewsCount";

  static String keyAuthorInvited = "AuthorInvited";
  static String keyAuthorInvitedUid = "AuthorInvitedUid";

   static final String keyViewersUid = "viewers_uid";
   static final String keyViewersId = "viewers_id";

  static final String keyViewersCountLive = "viewersCountLive";
  static final String keyStreamingPrivate = "private";
  static final String keyStreamingPrivateKey = "privateKey";

   static final String keyLiveImage = "image";
  static final String keyLiveGeoPoint = "geoPoint";
  static final String keyLiveTags = "live_tag";
  static final String keyStreamingType = "streaming_type";
  static final String keyTags = "tag";
  static final String keyTitle = "title";

   static final String keyStreaming = "streaming";
   static final String keyStreamingTime = "streaming_time";
   static final String keyStreamingDiamonds = "streaming_diamonds";
  static final String keyAuthorTotalDiamonds = "author_total_diamonds";

  static final String keyPaidStreaming = "paid";
  static final String keyStreamingAmount = "streamingAmount";

  static final String keyStreamingChannel = "streaming_channel";

  static final String keyStreamingCategory = "streaming_category";

  static final String keyCoHostAvailable = "coHostAvailable";
  static final String keyCoHostAuthor = "coHostAuthor";
  static final String keyCoHostAuthorUid = "coHostAuthorUid";

  static final String keyGiftsList = "gifts";
  static final String keyPrimaryHostScore = "primaryHostScore";
  static final String keyCoHostScore = "coHostScore";

  static final String keyTimer = "timer";
  static final String keyTimerOFF = "timerOff";
  static final String keyTimerIsOn = "timerIsOn";

  static final String keyPrimaryHost = "primaryHost";
  static final String keyPkBattleLive = "PK";

  static final String keyHashTags = "hash_tags";
  static final String keyHashTagsId = "hash_tags_id";

  static final String keyPrivateLiveGift = "privateLivePrice";
  static final String keyPrivateViewers = "privateViewers";

  static final String keyFirstLive = "firstLive";

  static final String keyMultiGuest = "multi_guest";

  static final String keyStreamId = "streamId";
  static final String keyRoomId = "roomId";

  static final String keyGoal = "goal";
  static final String keyGoalTitle = "goalTitle";

  static final String keyCoHostView = "coHostView";

  static final String keyGiftSenders = "giftSenders";
  static final String keyGiftSendersAuthor = "giftSenders.author";

  static final String keyGiftSendersPicture = "giftSendersPicture";

  static final String keyInvitedBroadCasterId = "invitedBroadCasterId";

  static final String keyInvitationAccepted = "InvitationAccepted";

  static final String keyCoHostUID = "coHostUID";
  static final String keyEndByAdmin = "endByAdmin";

  static final String keyInvitedPartyUid = "invitedPartyUid";
  static final String keyInvitedPartyLive = "invitedPartyLive";
  static final String keyInvitedPartyLiveAuthor = "invitedPartyLive.Author";

  static final String keyTaskFollowBroadcaster='taskFollowBroadcaster';
  static final String keyTaskSendGifts='taskSendGifts';
  static final String keyTaskWatchLiveFor5='taskWatchLiveFor5';
  static final String keyTaskWatchLiveFor3='taskWatchLiveFor3';
  static final String keyTaskCheckIn='taskCheckIn';

  static final String keyMyWishList='myWishList';
  static final String keyAmount='amount';
  static final String keyReceived='received';
  static final String keyName='name';

  static final String keyStickerTitle='stickerTitle';
  static final String keyStickerType='stickerType';
  static final String keyStickerLink='stickerLink';

  static final String keyCoHostGiftsList='coHostGiftsList';
  static final String keySenderUid='senderId';
  static final String keyReceiverUid='receiverId';
  static final String keyGiftPath='path';
  static final String keyTotal='total';
  static final String keyQuantity='quantity';
  static final String keySenderName='senderName';
  static final String keyGiftIndex='giftIndex';

  static final String keyMode='mode';
  static final String keyLanguage='language';
  static final String keyRoomAnnouncement='roomAnnouncement';

  static final String keyStreamerFollowers='streamerFollowers';

  static final String keyTimerModel='timerModel';
  static final String keyPkBannerStarted='pkBannerStarted';


  static final String keyBattleModel='battleModel';



  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  UserModel? get getPkCoHostAuthor => get<UserModel>(keyPKCoHost);
  set setPkCoHostAuthor(UserModel author) => set<UserModel>(keyPKCoHost, author);

  TimerModel? get getTimerModel => get<TimerModel>(keyTimerModel);
  set setTimerModel(TimerModel model) => set<TimerModel>(keyTimerModel, model);

  LiveStreamingModel? get getPkCoHostLiveObject => get<LiveStreamingModel>(keyPKCoHostLiveObject);
  set setPkCoHostLiveObject (LiveStreamingModel pkCoHostObject) => set<LiveStreamingModel>(keyPKCoHostLiveObject, pkCoHostObject);

  BattleModel? get getBattleModel => get<BattleModel>(keyBattleModel);
  set setBattleModel (BattleModel battleModel) => set<BattleModel>(keyBattleModel, battleModel);

  int? get getAuthorUid => get<int>(keyAuthorUid);
  set setAuthorUid(int authorUid) => set<int>(keyAuthorUid, authorUid);

  int? get getStreamerFollowers => get<int>(keyStreamerFollowers);
  set setStreamerFollowers(int followers) => set<int>(keyStreamerFollowers, followers);

  UserModel? get getCoHostAuthor => get<UserModel>(keyCoHostAuthor);
  set setCoHostAuthor(UserModel author) => set<UserModel>(keyCoHostAuthor, author);

  int? get getCoHostAuthorUid => get<int>(keyCoHostAuthorUid);
  set setCoHostAuthorUid(int authorUid) => set<int>(keyCoHostAuthorUid, authorUid);

  bool? get getCoHostAuthorAvailable => get<bool>(keyCoHostAvailable);
  set setCoHostAvailable(bool coHostAvailable) => set<bool>(keyCoHostAvailable, coHostAvailable);

  bool? get getIsPkBattleLive => get<bool>(keyPkBattleLive);
  set setIsPkBattleLive(bool isPkBattleLive) => set<bool>(keyPkBattleLive, isPkBattleLive);

  bool? get getPkBannerStarted => get<bool>(keyPkBannerStarted);
  set setPkBannerStarted(bool started) => set<bool>(keyPkBannerStarted, started);

  bool? get getIsPkPrimaryHost => get<bool>(keyPrimaryHost);
  set setIsPkPrimaryHost(bool isPkPrimaryHost) => set<bool>(keyPrimaryHost, isPkPrimaryHost);

  bool? get getIsTimerOff => get<bool>(keyTimerOFF);
  set setIsTimerOff (bool isOff) => set<bool>(keyTimerOFF, isOff);

  bool? get getIsTimerIsOn => get<bool>(keyTimerIsOn);
  set setIsTimerIsOn (bool isOn) => set<bool>(keyTimerIsOn, isOn);

  int? get getTimer=> get<int>(keyTimer);
  set setTimer(int timer) => set<int>(keyTimer, timer);

  String? get getPKCohostUid => get<String>(keyPKCoHostUid);
  set setPKCohostUid(String pkCohostUid) => set<String>(keyPKCoHostUid, pkCohostUid);

  int? get getSeatNumber=> get<int>(keyCoHostView);
  set setSeatNumber(int seatNumber) => set<int>(keyCoHostView, seatNumber);

  String? get getAuthorId => get<String>(keyAuthorId);
  set setAuthorId(String authorId) => set<String>(keyAuthorId, authorId);

  String? get getStreamId => get<String>(keyStreamId);
  set setStreamId(String streamId) => set<String>(keyStreamId, streamId);

  String? get getRoomId => get<String>(keyRoomId);
  set setRoomId(String roomId) => set<String>(keyRoomId, roomId);

  String? get getTitle => get<String>(keyTitle);
  set setTitle(String title) => set<String>(keyTitle, title);

  // String? get getTags => get<String>(keyTags);
  // set setTags(String tags) => set<String>(keyTags, tags);

  List? get getTags => get<List>(keyTags);
  set setTags(List tags) => set<List>(keyTags, tags);

  String? get getInvitedBroadCasterId => get<String>(keyInvitedBroadCasterId);
  set setInvitedBroadCasterId(String authorId) => set<String>(keyInvitedBroadCasterId, authorId);

  UserModel? get getAuthorInvited => get<UserModel>(keyAuthorInvited);
  set setAuthorInvited(UserModel invitedAuthor) => set<UserModel>(keyAuthorInvited, invitedAuthor);

  int? get getAuthorInvitedUid => get<int>(keyAuthorInvitedUid);
  set setAuthorInvitedUid(int invitedAuthorUid) => set<int>(keyAuthorInvitedUid, invitedAuthorUid);

  int? get getViewersCount{

    int? viewersCount = get<int>(keyViewersCountLive);
    if(viewersCount != null){
      return viewersCount;
    } else {
      return 0;
    }
  }
  set addViewersCount(int viewersCount) => setIncrement(keyViewersCountLive, viewersCount);
  set removeViewersCount(int viewersCount) {

    if(getViewersCount! > 0){
      setDecrement(keyViewersCountLive, viewersCount);
    }
  }


  int? get getGoal => get<int>(keyGoal);
  set setGoal(int goal) => set<int>(keyGoal, goal);

  String? get getGoalTile => get<String>(keyGoalTitle);
  set setGoalTitle(String title) => set<String>(keyGoalTitle, title);

  ParseFileBase? get getImage => get<ParseFileBase>(keyLiveImage);
  set setImage(ParseFileBase imageFile) => set<ParseFileBase>(keyLiveImage, imageFile);


  set setGifSenderImage(ParseFileBase imageFile) => setAddUnique(keyGiftSendersPicture, imageFile);

  List<dynamic>? get getGifSenderImage {

    List<dynamic>? images = get<List<dynamic>>(keyGiftSendersPicture);
    if(images != null && images.length > 0){
      return images;
    }else{
      return [];
    }
  }

  List<dynamic>? get getCoHostUiD{

    List<dynamic>? coHostUiD = get<List<dynamic>>(keyCoHostUID);
    if(coHostUiD != null && coHostUiD.length > 0){
      return coHostUiD;
    } else {
      return [];
    }
  }
  set setCoHostUID(int coHostUiD) => setAddUnique(keyCoHostUID, coHostUiD);


  List<dynamic>? get getViewers{

    List<dynamic>? viewers = get<List<dynamic>>(keyViewersUid);
    if(viewers != null && viewers.length > 0){
      return viewers;
    } else {
      return [];
    }
  }
  // set setViewers(int viewerUid) => setAddUnique(keyViewersUid, viewerUid);

  set setViewersIdList(List viewersIdList) {

    List<String> listViewersId = [];

    for(String viewerId in viewersIdList){
      listViewersId.add(viewerId);
    }
    setAddAllUnique(keyViewersUid, listViewersId);
  }

  List<dynamic>? get getViewersId{

    dynamic viewersId =  get<dynamic>(keyViewersId);

    if(viewersId!=null){
      if(viewersId is List<dynamic>){
        return viewersId;
      }
      else if(viewersId is Map<String, dynamic>){
        return [];
      }
    }
    return [];
  }
  set setViewersId(int viewerAuthorId) => setAddUnique(keyViewersId, viewerAuthorId);

  List<dynamic>? get getTaskFollowBroadcaster{

    List<dynamic>? list = get<List<dynamic>>(keyTaskFollowBroadcaster);
    if(list != null && list.length > 0){
      return list;
    } else {
      return [];
    }
  }
  set setTaskFollowBroadcaster(Map<String, dynamic> object ) => setAddUnique(keyTaskFollowBroadcaster, object);

  List<dynamic>? get getTaskSendGift{

    List<dynamic>? list = get<List<dynamic>>(keyTaskSendGifts);
    if(list != null && list.length > 0){
      return list;
    } else {
      return [];
    }
  }
  set setTaskSendGift(Map<String, dynamic> object ) => setAddUnique(keyTaskSendGifts, object);

  List<dynamic>? get getTaskWatchLive5{

    List<dynamic>? list = get<List<dynamic>>(keyTaskWatchLiveFor5);
    if(list != null && list.length > 0){
      return list;
    } else {
      return [];
    }
  }
  set setTaskWatchLive5(Map<String, dynamic> object ) => setAddUnique(keyTaskWatchLiveFor5, object);


  List<dynamic>? get getTaskWatchLive3{

    List<dynamic>? list = get<List<dynamic>>(keyTaskWatchLiveFor3);
    if(list != null && list.length > 0){
      return list;
    } else {
      return [];
    }
  }
  set setTaskWatchLive3(Map<String, dynamic> object ) => setAddUnique(keyTaskWatchLiveFor3, object);


  List<dynamic>? get getTaskCheckIn{

    List<dynamic>? list = get<List<dynamic>>(keyTaskCheckIn);
    if(list != null && list.length > 0){
      return list;
    } else {
      return [];
    }
  }
  set setTaskCheckIn(Map<String, dynamic> object ) => setAddUnique(keyTaskCheckIn, object);


  // int? get getDiamonds => get<int>(keyStreamingDiamonds);

  int get getDiamonds {
    int diamonds = 0;

    dynamic diamond = get<dynamic>(keyStreamingDiamonds);

    if (diamond != null) {
      if (diamond is int) {
        // If it's already a list, return it
        return diamond;
      } else if (diamond is Map<String, dynamic>) {
        // If it's a map, convert it to a list of values and return
        diamonds = 0;
      } else {
        // If it's neither a list nor a map, return an empty list
        diamonds = 0;
      }
    }

    return diamonds;
  }
  
  
  set addDiamonds(int diamonds) => setIncrement(keyStreamingDiamonds, diamonds);
  set decrementDiamonds(int diamonds) => setDecrement(keyStreamingDiamonds, diamonds);

  int? get getAuthorTotalDiamonds => get<int>(keyAuthorTotalDiamonds);
  set addAuthorTotalDiamonds(int diamonds) => setIncrement(keyAuthorTotalDiamonds, diamonds);

  bool? get getStreaming => get<bool>(keyStreaming);
  set setStreaming(bool isStreaming) => set<bool>(keyStreaming, isStreaming);

  bool? get getFirstLive {
    var isFirstTime = get<bool>(keyFirstLive);

    if(isFirstTime != null){
      return isFirstTime;
    }else{
      return false;
    }
  }

  set setFirstLive(bool isFirstLive) => set<bool>(keyFirstLive, isFirstLive);

  bool? get getIsMultiGuest {
    var isMultiGuest = get<bool>(keyMultiGuest);

    if(isMultiGuest != null){
      return isMultiGuest;
    }else{
      return false;
    }
  }

  List<dynamic>? get getGiftsList {

    List<dynamic> gifts = [];

    List<dynamic>? gift = get<List<dynamic>>(keyGiftsList);
    if(gift != null && gift.length > 0){
      return gift;
    } else {
      return gifts;
    }
  }
  set setGift(Map<String,dynamic> gift) => setAdd(keyGiftsList, gift);


  List<dynamic> get getCoHostGiftsList {

    List<dynamic> gifts = [];

    List<dynamic>? gift = get<List<dynamic>>(keyCoHostGiftsList);
    if(gift != null && gift.length > 0){
      return gift;
    } else {
      return gifts;
    }
  }
  set setCoHostGiftsList(Map<String,dynamic> gift) => setAdd(keyCoHostGiftsList, gift);

  set setCoHostAllGiftsList(List gift) => setAddAll(keyCoHostGiftsList, gift);

  List<dynamic>? get getMyWishList {
    List<dynamic> wishLists = [];

    dynamic wishList = get<dynamic>(keyMyWishList);

    if (wishList != null) {
      if (wishList is List<dynamic>) {
        // If it's already a list, return it
        return wishList;
      } else if (wishList is Map<String, dynamic>) {
        // If it's a map, convert it to a list of values and return
        wishLists = [];
      } else {
        // If it's neither a list nor a map, return an empty list
        wishLists = [];
      }
    }

    return wishLists;
  }

  set setMyWishList(Map<String,dynamic> wishItem) => setAdd(keyMyWishList, wishItem);
  set setMyWishWholeList(List wishItem) => set<List>(keyMyWishList, wishItem);
  set setMyWishAllList(List wishItem) => setAddAll(keyMyWishList, wishItem);
  set removeMyWishList(Map<String,dynamic> wishItem) => setRemove(keyMyWishList, wishItem);
  set removeMyWishAllList(List wishItem) => setRemoveAll(keyMyWishList, wishItem);

  // List<dynamic>? get getPrimaryHostScore {
  //
  //   List<dynamic> gifts = [];
  //
  //   List<dynamic>? gift = get<List<dynamic>>(keyPrimaryHostScore);
  //   if(gift != null && gift.length > 0){
  //     return gift;
  //   } else {
  //     return gifts;
  //   }
  // }

  List<dynamic>? get getPrimaryHostScore {
    List<dynamic> gifts = [];

    dynamic gift = get<dynamic>(keyPrimaryHostScore);

    if (gift != null) {
      if (gift is List<dynamic>) {
        // If it's already a list, return it
        return gift;
      } else if (gift is Map<String, dynamic>) {
        // If it's a map, convert it to a list of values and return
        gifts = [];
      } else {
        // If it's neither a list nor a map, return an empty list
        gifts = [];
      }
    }

    return gifts;
  }

  set setPrimaryHostScore(Map<String,dynamic> gift) => setAdd(keyPrimaryHostScore, gift);

  set removePrimaryHostScore(List gift) => setRemoveAll(keyPrimaryHostScore, gift);

  List<dynamic>? get getCoHostScore {

    List<dynamic> gifts = [];

    dynamic gift = get<dynamic>(keyCoHostScore);

    if (gift != null) {
      if (gift is List<dynamic>) {
        // If it's already a list, return it
        return gift;
      } else if (gift is Map<String, dynamic>) {
        // If it's a map, convert it to a list of values and return
        gifts = [];
      } else {
        // If it's neither a list nor a map, return an empty list
        gifts = [];
      }
    }

    return gifts;
  }
  set setCoHostScore(Map<String,dynamic> gift) => setAdd(keyCoHostScore, gift);

  set removeCoHostScore(List gift) => setRemoveAll(keyCoHostScore, gift);

  set setIsMultiGuest(bool isMultiGuest) => set<bool>(keyMultiGuest, isMultiGuest);



  String? get getStreamingTime => get<String>(keyStreamingTime);
  set setStreamingTime(String streamingTime) => set<String>(keyStreamingTime, streamingTime);

  String? get getStreamingCategory => get<String>(keyStreamingCategory);
  set setStreamingCategory(String streamingCategory) => set<String>(keyStreamingCategory, streamingCategory);

  String? get getStreamingTags {
    String? text = get<String>(keyLiveTags);
    if(text != null){
      return text;
    } else {
      return "";
    }
  }

  set setStreamingTags(String text) => set<String>(keyLiveTags, text);

  String? get getStreamingChannel => get<String>(keyStreamingChannel);
  set setStreamingChannel(String streamingChannel) => set<String>(keyStreamingChannel, streamingChannel);

  set setStreamingType(String type) => set<String>(keyStreamingType, type);

  String? get getStreamingType => get<String>(keyStreamingType);

  ParseGeoPoint? get getStreamingGeoPoint => get<ParseGeoPoint>(keyLiveGeoPoint);
  set setStreamingGeoPoint(ParseGeoPoint liveGeoPoint) => set<ParseGeoPoint>(keyLiveGeoPoint, liveGeoPoint);

  bool? get getPrivate{
    bool? private = get<bool>(keyStreamingPrivate);
    if(private != null){
      return private;
    } else {
      return false;
    }
  }
  set setPrivate(bool private) => set<bool>(keyStreamingPrivate, private);


  set setPrivateKey(String key) => set<String>(keyStreamingPrivateKey, key);

  String? get getPrivateKey => get<String>(keyStreamingPrivateKey);

  bool? get getPaidStreaming{
    bool? private = get<bool>(keyPaidStreaming);
    if(private != null){
      return private;
    } else {
      return false;
    }
  }
  set setPaidStreaming(bool paid) => set<bool>(keyPaidStreaming, paid);


  set setStreamingAmount(int amount) => set<int>(keyStreamingAmount, amount);

  int? get getStreamingAmount => get<int>(keyStreamingAmount);

  bool? get getInvitationAccepted{
    bool? accepted = get<bool>(keyInvitationAccepted);
    if(accepted != null){
      return accepted;
    } else {
      return false;
    }
  }
  set setInvitationAccepted(bool accepted) => set<bool>(keyInvitationAccepted, accepted);




  List<String>? get getHashtags{

    var arrayString =  get<List<dynamic>>(keyHashTagsId);

    if(arrayString != null){
      List<String> users = new List<String>.from(arrayString);
      return users;
    } else {
      return [];
    }

  }

  List<dynamic>? get getHashtagsForQuery{

    var arrayString =  get<List<dynamic>>(keyHashTags);

    if(arrayString != null){
      List<String> users = new List<String>.from(arrayString);
      return users;
    } else {
      return [];
    }

  }


  GiftsModel? get getPrivateGift => get<GiftsModel>(keyPrivateLiveGift);
  set setPrivateLivePrice(GiftsModel privateLivePrice) => set<GiftsModel>(keyPrivateLiveGift, privateLivePrice);
  set removePrice(GiftsModel privateLivePrice) => setRemove(keyPrivateLiveGift, privateLivePrice);

  List<dynamic>? get getPrivateViewersId{

    List<dynamic>? viewersId = get<List<dynamic>>(keyPrivateViewers);
    if(viewersId != null && viewersId.length > 0){
      return viewersId;
    } else {
      return [];
    }
  }
  set setPrivateViewersId(String viewerAuthorId) => setAddUnique(keyPrivateViewers, viewerAuthorId);

  set setPrivateListViewersId(List viewersId) {

    List<String> listViewersId = [];

    for(String privateViewer in viewersId){
      listViewersId.add(privateViewer);
    }
    setAddAllUnique(keyPrivateViewers, listViewersId);
  }


  bool? get isLiveCancelledByAdmin{
    bool? cancelled = get<bool>(keyEndByAdmin);
    if(cancelled != null){
      return cancelled;
    } else {
      return false;
    }
  }

  set setTerminatedByAdmin(bool yes) => set<bool>(keyEndByAdmin, yes);

  List<dynamic>? get getInvitedPartyUid{

    List<dynamic>? invitedUid = get<List<dynamic>>(keyInvitedPartyUid);
    if(invitedUid != null && invitedUid.length > 0){
      return invitedUid;
    } else {
      return [];
    }
  }
  set addInvitedPartyUid(List<dynamic> uidList) => setAddAllUnique(keyInvitedPartyUid, uidList);

  set removeInvitedPartyUid(int uid) => setRemove(keyInvitedPartyUid, uid);

  LiveStreamingModel? get getInvitationLivePending => get<LiveStreamingModel>(keyInvitedPartyLive);

  set setInvitationLivePending(LiveStreamingModel live) => set<LiveStreamingModel>(keyInvitedPartyLive, live);

  removeInvitationLivePending() => unset(keyInvitedPartyLive);

  String? get getStickerTitle => get<String>(keyStickerTitle);
  set setStickerTitle (String title) => set<String>(keyStickerTitle, title);

  String? get getStickerType => get<String>(keyStickerType);
  set setStickerType(String type) => set<String>(keyStickerType, type);

  String? get getStickerLink => get<String>(keyStickerLink);
  set setStickerLink (String link) => set<String>(keyStickerLink, link);

  String? get getMode => get<String>(keyMode);
  set setMode (String mode) => set<String>(keyMode, mode);

  String? get getLanguage => get<String>(keyLanguage);
  set setLanguage (String language) => set<String>(keyLanguage, language);

  String? get getRoomAnnouncement => get<String>(keyRoomAnnouncement);
  set setRoomAnnouncement (String text) => set<String>(keyRoomAnnouncement, text);

}

