import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'CommentsModel.dart';

class ReplyModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Replies";

  ReplyModel() : super(keyTableName);
  ReplyModel.clone() : this();

  @override
  ReplyModel clone(Map<String, dynamic> map) => ReplyModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAuthor = "author";
  static String keyAuthorId = "authorId";


  static String keyText = "text";
  static String keyComment = "comment";
  static String keyCommentId = "commentId";
  static String keyLikes= "likes";
  static String keyReport= "report";


  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  String? get getAuthorId => get<String>(keyAuthorId);
  set setAuthorId(String authorId) => set<String>(keyAuthorId, authorId);

  String? get getText => get<String>(keyText);
  set setText(String text) => set<String>(keyText, text);

  String? get getCommentId => get<String>(keyCommentId);
  set setCommentId(String commentId) => set<String>(keyCommentId, commentId);

  CommentsModel? get getComment => get<CommentsModel>(keyComment);
  set setComment(CommentsModel post) => set<CommentsModel>(keyComment, post);

  List<dynamic>? get getLikes{

    List<dynamic> like = [];

    List<dynamic>? likes = get<List<dynamic>>(keyLikes);
    if(likes != null && likes.length > 0){
      return likes;
    } else {
      return like;
    }
  }
  set setLikes(String likeAuthorId) => setAddUnique(keyLikes, likeAuthorId);
  set removeLike(String likeAuthorId) => setRemove(keyLikes, likeAuthorId);

  List<dynamic>? get getReportList {

    List<dynamic> reports = [];

    List<dynamic>? report = get<List<dynamic>>(keyReport);
    if(report != null && report.length > 0){
      return report;
    } else {
      return reports;
    }
  }
  set setReport(Map<String,dynamic> report) => setAdd(keyReport, report);

  set removeReport(Map<String,dynamic> report) => setRemove(keyReport, report);





}