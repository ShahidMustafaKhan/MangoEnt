import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'TimerModel.dart';

class BattleModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "PkBattle";

  BattleModel() : super(keyTableName);
  BattleModel.clone() : this();

  @override
  BattleModel clone(Map<String, dynamic> map) => BattleModel.clone()..fromJson(map);


  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyHost = "host";
  static String keyHostUid = "hostUid";
  static String keyBattleView = "battleView";
  static String keyBattleStarted = "battleStarted";
  static String keyPlayerB= "playerB";
  static String keyPlayerBName= "playerBName";
  static String keyPlayerBAvatar= "playerBAvatar";
  static String keyPlayerBImage= "playerBImage";
  static String keyPlayerC= "playerC";
  static String keyPlayerD= "playerD";
  static String keyMode = "mode";
  static String keyTimer = "timer";
  static String keyTime = "time";
  static String keyCurrentRound = "currentRound";
  static String keyTotalRounds = "totalRounds";
  static String keyTeamAScore= "TeamAScore";
  static String keyTeamBScore= "TeamBScore";
  static String keyTeamCScore= "TeamCScore";
  static String keyTeamDScore= "TeamDScore";
  static String keyTeamAWins= "teamAWins";
  static String keyTeamBWins= "teamBWins";
  static String keyTeamCWins= "teamCWins";
  static String keyTeamDWins= "teamDWins";
  static String keyDraw= "draw";
  static String keyLiveObjectId= "LiveObjectId";
  static String keyLiveObject= "LiveObject";
  static String keyTeamAGiftsList= "teamAGiftsList";
  static String keyTeamBGiftsList= "teamBGiftsList";

  static final String keyTimerModel='timerModel';

  static final String keyBackgroundImage='backgroundImage';





  UserModel? get getHost => get<UserModel>(keyHost);
  set setHost(UserModel host) => set<UserModel>(keyHost, host);

  int? get getHostUid => get<int>(keyHostUid);
  set setHostUid(int id) => set<int>(keyHostUid, id);

  UserModel? get getPlayerB => get<UserModel>(keyPlayerB);
  set setPlayerB(UserModel playerB) => set<UserModel>(keyPlayerB, playerB);

  LiveStreamingModel? get getLiveObject => get<LiveStreamingModel>(keyLiveObject);
  set setLiveObject(LiveStreamingModel object) => set<LiveStreamingModel>(keyLiveObject, object);

  bool? get getBattleStarted {
    bool? started = get<bool>(keyBattleStarted);
    if(started==null){
      return false;
    }
    else{
      return started;
    }
  }
  set setBattleStarted(bool started) => set<bool>(keyBattleStarted, started);

  bool? get getBattleView => get<bool>(keyBattleView);
  set setBattleView(bool view) => set<bool>(keyBattleView, view);

  String? get getPlayerBName => get<String>(keyPlayerBName);
  set setPlayerBName(String name) => set<String>(keyPlayerBName, name);

  String? get getPlayerBAvatar => get<String>(keyPlayerBAvatar);
  set setPlayerBAvatar(String url) => set<String>(keyPlayerBAvatar, url);

  String? get getPlayerBImage=> get<String>(keyPlayerBImage);
  set setPlayerBImage(String url) => set<String>(keyPlayerBImage, url);

  UserModel? get getPlayerC => get<UserModel>(keyPlayerC);
  set setPlayerC(UserModel playerC) => set<UserModel>(keyPlayerC, playerC);

  UserModel? get getPlayerD => get<UserModel>(keyPlayerD);
  set setPlayerD(UserModel playerD) => set<UserModel>(keyPlayerD, playerD);

  int get getTeamScoreA {
    int? scoreA = get<int>(keyTeamAScore);
    if(scoreA==null){
      return 0;
    }
    else {
      return scoreA;
    }
  }
  set setTeamScoreA(int score) => set<int>(keyTeamAScore, score);

  int get getTeamScoreB {
    int? scoreB = get<int>(keyTeamBScore);
    if(scoreB==null){
      return 0;
    }
    else {
      return scoreB;
    }
  }
  set setTeamScoreB(int score) => set<int>(keyTeamBScore, score);

  int? get getTeamScoreC => get<int>(keyTeamCScore);
  set setTeamScoreC(int score) => set<int>(keyTeamCScore, score);

  int? get getTeamScoreD => get<int>(keyTeamDScore);
  set setTeamScoreD(int score) => set<int>(keyTeamDScore, score);

  int get getTeamAWins {
    int? teamAWins = get<int>(keyTeamAWins);
    if (teamAWins == null) {
      return 0;
    }
    else {
      return teamAWins;
    }
  }
  set setTeamAWins(int wins) => set<int>(keyTeamAWins, wins);

  int get getTeamBWins {
    int? teamBWins = get<int>(keyTeamBWins);
    if (teamBWins == null) {
      return 0;
    }
    else {
      return teamBWins;
    }
  }
  set setTeamBWins(int wins) => set<int>(keyTeamBWins, wins);

  int? get getTeamCWins => get<int>(keyTeamCWins);
  set setTeamCWins(int wins) => set<int>(keyTeamCWins, wins);

  int? get getTeamDWins => get<int>(keyTeamDWins);
  set setTeamDWins(int wins) => set<int>(keyTeamDWins, wins);

  int get getDraw {
    int? draw = get<int>(keyDraw);
    if (draw == null) {
      return 0;
    }
    else {
      return draw;
    }
  }
  set setDraw(int draw) => set<int>(keyDraw, draw);

  int? get getTimer=> get<int>(keyTimer);
  set setTimer(int time) => set<int>(keyTimer, time);

  int? get getTime=> get<int>(keyTime);
  set setTime(int time) => set<int>(keyTime, time);

  int? get getTotalRounds=> get<int>(keyTotalRounds);
  set setTotalRounds(int rounds) => set<int>(keyTotalRounds, rounds);

  int? get getCurrentRounds=> get<int>(keyCurrentRound);
  set setCurrentRounds(int round) => set<int>(keyCurrentRound, round);

  String? get getLiveObjectId => get<String>(keyLiveObjectId);
  set setLiveObjectId(String id) => set<String>(keyLiveObjectId, id);

  TimerModel? get getTimerModel => get<TimerModel>(keyTimerModel);
  set setTimerModel(TimerModel model) => set<TimerModel>(keyTimerModel, model);

  List<dynamic>? get getTeamAGiftsList {

    List<dynamic> gifts = [];

    List<dynamic>? gift = get<List<dynamic>>(keyTeamAGiftsList);
    if(gift != null && gift.length > 0){
      return gift;
    } else {
      return gifts;
    }
  }
  set setTeamAGift(Map<String,dynamic> gift) => setAdd(keyTeamAGiftsList, gift);


  List<dynamic>? get getTeamBGiftsList {

    List<dynamic> gifts = [];

    List<dynamic>? gift = get<List<dynamic>>(keyTeamBGiftsList);
    if(gift != null && gift.length > 0){
      return gift;
    } else {
      return gifts;
    }
  }
  set setTeamBGift(Map<String,dynamic> gift) => setAdd(keyTeamBGiftsList, gift);

  String? get getBackgroundImage => get<String>(keyBackgroundImage);
  set setBackgroundImage(String image) => set<String>(keyBackgroundImage, image);





}