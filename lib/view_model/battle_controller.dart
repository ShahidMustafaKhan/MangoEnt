import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view/screens/home/battle.dart';
import 'package:teego/view_model/ranking_controller.dart';
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
  late LiveQuery liveQueryDual;
  Subscription? subscriptionDual;
  Timer? _timer;
  late BattleModel _battleModel;
  late TimerModel _timerModel;
  bool versusAnimationLoaded = false;
  bool versusAnimation = false;
  bool clock = false;
  bool progressBar = false;
  bool result = false;
  RxString clockTime=''.obs;
  bool lapse=false;
  int teamAGiftListLength = 0;
  int teamBGiftListLength = 0;

  // Getters
  bool get isBattleView => _isBattleView;

  bool get showVersusAnimation => versusAnimation;
  
  bool get showClock => clock;

  bool get showProgressBar => progressBar;

  bool get showResult => result;

  bool get getLapse => lapse;

  BattleModel get battleModel => _battleModel;

  // Constructor
  BattleViewModel() {
    _isBattleView = false;
    liveQuery = LiveQuery();
    liveQueryDual = LiveQuery();
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

  set setVersusAnimation(bool value) {
    versusAnimation = value;
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

  bool get isCurrentUserPlayerB{
    if(_battleModel.getPlayerB!=null)
    return _battleModel.getPlayerB!.getUid ==
        Get.find<UserViewModel>().currentUser.getUid;
    else
      return false;

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
  // ------------------------------------ Host Side Logic-----------------------------------------------------------------------
  
  //Step 1 when host send a invitation to another host
  Future<void> initializeBattle({required int time, required int rounds, required UserModel host, required String liveObjectId, required LiveStreamingModel liveObject }) async {
    _battleModel
      ..setTime = time * 60
      // ..setTime = 30
      ..setTotalRounds = rounds
      ..setCurrentRounds = 1
      ..setTeamAWins = 0
      ..setTeamBWins = 0
      ..setHost = host
      ..setTeamScoreA = 0
      ..setTeamScoreB = 0
      ..setBattleStarted = false
      ..setLiveObjectId = liveObjectId
      ..setLiveObject= liveObject
      ..setHostUid = host.getUid!
      ..setBackgroundImage = Get.find<LiveViewModel>().backgroundImage.value;
    ;
    
    ParseResponse response = await _battleModel.save();
    if(response.success) {
      Get.find<LiveViewModel>().addBattleModel(_battleModel);
      saveTimerModel(_battleModel);
      update();
    }
  }

  //Step 2: addBattleModel to LiveStreaming Object and saveTimerModel 
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

  //Step 3: save timerModel object to battleModel
  Future<void> addTimerModel(TimerModel timerModel) async {
    _battleModel.setTimerModel=timerModel;
    ParseResponse response = await _battleModel.save();
    if(response.success){
      update();
    }
  }
  
  //Step 4: if player accepted host invitation then onPkFunction will bw triggered
  // Get.find<BattleViewModel>().setBattleView=true;
  // Get.find<BattleViewModel>().subscribeBattleModel(Get.find<UserViewModel>().currentUser.getUid!);

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
        !versusAnimationLoaded &&
        !isHost) {
      versusAnimationLoaded = true;

      triggerVersusAnimation();
    }

    _battleModel.setHostUid = value.getHostUid!;
    if(lapse==false){
      _battleModel.setTeamScoreA = value.getTeamScoreA ?? 0;
      _battleModel.setTeamScoreB = value.getTeamScoreB ?? 0;
    }
    _battleModel.setCurrentRounds= value.getCurrentRounds ?? 1;
    _battleModel.setTotalRounds= value.getTotalRounds!;
    _battleModel.setTeamAWins= value.getTeamAWins ?? 0;
    _battleModel.setTeamBWins= value.getTeamBWins ?? 0;
    _battleModel.setDraw= value.getDraw ;
    getPlayerB(value.getPlayerB);
    changeBackgroundImage(value);

    update();
  }
  
  
  // Step 5: if host clicked on start Button then 
  // setBattleStarted=true;  // updated db that battle is started
  // triggerVersusAnimation(); load versus animation


  // Step 6: versus animation is triggered after 1 second delay.  => repeated from here for all three entities
  // bannerAnimation is turn to true so that versus Animation is visible
  // avatarAnimation is true to true so avatar are visible
  // animation is triggered and when completed we turn off value of bannerAnimation and avatar
  // then we turn on flags for clock, progress bar so that are visible
  // host will start Time and index animation will also be triggered.

  void triggerVersusAnimation(){
    _startDelay();
  }

  void _startDelay() async {
    setVersusAnimation = true;
    setClock = true;
    setProgressBar = true;
    await Future.delayed(Duration(seconds: 5));
    setVersusAnimation = false;
    if(isHost==true)
      startTimer();
    Get.find<AnimationViewModel>().runIndexAnimation();
  }

  //step 7: startTimer is called then a timer is started which run every second and updateClockTime function is run
  //update clock time function will set timer value by subtracting 1 to it's original value and clock value every second.
  // when 5 seconds are left resetLapseTimer to 60 seconds and saved.
  // once timer hit 0 we cancel timer, trigger result animation and setTimer and clock value to 0.

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
    });
  }

  void updateClockTime() async {
    _timerModel.setTimer = _timerModel.getTimer! - 1;
    clockTime.value = (_timerModel.getTimer!).toString();
    _timerModel.save();
  }

  Future<void> resetLapseTimer() async {
    _timerModel.setLapseTimer = 60;
    _timerModel.save();
  }

  void cancelTimerIfActive() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  //Step 8 triggerResultAnimation()
  //  setResult to true, just use for condition to show result animation
  //  we will run draw or win and lose animation.
  // checkTotalRounds() is triggered.

  void triggerResultsAnimation() {
    setResult = true;
    if(leftScoreCard==rightScoreCard){
      Get.find<AnimationViewModel>().runDrawAnimation(() => null);
    }
    else{
      Get.find<AnimationViewModel>().runWinAnimation(() => null);
      Get.find<AnimationViewModel>().runLoseAnimation(() => null);
    }

    checkTotalRounds();
  }

  // Step 9 checkTotalRounds
  // if battle is of 3 rounds then we go for checkCurrentRound()
  //else we show results for 15 seconds and trigger resetBattleState function.
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

  // Step 10 if 3 round match
  // if currentRound is not 3 than we change lapse value to true and save on db. also we run LapseTimer.
  // when lapse value to true we reset clock value to lapseTime in timer model
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

  // Step 11 startLapseTimer()
  // lapse time is already reset to 60 seconds when 5 second were left for battle Timer
  // lapse timer go on for 60 seconds and every second, clock time is updated,
  // once it's reached zero than endLapseTimer() that will make the lapseTime value to zero on database.
  // cancel timer
  // resetBattleForNextRound()


  void startLapseTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
    clockTime.value = _timerModel.getLapseTimer!.toString();
    ParseResponse response = await _timerModel.save();
    if (response.success) {
    }
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

  set setLapse(bool value) {
    if(value==true)
      clockTime.value=_timerModel.getLapseTimer!.toString();
    else
    if(_battleModel.getCurrentRounds != 3)
      clockTime.value=_timerModel.getTimer!.toString();
    lapse = value;
    update();
  }

  // Step 12 resetBattleForNextRound()  // only for 3 rounds pk battle
  // we reset all json animations
  // all flags will be turned off
  //Lapse value turned off
  //if currentRound != 3 then clock reset to getTimer value
  // battleStarted will remain on*
  // clockTime value will be reset to time value.


  Future<void> resetBattleForNextRound() async {
    Get.find<AnimationViewModel>().resetJsonAnimationsController();
    setLapse = false; // lapse value turn off
    result = false;
    versusAnimationLoaded = false;
    versusAnimation = false;
    clockTime.value = _battleModel.getTime!.toString();
    if(isHost){
      updateGameResultCount();
      _battleModel.setTeamScoreA = 0;
      _battleModel.setTeamScoreB = 0;
      _battleModel.setCurrentRounds= _battleModel.getCurrentRounds! + 1;
      ParseResponse response = await _battleModel.save();
      if (response.success) {
        resetTimerModel().then((value){
          triggerVersusAnimation();
        });
        update();
      }
    }
    else{
      triggerVersusAnimation();
    }

  }

  // Step 13
  // host Side Logic
  // updateGameResultCount() => if team A score is high we add 1 win for team A same goes for teamB and if equal we counter draw.
  // we setTimer again to original battle time. * we should reset it when lapse timer at 5. teamScoreA And B to 0, to reset progress bar.
  // currentRound increment by 1


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

  // Step 14
  // resetTimerModel()
  // setTimer to battle time
  //clock time to battle time
  // repeat Step 6 triggerVersusAnimation()
  Future<void> resetTimerModel({bool endBattle=false}) async {
    if(endBattle==true)
      _timerModel.setLapseTimer= 60;
    _timerModel.setTimer = _timerModel.getTime!;  // * we set the timer while lapse at 15
    clockTime.value = _timerModel.getTime!.toString(); //
    _timerModel.setLapse=false;
    ParseResponse response = await _timerModel.save();
    if (response.success) {
      update();
    }
  }

  // Step 15
  // after 3 rounds we go to step 10 to checkCurrentRounds
  // set Lapse value to false and saveLapsevalue to db.
  // after 15 seconds we set result to off and reset resetBattleState()
  
  
  // Step 16 resetBattleState
  // jsonAnimation are reset
  // all flags are false
  // setBattleStarted to false
  // reset clock to battle time and hiddem
  // updateGameResultCount and resetBattleModel and resetTimerModel
  

  void resetBattleState({bool endBattle = false}) {
    Get.find<AnimationViewModel>().resetJsonAnimationsController();
    setResult = false;
    versusAnimationLoaded = false;
    setProgressBar = false;
    setClock = false;
    _battleModel.setBattleStarted = false;
    versusAnimation = false;
    if(_timerModel.getTime!=null)
      clockTime.value = _timerModel.getTime!.toString();
    _battleModel.setCurrentRounds = 1;
    if(endBattle==true){
      _timerModel= TimerModel();
      _battleModel= BattleModel();
    }
    if(isHost && endBattle==false){
      updateGameResultCount(endBattle: endBattle);
      resetBattleModel(endBattle: endBattle);}
  }

  Future<void> resetBattleModel({bool endBattle = false}) async {
    _battleModel.setTeamScoreA = 0;
    _battleModel.setTeamScoreB = 0;
    _battleModel.setCurrentRounds = 1;
    _battleModel.setBattleStarted=false;
    ParseResponse response = await _battleModel.save();
    if (response.success) {
      setLapse=false;
      resetTimerModel(endBattle: endBattle);
      update();
    }
  }
  
  //  ------------------------------------ Player Side Logic-----------------------------------------------------------------------
  // after accepting Invitation
  // Step 1
  //  Get.find<BattleViewModel>().fetchBattleModel(int.parse(event.invitation.inviterID!));
  
  // Step 2
  // setPlayerBModel
  // subscribeBattleModel // if battleStarted==false then startVersusAnimation
  // setTimerModelForAudienceAndPlayer

  Future<void> fetchBattleModelForPlayerSideLogic(int hostUid) async {
    QueryBuilder<BattleModel> query =
    QueryBuilder<BattleModel>(BattleModel())
      ..whereEqualTo(BattleModel.keyHostUid, hostUid)
      ..orderByDescending(BattleModel.keyCreatedAt)  // before invite host has already set a new battleModel
      ..setLimit(1)
      ..includeObject([BattleModel.keyHost, BattleModel.keyPlayerB , BattleModel.keyLiveObject]);
    ParseResponse response = await query.query();
    if (response.success && response.results!.isNotEmpty) {

      _battleModel = response.results!.first as BattleModel;
      Get.find<LiveViewModel>().backgroundImage.value = _battleModel.getBackgroundImage ?? '';
      Get.find<LiveViewModel>().joinOtherHostSession(_battleModel.getLiveObjectId ?? '');
    if (_battleModel.getBattleStarted! == true) {    //  if battleStarted is true than trigger versus animation
        versusAnimationLoaded = true;
        triggerVersusAnimation();
      }
      update();
      setPlayerBModel(Get.find<UserViewModel>().currentUser);
      subscribeBattleModel(_battleModel.getHostUid!);
      setTimerModel(_battleModel);

    }
  }

  Future<void> setPlayerBModel(UserModel playerB) async {     // to setPlayerB userModel to battleObject
    _battleModel.setPlayerB = playerB;
    await _saveAndUpdate();
  }

  // step 4 setTimerModel player
  // we use battle model object to find timerModel
  //  we set timerModel, clock time to battle Time and subscribe timerModel
  void setTimerModel(BattleModel battleModel) async {
    QueryBuilder<TimerModel> query =
    QueryBuilder<TimerModel>(TimerModel());
    query.whereEqualTo(TimerModel.keyBattleObjectId, battleModel.objectId);
    query.setLimit(1);

    ParseResponse parseResponse = await query.query();
    if(parseResponse.success){
      if(parseResponse.results != null){
        TimerModel? timerModel = parseResponse.results!.first as TimerModel;
        if(Get.find<LiveViewModel>().role==ZegoLiveRole.audience)
          setTimerModelAudienceSideLogic(timerModel);
        else
          setTimerModelPlayerSideLogic(timerModel);
      }
      else{
        setTimerModel(battleModel);
      }

    }
  }

  void setTimerModelPlayerSideLogic(TimerModel timerModel){
    _timerModel = timerModel;
    clockTime.value=timerModel.getTime!.toString();
    subscribeTimerModel(_timerModel);
  }


  // Step 5 start from step 6 of host Logic after pkBattle=true listen from SubscribeBattleModel

  // ---------------------------- player logic end-----------------------------------


  //  ------------------------------------ Audience Side Logic start-----------------------------------------------------------------------
 // Step 1 , on Pk START
  // Get.find<BattleViewModel>().fetchBattleModelAudienceSideLogic();

  //Step 2 fetchBattleModelForAudience  if failed we using recursion
  // we save length of teamA and team B gift.
  // if battleStarted ; set Avatar to false and progress to true and run IndexAnimation
  // setTimerModel

  Future<void> fetchBattleModelAudienceSideLogic() async {
    _battleModel = await fetchBattleModelForAudience(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!.getUid!);
    teamAGiftListLength= _battleModel.getTeamAGiftsList!.length;
    teamBGiftListLength= _battleModel.getTeamBGiftsList!.length;
    audienceLogicIfBattleStarted();
    setTimerModel(_battleModel);
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

  void audienceLogicIfBattleStarted(){
    if(_battleModel.getBattleStarted==true){
      setProgressBar = true;

      Get.find<AnimationViewModel>().runIndexAnimation();
    }
  }

  // Step 3 timerModel we fetch it from battleObject and if lapse false we set value of battle timer else lapse timer
  // set clock to true and subscribe timerModel.
  // now go back to host side logic step 6 to start pk battle VersusAnimation

  void setTimerModelAudienceSideLogic(TimerModel timerModel){
    _timerModel = timerModel;
    if(_timerModel.getLapse == false)
      clockTime.value=_timerModel.getTimer!.toString();
    else
      clockTime.value=_timerModel.getLapseTimer!.toString();
    if(Get.find<LiveViewModel>().role==ZegoLiveRole.audience && _battleModel.getBattleStarted==true)
      setClock = true;
    subscribeTimerModel(_timerModel);
  }


  subscribeTimerModel(TimerModel timerModel) async {
    QueryBuilder<TimerModel> query =
    QueryBuilder<TimerModel>(TimerModel());

    query.whereEqualTo(TimerModel.keyObjectId, timerModel.objectId);

    query.includeObject([
      TimerModel.keyLiveStreaming
    ]);

    subscriptionDual = await liveQueryDual.client.subscribe(query);

    subscriptionDual!.on(LiveQueryEvent.update, (ParseObject value) async {
      if(kDebugMode){
        print('*** TimerModel UPDATE ***');
        print('*** TimerModel UPDATE ***');

      }
      if(lapse==false){
        clockTime.value = value[TimerModel.keyTimer].toString();

        if (clockTime.value.toString() == "0") {
            triggerResultsAnimation();
        }
      }
      else{
        _timerModel.setLapseTimer = value[TimerModel.keyLapseTimer];
        clockTime.value = value[TimerModel.keyLapseTimer].toString();

        if(clockTime.value.toString() == "0"){
          resetBattleForNextRound();
        }
      }
    });
  }


  //-------------------- on Pk Start----------------

  void onPkStart(){
    setBattleView=true;

    if(isHost){
      subscribeBattleModel(Get.find<UserViewModel>().currentUser.getUid!);
    }

    if(Get.find<LiveViewModel>().role==ZegoLiveRole.audience){
      fetchBattleModelAudienceSideLogic();
    }

    pauseLiveStreamingForPkPlayer(true);
  }


  // ------------------------- on Pk End----------------------
  void onPkEnd(){
    unSubscribeBattleModel();
    endBattleView();
    pauseLiveStreamingForPkPlayer(false);
    resetBackgroundForPkPlayer();
    Get.find<AnimationViewModel>().resetAllAnimationsController();
  }

  void endBattleView(){
    setBattleView=false;
    cancelTimerIfActive();
    resetBattleState(endBattle: true);
    // setBattleModel=new BattleModel();
  }

  pauseLiveStreamingForPkPlayer(bool value){
    if(isHost==false){
      if(value==false) {
        // Get.find<LiveViewModel>().startLive();
        Get.find<LiveViewModel>().backToLiveSession();
      }
    }
  }

  resetBackgroundForPkPlayer(){
    if(isHost==false && Get.find<LiveViewModel>().role!=ZegoLiveRole.audience)
        Get.find<LiveViewModel>().backgroundImage.value= Get.find<LiveViewModel>().liveStreamingModel.getBackgroundImage ?? '';
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



  Future<void> unSubscribeBattleModel() async {
    if (subscription != null) {
      liveQuery.client.unSubscribe(subscription!);
    }
    if (subscriptionDual != null) {
      liveQueryDual.client.unSubscribe(subscriptionDual!);
    }
    subscription = null;
    subscriptionDual = null;

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


  sendGiftToTeamA({required String gift, required String audio, required int coins}){
    _battleModel.setTeamAGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamScoreA= coins + _battleModel.getTeamScoreA;
    _battleModel.save();
    Get.find<RankingViewModel>().addRecord(coins);
    Get.find<UserViewModel>().deductBalance(coins);
    Get.find<LiveViewModel>().incrementCount(coins);

  }

  sendGiftToTeamB({required String gift, required String audio, required int coins}){
    _battleModel.setTeamBGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamScoreB= coins + _battleModel.getTeamScoreB;
    _battleModel.save();
    Get.find<RankingViewModel>().addRecord(coins);
    Get.find<UserViewModel>().deductBalance(coins);
    Get.find<LiveViewModel>().incrementCount(coins);


  }

  sendGiftToAllTeams({required String gift, required String audio, required int coins}){
    _battleModel.setTeamAGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamBGift={"gift": gift, "audio" : audio, "name" : Get.find<UserViewModel>().currentUser.getFullName, "avatar" : Get.find<UserViewModel>().currentUser.getAvatar!.url! };
    _battleModel.setTeamScoreA= coins + _battleModel.getTeamScoreA;
    _battleModel.setTeamScoreB= coins + _battleModel.getTeamScoreB;
    _battleModel.save();
    Get.find<RankingViewModel>().addRecord(coins);
    Get.find<UserViewModel>().deductBalance(coins);
    Get.find<LiveViewModel>().incrementCount(coins);

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

  changeBackgroundImage(BattleModel value){
    if(value.getBackgroundImage != null)
      Get.find<LiveViewModel>().
      backgroundImage.value = value.getBackgroundImage!;
  }






}
