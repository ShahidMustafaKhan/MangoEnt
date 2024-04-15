import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CommentsModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Comments";

  CommentsModel() : super(keyTableName);
  CommentsModel.clone() : this();

  @override
  CommentsModel clone(Map<String, dynamic> map) => CommentsModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAuthor = "author";
  static String keyAuthorId = "authorId";
  static String keyShowAll= "showAll";


  static String keyText = "text";
  static String keyPost = "post";
  static String keyPostId = "postId";
  static String keyLikes= "likes";
  static String keyReport= "report";
  static String keyReply= "reply";


  UserModel? get getAuthor => get<UserModel>(keyAuthor);
  set setAuthor(UserModel author) => set<UserModel>(keyAuthor, author);

  String? get getAuthorId => get<String>(keyAuthorId);
  set setAuthorId(String authorId) => set<String>(keyAuthorId, authorId);

  String? get getText => get<String>(keyText);
  set setText(String text) => set<String>(keyText, text);

  String? get getPostId => get<String>(keyPostId);
  set setPostId(String postId) => set<String>(keyPostId, postId);

  PostsModel? get getPost => get<PostsModel>(keyPost);
  set setPost(PostsModel post) => set<PostsModel>(keyPost, post);

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


  List<dynamic>? get getShowAll{

    List<dynamic> showAll = [];

    List<dynamic>? showAlls = get<List<dynamic>>(keyShowAll);
    if(showAlls != null && showAlls.length > 0){
      return showAlls;
    } else {
      return showAll;
    }
  }
  set setShowAll(String showAll) => setAddUnique(keyShowAll, showAll);
  set removeShowAll(String showAll) => setRemove(keyShowAll, showAll);
  set removeAllShowAll(List showAll) => setRemoveAll(keyShowAll, showAll);

  // List<dynamic>? get getReportList {
  //
  //   List<dynamic> reports = [];
  //
  //   List<dynamic>? report = get<List<dynamic>>(keyReport);
  //   if(report != null && report.length > 0){
  //     return report;
  //   } else {
  //     return reports;
  //   }
  // }
  List<dynamic>? get getReportList {
    List<dynamic> reports = [];

    dynamic reportData = get<dynamic>(keyReport);

    if (reportData != null) {
      if (reportData is List<dynamic>) {
        if(reportData.length > 0){
              return reportData;
            } else {
              return reports;
            }
        // If it's a list, return it
        return reportData;
      } else if (reportData is Map<String, dynamic>) {
        // If it's a map, convert it to a list of values and return
        reports = reportData.values.toList();
        return reports;
      }
    }

    // If reportData is null or not a list or map, return an empty list
    return reports;
  }

  set setReport(String report) => setAdd(keyReport, report);

  set removeReport(String report) => setRemove(keyReport, report);


  List<dynamic>? get getReplyList {

    List<dynamic> replies = [];

    List<dynamic>? reply = get<List<dynamic>>(keyReply);
    if(reply != null && reply.length > 0){
      return reply;
    } else {
      return replies;
    }
  }
  set setReply(String reply) => setAdd(keyReply, reply);

  set removeReply(String reply) => setRemove(keyReply, reply);


}