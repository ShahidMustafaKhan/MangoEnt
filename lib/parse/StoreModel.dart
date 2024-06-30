import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class StoreModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Store";

  StoreModel() : super(keyTableName);
  StoreModel.clone() : this();

  @override
  StoreModel clone(Map<String, dynamic> map) => StoreModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAuthor = "author";
  static String keyAuthorUid = "authorUid";

  static String keyMyAvatarItems = "myAvatarItems";
  static String keyMyRoomDecorItems = "myRoomDecorItems";



  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  int? get getAuthorUid => get<int>(keyAuthorUid);
  set setAuthorUid(int authorUid) => set<int>(keyAuthorUid, authorUid);


  List? get getMyAvatarItems {
    dynamic data = get(keyMyAvatarItems); // Assuming get() method retrieves data from somewhere

    if (data is Map<String, dynamic>) {
      // Handle the case where data is a Map<String, dynamic>
      // Convert it to List<dynamic> or handle it accordingly
      // For example, you can convert it to List<dynamic> by extracting values from the map
      return []; // or whatever appropriate
    } else if (data is List<dynamic>) {


      // Return the data as it is if it's already of the expected type
      return data;
    } else {
      // Handle any other cases here
      return []; // or throw an exception or handle it as required
    }
  }
  set setMyAvatarItems(List items) => set<List>(keyMyAvatarItems, items);

  set incrementMyAvatarItems(Map<String, dynamic> item) {
    setAddUnique(keyMyAvatarItems, item);
  }


  List? get getMyRoomDecorItems {
    dynamic data = get(keyMyRoomDecorItems); // Assuming get() method retrieves data from somewhere

    if (data is Map<String, dynamic>) {
      // Handle the case where data is a Map<String, dynamic>
      // Convert it to List<dynamic> or handle it accordingly
      // For example, you can convert it to List<dynamic> by extracting values from the map
      return []; // or whatever appropriate
    } else if (data is List<dynamic>) {


      // Return the data as it is if it's already of the expected type
      return data;
    } else {
      // Handle any other cases here
      return []; // or throw an exception or handle it as required
    }
  }
  set setMyRoomDecorItems(List items) => set<List>(keyMyRoomDecorItems, items);

  set incrementMyRoomDecorItems(Map<String, dynamic> item) {
    setAddUnique(keyMyRoomDecorItems, item);
  }








}