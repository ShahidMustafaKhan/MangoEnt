import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view/screens/home/battle.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../parse/BattleStreamingModel.dart';
import '../parse/TimerModel.dart';
import '../parse/UserModel.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import 'animation_controller.dart';
import 'gift_contoller.dart';
import 'live_controller.dart';

class BattleViewModel extends GetxController with GetTickerProviderStateMixin {
  // Properties
  late bool _isBattleView;
  late LiveQuery liveQuery;
  Subscription? subscription;
  Timer? _timer;
  final RxBool showAvatar = false.obs;
  late BattleModel _battleModel;
  late TimerModel _timerModel;
  bool bannerLoaded = false;
  bool bannerAnimation = false;
  bool counterAnimation = false;
  bool clock = false;
  bool progressBar = false;
  bool result = false;
  RxString clockTime=''.obs;
  bool lapse=false;
  int teamAGiftListLength = 0;
  int teamBGiftListLength = 0;

  // Getters
  bool get isBattleView => _isBattleView;

  bool get showBannerAnimation => bannerAnimation;

  bool get showCounterAnimation => counterAnimation;

  bool get showClock => clock;

  bool get showProgressBar => progressBar;

  bool get showResult => result;

  bool get getLapse => lapse;

  BattleModel get battleModel => _battleModel;

  // Constructor
  BattleViewModel() {
    _isBattleView = false;
    liveQuery = LiveQuery();
    _battleModel = BattleModel();
    _timerModel = TimerModel();
  }

  // Setters
  set setBattleView(bool value) {
    _isBattleView = value;
    update();
    if(isHost)
      setBattleViewParse(value);
  }

  void setBattleViewParse(bool value){
    _battleModel.setBattleView=value;
    _battleModel.save();
  }

  set setBannerAnimation(bool value) {
    bannerAnimation = value;
    update();
  }

  set setCounterAnimation(bool value) {
    counterAnimation = value;
    update();
  }

  set setClock(bool value) {
    clock = value;
    update();
  }

  set setProgressBar(bool value) {
    progressBar = value;
    update();
  }

  set setResult(bool value) {
    result = value;
    update();
  }

  set setLapse(bool value) {
    if(value==true)
      clockTime.value=_timerModel.getLapseTimer!.toString();
    else
      if(_battleModel.getCurrentRounds != 3)
      clockTime.value=_timerModel.getTimer!.toString();
    lapse = value;
    update();
  }

  // Methods
  void showAvatarAnimation() {
    Timer(Duration(seconds: 6), () {
      showAvatar.value = true;
    });
  }

  // Add other methods as needed...

  @override
  void onClose() {
    unSubscribeBattleModel();
    cancelTimerIfActive();
    super.onClose();
  }



  // Setters and Getters
  set setBattleModel(BattleModel value) {
    _battleModel = value;
    update();
  }

  bool get isHost {
    return _battleModel.getHostUid == Get.find<UserViewModel>().currentUser.getUid;
  }

  set setBattleStarted(bool value) {
    _battleModel.setBattleStarted = value;
    _battleModel.save();
    update();
  }

  bool get isBattleStarted {
    return _battleModel.getBattleStarted == true;
  }

  String get hostName {
    return _battleModel.getHost?.getFirstName ?? '';
  }

  String get playerBName {
    return _battleModel.getPlayerB?.getFirstName ?? '';
  }

  String get playerBAvatar {
    return _battleModel.getPlayerB?.getAvatar?.url ?? '';
  }


  int get leftScoreCard => isHost || Get.find<LiveViewModel>().role==ZegoLiveRole.audience

  ? _battleModel.getTeamScoreA
      : _battleModel.getTeamScoreB ;

  int get rightScoreCard => isHost || Get.find<LiveViewModel>().role==ZegoLiveRole.audience
      ? _battleModel.getTeamScoreB
      : _battleModel.getTeamScoreA ;

  int get leftWinCount => isHost || Get.find<LiveViewModel>().role==ZegoLiveRole.audience
      ? _battleModel.getTeamAWins ?? 0
      : _battleModel.getTeamBWins ?? 0 ;

  int get rightWinCount => isHost || Get.find<LiveViewModel>().role==ZegoLiveRole.audience
      ? _battleModel.getTeamBWins ?? 0
      : _battleModel.getTeamAWins ?? 0 ;

  int get drawCount => _battleModel.getDraw;

  int get getHostScore => _battleModel.getTeamScoreA ?? 0;

  set hostScore(int value) {
    _battleModel.setTeamScoreA = value;
    _battleModel.save();
    update();
  }

  int get getPlayerBScore => _battleModel.getTeamScoreB ?? 0;

  set playerBScore(int value) {
    _battleModel.setTeamScoreA = value;
    _battleModel.save();
    update();
  }

  Future<void> initializeBattle({required int time, required int rounds, required UserModel host, required String liveObjectId, required LiveStreamingModel liveObject }) async {
    _battleModel
      ..setTimer = time * 60
      ..setTime = time * 60
      // ..setTimer = 60
      // ..setTime = 60
      ..setTotalRounds = rounds
      ..setCurrentRounds = 1
      ..setTeamAWins = 0
      ..setTeamBWins = 0
      ..setTeamBWins = 0
      ..setHost = host
      ..setTeamScoreA = 0
      ..setTeamScoreB = 0
      ..setBattleStarted = false
      ..setLiveObjectId = liveObjectId
      ..setLiveObject= liveObject
      ..setHostUid = host.getUid!;


    ParseResponse response = await _battleModel.save();
    if(response.success) {
      Get.find<LiveViewModel>().addBattleModel(_battleModel);
      saveTimerModel(_battleModel);
      update();
    }
  }

  Future<void> startBattle() async {
    await _updateBattleStatus(true);
  }

  Future<void> endBattle() async {
    await _updateBattleStatus(false);
  }

  Future<void> _updateBattleStatus(bool isStarted) async {
    _battleModel.setBattleStarted = isStarted;
    ParseResponse response = await _battleModel.save();
    if(response.success) {
      update();
    }
  }

  Future<void> setPlayerBModel(UserModel playerB) async {
    _battleModel.setPlayerB = playerB;
    await _saveAndUpdate();
  }

  Future<void> setTeamAScore(int score) async {
    _battleModel.setTeamScoreA = score;
    await _saveAndUpdate();
  }

  Future<void> setTeamBScore(int score) async {
    _battleModel.setTeamScoreB = score;
    await _saveAndUpdate();
  }

  Future<void> _saveAndUpdate() async {
    ParseResponse response = await _battleModel.save();
    if(response.success) {
      update();
    }
  }

  Future<void> getPlayerB(UserModel? playerB) async {
    if(playerB != null && playerB.objectId != null){
      if(playerB.getUid == null || playerB.getFirstName == null){
        UserModel? player =  await getPlayerModel(playerB);
        if(player != null){
          _battleModel.setPlayerB=player;
          update();
        }
      }
    }
  }

  Future<UserModel?> getPlayerModel(UserModel? player) async {
    QueryBuilder<UserModel> query = QueryBuilder(UserModel.forQuery());
    query.whereEqualTo(UserModel.keyObjectId, player!.objectId);

    ParseResponse response = await query.query();

    if(response.success){
     if(response.result!=null && response.result!.isNotEmpty){
       return response.result[0]! as UserModel;
     }
    }
    else{
      return null;
    }

    return null;
  }


  Future<void> saveTimerModel(BattleModel battleModel) async {
    _timerModel.setTimer=battleModel.getTime!;
    _timerModel.setTime=battleModel.getTime!;
    _timerModel.setLapseTimer=60;
    clockTime.value=battleModel.getTime!.toString();
    _timerModel.setBattleObjectId= battleModel.objectId!;
    ParseResponse response = await _timerModel.save();
    if(response.success){
      addTimerModel(_timerModel);
      update();
    }
  }

  Future<void> addTimerModel(TimerModel timerModel) async {
    _battleModel.setTimerModel=timerModel;
    ParseResponse response = await _battleModel.save();
    if(response.success){
      update();
    }
  }

  // void setTimerModelForAudienceAndPlayer(BattleModel battleModel) async {
  //
  //   print(battleModel.objectId);
  //   print(battleModel.objectId);
  //   print(battleModel.objectId);
  //   print(battleModel.objectId);
  //   print(battleModel.objectId);
  //   print(battleModel.objectId);
  //   QueryBuilder<BattleModel> query =
  //   QueryBuilder<BattleModel>(BattleModel());
  //   query.whereEqualTo(BattleModel.keyObjectId, battleModel.objectId);
  //   query.setLimit(1);
  //   query.includeObject([BattleModel.keyHost, BattleModel.keyPlayerB, BattleModel.keyTimerModel]);
  //
  //   ParseResponse parseResponse = await query.query();
  //   if(parseResponse.success){
  //     BattleModel battleModel = parseResponse.results!.first as BattleModel;
  //     if(battleModel.getTimerModel!=null){
  //       _timerModel = battleModel.getTimerModel!;
  //       _timerModel.setLapse=_timerModel.getLapse ?? false;
  //       clockTime.value=battleModel.getTime!.toString();
  //       if(Get.find<LiveViewModel>().role==ZegoLiveRole.audience && _battleModel.getBattleStarted==true)
  //         setClock = true;
  //       subscribeTimerModel(_timerModel);
  //     }
  //     // else{
  //     //   setTimerModelForAudienceAndPlayer(battleModel);
  //     // }
  //
  //   }
  // }

  void setTimerModelForAudienceAndPlayer(BattleModel battleModel) async {
    QueryBuilder<TimerModel> query =
    QueryBuilder<TimerModel>(TimerModel());
    query.whereEqualTo(TimerModel.keyBattleObjectId, battleModel.objectId);
    query.setLimit(1);
    // query.includeObject([BattleModel.keyHost, BattleModel.keyPlayerB, BattleModel.keyTimerModel]);

    ParseResponse parseResponse = await query.query();
    if(parseResponse.success){
      TimerModel? timerModel = parseResponse.results!.first as TimerModel;
      if(timerModel != null){
        _timerModel = timerModel;
        _timerModel.setLapse=timerModel.getLapse ?? false;
        clockTime.value=timerModel.getTime!.toString();
        if(Get.find<LiveViewModel>().role==ZegoLiveRole.audience && _battleModel.getBattleStarted==true)
          setClock = true;
        subscribeTimerModel(_timerModel);
      }
      else{
        setTimerModelForAudienceAndPlayer(battleModel);
      }

    }
  }


  Future<void> subscribeBattleModel(int hostUid) async {
    QueryBuilder<BattleModel> query =
    QueryBuilder<BattleModel>(BattleModel());
      query.whereEqualTo(BattleModel.keyHostUid, hostUid);
      query.includeObject([BattleModel.keyHost, BattleModel.keyPlayerB]);

    subscription = await liveQuery.client.subscribe(query);
    subscription!.on(LiveQueryEvent.update,  (BattleModel value) async {
      _handleBattleModelUpdate(value);
    });
  }

  void _handleBattleModelUpdate(BattleModel value) async {
    if(kDebugMode){
      print('*** battle UPDATE ***');
      print('*** battle UPDATE ***');
    }

    runGiftAnimationForTeamA(value);
    runGiftAnimationForTeamB(value);


    if (!_battleModel.getBattleStarted! &&
        value[BattleModel.keyBattleStarted] == true &&
        !bannerLoaded &&
        !isHost) {
      bannerLoaded = true;

      startBannerLoadingAnimation();
    }

    _battleModel.setHostUid = value.getHostUid!;
    if(lapse==false){
    _battleModel.setTeamScoreA = value.getTeamScoreA ?? 0;
    _battleModel.setTeamScoreB = value.getTeamScoreB ?? 0;}
    _battleModel.setCurrentRounds= value.getCurrentRounds ?? 1;
    _battleModel.setTotalRounds= value.getTotalRounds!;
    _battleModel.setTeamAWins= value.getTeamAWins ?? 0;
    _battleModel.setTeamBWins= value.getTeamBWins ?? 0;
    _battleModel.setDraw= value.getDraw ;
    getPlayerB(value.getPlayerB);

    update();
  }

  Future<void> unSubscribeBattleModel() async {
    if (subscription != null) {
      liveQuery.client.unSubscribe(subscription!);
    }
    subscription = null;
  }

  subscribeTimerModel(TimerModel timerModel) async {
    QueryBuilder<TimerModel> query =
    QueryBuilder<TimerModel>(TimerModel());

    query.whereEqualTo(TimerModel.keyObjectId, timerModel.objectId);

    query.includeObject([
      TimerModel.keyLiveStreaming
    ]);

    subscription = await liveQuery.client.subscribe(query);

    subscription!.on(LiveQueryEvent.update, (ParseObject value) async {
     if(kDebugMode){
       print('*** TimerModel UPDATE ***');
       print('*** TimerModel UPDATE ***');

     }

        if(lapse==false){
          clockTime.value = value[TimerModel.keyTimer].toString();

          if (value[TimerModel.keyTimer] == 0) {
            triggerResultsAnimation();
          }
        }
        else{
          _timerModel.setLapseTimer = value[TimerModel.keyLapseTimer];
          clockTime.value = value[TimerModel.keyLapseTimer].toString();

          if(int.parse(clockTime.value) == 0){
            resetBattleForNextRound();
          }
        }



    });
  }

  Future<void> fetchBattleModelFromLiveObject() async {
    _battleModel = await fetchBattleModelForAudience(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!.getUid!);
    teamAGiftListLength= _battleModel.getTeamAGiftsList!.length;
    teamBGiftListLength= _battleModel.getTeamBGiftsList!.length;
    audienceEnterLogic();
    setTimerModelForAudienceAndPlayer(_battleModel);
    subscribeBattleModel(Get.find<LiveViewModel>().liveStreamingModel.getAuthorUid!);
    update();
  }

  Future<BattleModel> fetchBattleModelForAudience(int hostUid) async {
    QueryBuilder<BattleModel> query =
    QueryBuilder<BattleModel>(BattleModel())
      ..whereEqualTo(BattleModel.keyHostUid, hostUid)
      ..orderByDescending(BattleModel.keyCreatedAt)
      ..includeObject([BattleModel.keyHost, BattleModel.keyPlayerB]);

    ParseResponse response = await query.query();
    if (response.success && response.results!.isNotEmpty) {
      _battleModel = response.results!.first as BattleModel;
     return _battleModel;
    }
    else
      return fetchBattleModelForAudience(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!.getUid!);
  }

  void audienceEnterLogic(){
    if(_battleModel.getBattleStarted==true){
      showAvatar.value = false;
      setProgressBar = true;

      Get.find<AnimationViewModel>().runIndexAnimation();
    }
  }

  Future<void> fetchBattleModel(int hostUid) async {
    QueryBuilder<BattleModel> query =
    QueryBuilder<BattleModel>(BattleModel())
      ..whereEqualTo(BattleModel.keyHostUid, hostUid)
      ..orderByDescending(BattleModel.keyCreatedAt)
      ..setLimit(1)
      ..includeObject([BattleModel.keyHost, BattleModel.keyPlayerB]);

    ParseResponse response = await query.query();
    if (response.success && response.results!.isNotEmpty) {

      _battleModel = response.results!.first as BattleModel;
      update();
      setPlayerBModel(Get.find<UserViewModel>().currentUser);
      subscribeBattleModel(_battleModel.getHostUid!);
      setTimerModelForAudienceAndPlayer(_battleModel);

    }
  }

  Future<void> updatePkBattleModel() async {
    QueryBuilder<BattleModel> query =
    QueryBuilder<BattleModel>(BattleModel())
      ..whereEqualTo(BattleModel.keyObjectId, _battleModel.objectId)
      ..includeObject([BattleModel.keyHost, BattleModel.keyPlayerB]);

    ParseResponse response = await query.query();
    if (response.success && response.results!.isNotEmpty) {
      _battleModel = response.results!.first as BattleModel;
      update();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateClockTime();
      if(int.parse(clockTime.value) == 5){
       resetLapseTimer();
      }
      if(int.parse(clockTime.value) == 0){
        cancelTimerIfActive();
        triggerResultsAnimation();
        _timerModel.setTimer = 0;
        clockTime.value = 0.toString();
      }
      if (int.parse(clockTime.value) <= 0) {

      }
    });
  }

  void updateClockTime() async {
    _timerModel.setTimer = _timerModel.getTimer! - 1;
    clockTime.value = (_timerModel.getTimer! - 1).toString();
    ParseResponse response = await _timerModel.save();
    if (response.success) {
    }
  }

  void startLapseTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      clockTime.value=_timerModel.getTimer!.toString();
      updateLapseTime();
      if(int.parse(clockTime.value) == 0){
        endLapseTimer();
        cancelTimerIfActive();
        resetBattleForNextRound();
      }
    });
  }

  void updateLapseTime() async {
    _timerModel.setLapseTimer = _timerModel.getLapseTimer! - 1;
    clockTime.value = (_timerModel.getLapseTimer! - 1).toString();
    ParseResponse response = await _timerModel.save();
    if (response.success) {
    }
  }

  Future<void> resetLapseTimer() async {
    _timerModel.setLapseTimer = 60;
    _timerModel.save();
  }

  Future<void> endLapseTimer() async {
    _timerModel.setLapseTimer = 0;
    _timerModel.save();
  }

  saveLapseValue(bool value){
    if(isHost){
    _timerModel.setLapse=value;
    _timerModel.save();}
  }


  void cancelTimerIfActive() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  String getFormattedTimer(int clockTime) {
     if(clockTime>10){
       return formatTime(clockTime);
     }
     else if(clockTime<=10 && clockTime!=0){
       return clockTime.toString();
     }
     else {
       if(lapse==false){
         return 'Result';
       }
       else{
         return '';
       }
     }
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (seconds < 10) ? '0$seconds' : '$seconds';

    return '$minutesStr:$secondsStr';
  }

  void triggerResultsAnimation() {
    setResult = true;
    if(leftScoreCard==rightScoreCard){
      Get.find<AnimationViewModel>().runDrawAnimation(() => null);
    }
    else{
      Get.find<AnimationViewModel>().runWinAnimation(() => null);
      Get.find<AnimationViewModel>().runLoseAnimation(() => null);
    }
    cancelTimerIfActive();
    setResult = true;
    checkTotalRounds();

  }

  void checkTotalRounds(){
    if(_battleModel.getTotalRounds == 3) {
      checkCurrentRound();
    }
    else {
      Timer(Duration(seconds: 15), () {
        setLapse = false;
        setResult = false;
        resetBattleState();
      });
    }
  }

  void checkCurrentRound(){
    if(_battleModel.getCurrentRounds==3){
      setLapse = false;
      saveLapseValue(false);
      Timer(Duration(seconds: 15), () {
        setResult = false;
        resetBattleState();
      });
    }
    else {
      setLapse = true;
      runLapseTimer();
      saveLapseValue(true);
    }
  }

  runLapseTimer(){
    if(isHost)
    startLapseTimer();
  }

  Future<void> resetBattleForNextRound() async {
    Get.find<AnimationViewModel>().resetJsonAnimationsController();
    showAvatar.value = false;
    setResult = false;
    setLapse = false;
    bannerLoaded = false;
    setBannerAnimation = false;
    clockTime.value = _battleModel.getTime!.toString();

    if(isHost){
      updateGameResultCount();
      _battleModel.setTimer = _battleModel.getTime!;
      _battleModel.setTeamScoreA = 0;
      _battleModel.setTeamScoreB = 0;
      _battleModel.setCurrentRounds= _battleModel.getCurrentRounds! + 1;
      ParseResponse response = await _battleModel.save();
      if (response.success) {
        resetTimerModel().then((value){
          startBannerLoadingAnimation();
        });
        update();
      }
    }
    else{
      startBannerLoadingAnimation();
    }

  }


  void resetBattleState({bool endBattle = false}) {
    Get.find<AnimationViewModel>().resetJsonAnimationsController();
    showAvatar.value = false;
    setResult = false;
    bannerLoaded = false;
    setProgressBar = false;
    setClock = false;
    _battleModel.setBattleStarted = false;
    setBannerAnimation = false;
    if(_battleModel.getTime!=null)
    clockTime.value = _battleModel.getTime!.toString();
    _battleModel.setCurrentRounds = 1;
    if(!isHost && endBattle==true){
      _timerModel=new TimerModel();
      _battleModel=new BattleModel();
    }
    // _battleModel.setTeamScoreA = 0;
    // _battleModel.setTeamScoreB = 0;
    if(isHost){
    updateGameResultCount(endBattle: endBattle);
    resetBattleModel(endBattle: endBattle);}
  }

  Future<void> resetBattleModel({bool endBattle = false}) async {
    _battleModel.setTimer = _battleModel.getTime!;
    _battleModel.setTeamScoreA = 0;
    _battleModel.setTeamScoreB = 0;
    _battleModel.setCurrentRounds = 1;
    _battleModel.setBattleStarted=false;
    ParseResponse response = await _battleModel.save();
    if (response.success) {
      setLapse=false;
      resetTimerModel(endBattle: endBattle);
      // Get.find<LiveViewModel>().addBattleModel(_battleModel);
      update();
    }
  }

  Future<void> resetTimerModel({bool endBattle=false}) async {
    if(endBattle==true)
    _timerModel.setLapseTimer= 60;
    _timerModel.setTimer = _timerModel.getTime!;
    clockTime.value = _timerModel.getTime!.toString();
    _timerModel.setLapse=false;

    ParseResponse response = await _timerModel.save();
    if (response.success) {
      update();
    }
  }

  void endBattleView({bool endBattle=false}){
    setBattleView=false;
    cancelTimerIfActive();
    resetBattleState(endBattle: endBattle);
    setBattleModel=BattleModel();
  }

  double calculatePkProgressScore() {
    double percentageDifference;
    if (leftScoreCard > rightScoreCard) {
      percentageDifference = ((leftScoreCard - rightScoreCard) / leftScoreCard).abs();
      if(percentageDifference>=0.5)
        percentageDifference = 0 + percentageDifference;
      else
        percentageDifference = 0.5 + percentageDifference;

    }
    else if (leftScoreCard < rightScoreCard){
      percentageDifference = ((leftScoreCard - rightScoreCard) / rightScoreCard).abs();
      if(percentageDifference>=0.5)
        percentageDifference = 1 - percentageDifference;
      else
        percentageDifference = 0.5 - percentageDifference;
    }
    else {
      return 0.5;
    }

    return percentageDifference;

  }

  void updateGameResultCount({bool endBattle = false}){
    if(_battleModel.getTeamScoreA  >  _battleModel.getTeamScoreB){
      if(endBattle==false)
      _battleModel.setTeamAWins =  _battleModel.getTeamAWins +  1 ;
      else
        _battleModel.setTeamAWins=0;
    }
    else if(_battleModel.getTeamScoreA  <  _battleModel.getTeamScoreB){
      if(endBattle==false)
      _battleModel.setTeamBWins = _battleModel.getTeamBWins + 1 ;
      else
        _battleModel.setTeamBWins = 0;
    }
    else if(_battleModel.getTeamScoreA  ==  _battleModel.getTeamScoreB){
      if(endBattle==false)
      _battleModel.setDraw =  _battleModel.getDraw + 1 ;
      else
        _battleModel.setDraw = 0;
    }

  }


  // animations

  void startBannerLoadingAnimation(){
    Future.delayed(Duration(seconds: 1), () {
      setBannerAnimation = true;
      showAvatar.value = true;
      Get.find<AnimationViewModel>().runVersusAnimation(() {
        showAvatar.value = false;
        setClock = true;
        setProgressBar = true;
        if(isHost==true)
          startTimer();
        Get.find<AnimationViewModel>().runIndexAnimation();
      });
    });

  }

  // pause live streaming

  pauseLiveStreamingForPkPlayer(bool value){
    if(isHost==false && Get.find<LiveViewModel>().role!=ZegoLiveRole.audience){
      if(value==true)
        Get.find<LiveViewModel>().endLive();
      else
        Get.find<LiveViewModel>().startLive();
    }

  }


  sendGiftToTeamA({required String gift, required String audio, required int coins}){
    _battleModel.setTeamAGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamScoreA= coins + _battleModel.getTeamScoreA;
    _battleModel.save();
  }

  sendGiftToTeamB({required String gift, required String audio, required int coins}){
    _battleModel.setTeamBGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamScoreB= coins + _battleModel.getTeamScoreB;
    _battleModel.save();
  }

  sendGiftToAllTeams({required String gift, required String audio, required int coins}){
    _battleModel.setTeamAGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamBGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamScoreA= coins + _battleModel.getTeamScoreA;
    _battleModel.setTeamScoreB= coins + _battleModel.getTeamScoreB;

    _battleModel.save();
  }

  runGiftAnimationForTeamA(BattleModel value){
    if(isHost || Get.find<LiveViewModel>().role==ZegoLiveRole.audience){
      if(value.getTeamAGiftsList!.length > teamAGiftListLength){
        teamAGiftListLength=value.getTeamAGiftsList!.length;
        Map lastGift=value.getTeamAGiftsList!.last;
        String gift= lastGift["gift"];
        String audio = lastGift["audio"];
        Get.find<GiftViewModel>().loadAnimation(gift, audio);
      }
    }
  }

  runGiftAnimationForTeamB(BattleModel value){
    if(!isHost || Get.find<LiveViewModel>().role==ZegoLiveRole.audience) {
      if (value.getTeamBGiftsList!.length > teamBGiftListLength) {
        teamBGiftListLength = value.getTeamBGiftsList!.length;
        Map lastGift = value.getTeamBGiftsList!.last;
        String gift = lastGift["gift"];
        String audio = lastGift["audio"];
        Get.find<GiftViewModel>().loadAnimation(gift, audio);
      }
    }
  }








}
