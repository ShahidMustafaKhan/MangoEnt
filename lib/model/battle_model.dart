import 'package:teego/parse/LiveStreamingModel.dart';

class BattleLiveModel {
  final String hostName;
  final String player2Name;
  final String player3Name;
  final String player4Name;
  final String hostBgImage;
  final String player2BgImage;
  final String player3BgImage;
  final String player4BgImage;
  final int team1Score;
  final int team2Score;
  final int team3Score;
  final int team4Score;
  final LiveStreamingModel liveModel;

  BattleLiveModel(
      {required this.hostName,
        required this.liveModel,
        required this.player2Name,
        this.player3Name='',
        this.player4Name='',
        required this.hostBgImage,
        required this.player2BgImage,
        this.player3BgImage='',
        this.player4BgImage='',
        this.team1Score=0,
        this.team2Score=0,
        this.team3Score=0,
        this.team4Score=0,

      });
}
