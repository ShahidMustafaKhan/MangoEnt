import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'LiveStreamingModel.dart';

class TimerModel extends ParseObject implements ParseCloneable {

  static final String keyTableName = "Timer";

  TimerModel() : super(keyTableName);
  TimerModel.clone() : this();

  @override
  TimerModel clone(Map<String, dynamic> map) => TimerModel.clone()..fromJson(map);



  static String keyCreatedAt = "createdAt";
  static String keyObjectId = "objectId";

  static String keyLiveStreaming = "liveStream";
  static String keyBattleObjectId = "battleObjectId";
  static String keyTimer = "timer";
  static String keyTime = "time";
  static String keyLapseTimer = "lapseTimer";
  static String keyLapse = "lapse";



  int? get getTimer => get<int>(keyTimer);
  set setTimer(int timer) => set<int>(keyTimer, timer);

  int? get getTime => get<int>(keyTime);
  set setTime(int time) => set<int>(keyTime, time);

  int? get getLapseTimer => get<int>(keyLapseTimer);
  set setLapseTimer(int timer) => set<int>(keyLapseTimer, timer);

  bool? get getLapse => get<bool>(keyLapse);
  set setLapse(bool value) => set<bool>(keyLapse, value);

  String? get getBattleObjectId => get<String>(keyBattleObjectId);
  set setBattleObjectId(String id) => set<String>(keyBattleObjectId, id);


  LiveStreamingModel? get getLiveStreaming => get<LiveStreamingModel>(keyLiveStreaming);
  set setLiveStreaming(LiveStreamingModel liveStreaming) => set<LiveStreamingModel>(keyLiveStreaming, liveStreaming);


}