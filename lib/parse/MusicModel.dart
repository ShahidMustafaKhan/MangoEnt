

import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

// Audio audioModelFromJson(String str) =>
//     Audio.fromJson(json.decode(str));
//
// String musicModelToJson(Audio data) => json.encode(data.toJson());

class Audio {
  final String audioName;
  final String? singerName;
  final String audioURL;
  final String thumbnailURL;

  Audio(
       {
    required this.audioName,
    required this.audioURL,
          this.singerName,
         required this.thumbnailURL,

  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      audioName: json['audioName'],
      audioURL: json['audioURL'],
      singerName: json['singerName'],
      thumbnailURL: json['thumbnailURL'],
    );
  }
}


class MusicModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Musicfiles";

  MusicModel() : super(keyTableName);
  MusicModel.clone() : this();

  @override
  MusicModel clone(Map<String, dynamic> map) => MusicModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyAudioFile= "audioFile";
  static String keyAudioName = "audioName";
  static String keySingerName = "singerName";
  static String keyThumbnail= "thumbnail";




  String? get getAudioName => get<String>(keyAudioName);
  set setAAudioName(String audioName) => set<String>(keyAudioName, audioName);

  ParseFileBase? get getAudioFile => get<ParseFileBase>(keyAudioFile);
  set setText(ParseFileBase audioFile) => set<ParseFileBase>(keyAudioFile, audioFile);

  ParseFileBase? get getThumbnail => get<ParseFileBase>(keyThumbnail);
  set setThumbnail(ParseFileBase thumbnail) => set<ParseFileBase>(keyThumbnail, thumbnail);

  String? get getSingerName => get<String>(keySingerName);
  set setSingerName(String name) => set<String>(keySingerName, name);






}
