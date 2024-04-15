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

  static String keyMyItems = "myItems";



  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  int? get getAuthorUid => get<int>(keyAuthorUid);
  set setAuthorUid(int authorUid) => set<int>(keyAuthorUid, authorUid);

  // List? get getMyItems => get<List>(keyMyItems);
  // List<dynamic>? get getMyItems{
  //
  //   List<dynamic>? items = get<List<dynamic>>(keyMyItems);
  //   if(items != null){
  //     return items;
  //   } else {
  //     return [];
  //   }
  // }

  List<int>? get getMyItems {
    dynamic data = get(keyMyItems); // Assuming get() method retrieves data from somewhere

    if (data is Map<String, dynamic>) {
      // Handle the case where data is a Map<String, dynamic>
      // Convert it to List<dynamic> or handle it accordingly
      // For example, you can convert it to List<dynamic> by extracting values from the map
      return []; // or whatever appropriate
    } else if (data is List<dynamic>) {
      List<int> intList = data.map((e) => e is String ? int.parse(e) : e as int).toList();

      // Return the data as it is if it's already of the expected type
      return intList;
    } else {
      // Handle any other cases here
      return []; // or throw an exception or handle it as required
    }
  }
  set setMyItems(List items) => set<List>(keyMyItems, items);

  set incrementMyItems(int item) {
    setAddUnique(keyMyItems, item);
  }








}