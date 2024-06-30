import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SubscriptionModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Subscription";

  SubscriptionModel() : super(keyTableName);
  SubscriptionModel.clone() : this();

  @override
  SubscriptionModel clone(Map<String, dynamic> map) => SubscriptionModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keySubscribee = "subscribee";
  static String keySubscribeeId = "subscribeeUid";
  static String keySubscriber = "subscriber";
  static String keySubscriberId = "subscriberUid";
  static String keyCoin= "coin_payment";
  static String keyAmount= "payment_amount";
  static String keyStart= "start";
  static String keyEnd= "end";
  static String keyClaimed= "claimed";


  UserModel? get getSubscribee => get<UserModel>(keySubscribee);
  set setSubscribee(UserModel author) => set<UserModel>(keySubscribee, author);

  int? get getSubscribeeId => get<int>(keySubscribeeId);
  set setSubscribeeId(int authorId) => set<int>(keySubscribeeId, authorId);

  UserModel? get getSubscriber => get<UserModel>(keySubscriber);
  set setSubscriber(UserModel author) => set<UserModel>(keySubscriber, author);

  int? get getSubscriberId => get<int>(keySubscriberId);
  set setSubscriberId(int authorId) => set<int>(keySubscriberId, authorId);

  int? get getCoins => get<int>(keyCoin);
  set setCoins(int coins) => set<int>(keyCoin, coins);

  DateTime? get getSubscriptionDate => get<DateTime>(keyStart);
  set setSubscriptionDate (DateTime date) => set<DateTime>(keyStart, date);

  DateTime? get getSubscriptionEnd => get<DateTime>(keyEnd);
  set setSubscriptionEnd (DateTime date) => set<DateTime>(keyEnd, date);

  bool? get getClaimed => get<bool>(keyClaimed);
  set setClaimed(bool claimed) => set<bool>(keyClaimed, claimed);






}