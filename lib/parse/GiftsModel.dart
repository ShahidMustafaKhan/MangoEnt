import 'package:parse_server_sdk/parse_server_sdk.dart';

class GiftsModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Gifts";

  GiftsModel() : super(keyTableName);
  GiftsModel.clone() : this();

  @override
  GiftsModel clone(Map<String, dynamic> map) => GiftsModel.clone()..fromJson(map);

  static String giftCategoryTypeClassic = "classic";
  static String giftCategoryType3D = "_3d";
  static String giftCategoryTypeVIP = "vip";
  static String giftCategoryTypeLove = "love";
  static String giftCategoryTypeMoods = "moods";
  static String giftCategoryTypeArtists = "artists";
  static String giftCategoryTypeCollectibles = "collectibles";
  static String giftCategoryTypeGames = "games";
  static String giftCategoryTypeFamily = "family";




  static String pkAvatarBanner = "pk avatar banner";
  static String pkFireLine = "fire line";
  static String pkIndex = "pk index";
  static String pkCountdown = "countdown animation";
  static String pkWinBadge = "win badge";
  static String pkLoseBadge = "lose badge";









  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyCoins = "coins";
  static String keyName = "name";
  static String keyGiftFile = "file";
  static String keyGiftCategories = "categories";
  static String keyIndex='index';


  ParseFileBase? get getFile => get<ParseFileBase>(keyGiftFile);
  set setFile(ParseFileBase file) => set<ParseFileBase>(keyGiftFile, file);

  int? get getCoins => get<int>(keyCoins);
  set setCoins(int count) => set<int>(keyCoins, count);

  int? get getIndex => get<int>(keyIndex);
  set setIndex(int index) => set<int>(keyIndex, index);

  String? get getName => get<String>(keyName);
  set setName(String name) => set<String>(keyName, name);

  String? get getGiftCategories => get<String>(keyGiftCategories);
  set setGiftCategories(String categoryName) => set<String>(keyGiftCategories, categoryName);

}