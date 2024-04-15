import '../parse/LiveStreamingModel.dart';

class TrendingModel {
  final String name;
  final String image;
  final String flag;
  final String country;
  final int achievementCount;
  final String avatar;
  final LiveStreamingModel liveModel;

  TrendingModel(
      {required this.country,
        required this.liveModel,
        required this.achievementCount,
        required this.avatar,
        required this.name,
        required this.image,
        required this.flag});
}
