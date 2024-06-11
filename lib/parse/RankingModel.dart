import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'CommentsModel.dart';

class RankingModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Ranking";

  RankingModel() : super(keyTableName);
  RankingModel.clone() : this();

  @override
  RankingModel clone(Map<String, dynamic> map) => RankingModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keySender = "sender";
  static String keySenderUid = "senderUid";


  static String keyCategory = "category";
  static String keyCategoryGifter = "gifter";
  static String keyCoins = "coins";



  UserModel? get getGifter => get<UserModel>(keySender);
  set setGifter(UserModel author) => set<UserModel>(keySender, author);

  int? get getGifterID => get<int>(keySenderUid);
  set setGifterID(int authorId) => set<int>(keySenderUid, authorId);

  String? get getCategory => get<String>(keyCategory);
  set setCategory(String category) => set<String>(keyCategory, category);

  int? get getCoins => get<int>(keyCoins);
  set setCoins(int coins) => set<int>(keyCoins, coins);







}