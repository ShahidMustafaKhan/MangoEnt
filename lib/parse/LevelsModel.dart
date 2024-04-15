import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class LevelsModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Levels";

  LevelsModel() : super(keyTableName);
  LevelsModel.clone() : this();

  @override
  LevelsModel clone(Map<String, dynamic> map) => LevelsModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAuthor = "author";
  static String keyAuthorId = "authorUid";
  static String keyShowAll= "showAll";

  static String keyLevel = "level";
  static String keyLevelFile = "file";




  ParseFileBase? get getFile => get<ParseFileBase>(keyLevelFile);
  set setFile(ParseFileBase file) => set<ParseFileBase>(keyLevelFile, file);

  int? get getLevel => get<int>(keyLevel);
  set setLevel(int level) => set<int>(keyLevel, level);



}