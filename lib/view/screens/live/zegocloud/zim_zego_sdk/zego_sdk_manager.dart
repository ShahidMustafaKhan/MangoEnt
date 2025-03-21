import 'internal/sdk/express/express_service.dart';
import 'internal/sdk/zim/zim_service.dart';

export 'internal/sdk/express/express_service.dart';
export 'internal/sdk/zim/zim_service.dart';

class ZEGOSDKManager {
  ZEGOSDKManager._internal();
  factory ZEGOSDKManager() => instance;
  static final ZEGOSDKManager instance = ZEGOSDKManager._internal();

  ExpressService expressService = ExpressService.instance;
  ZIMService zimService = ZIMService.instance;

  Future<void> init(int appID, String? appSign, {ZegoScenario scenario = ZegoScenario.Default}) async {
    await expressService.init(appID: appID, appSign: appSign);
    await zimService.init(appID: appID, appSign: appSign);
  }

  Future<void> connectUser(String userID, String userName, {String? token}) async {
    await expressService.connectUser(userID, userName, token: token);
    await zimService.connectUser(userID, userName, token: token);
  }

  Future<void> disconnectUser() async {
    await logoutRoom();
    await expressService.disconnectUser();
    await zimService.disconnectUser();
  }

  Future<void> uploadLog() async {
    await Future.wait([
      expressService.uploadLog(),
      zimService.uploadLog(),
    ]);
    return;
  }

  Future<ZegoRoomLoginResult> loginRoom(String roomID, ZegoScenario scenario, {String? token}) async {
    print(roomID);

    expressService.setRoomScenario(scenario).then((value){
      print("zegoroomScenarioworking");

      print(scenario.name);

    }).onError((error, stackTrace) {
      print("zegoroomScenario$error");



    });

    // await these two methods
    final expressResult = await expressService.loginRoom(roomID, token: token);
    if (expressResult.errorCode != 0) {
      print("expressResult${expressResult.errorCode}");

      return expressResult;
    }

    final zimResult = await zimService.loginRoom(roomID);

    // rollback if one of them failed
    if (zimResult.errorCode != 0) {
      print("zimResult${zimResult.errorCode}");

      expressService.logoutRoom();
    }
    return zimResult;
  }

  Future<void> logoutRoom() async {
    await expressService.logoutRoom();
    await zimService.logoutRoom();
  }

  ZegoSDKUser? get currentUser => expressService.currentUser;
  ZegoSDKUser? getUser(String userID) {
    for (final user in expressService.userInfoList) {
      if (userID == user.userID) {
        return user;
      }
    }
    return null;
  }
}
