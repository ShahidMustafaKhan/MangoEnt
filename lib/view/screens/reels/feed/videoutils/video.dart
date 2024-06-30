
import '../../../../../parse/PostsModel.dart';
import '../../../../../parse/UserModel.dart';


class VideoInfo {
  String? url;
  final file;
  String? userName;
  String? songName;
  bool? liked;
  DateTime? dateTime;
  List<dynamic>? likes;
  PostsModel? postModel;
  UserModel? currentUser;

  VideoInfo({
    this.url,
    this.file,
    this.userName,
    this.songName,
    this.liked,
    this.dateTime,
    this.likes,
    this.postModel,
    this.currentUser,
  });
}