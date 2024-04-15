import 'package:flutter/material.dart';
import '../../../../../../../utils/Utils.dart';
import '../../internal/business/audioRoom/live_audio_room_seat.dart';
import '../../internal/sdk/express/express_service.dart';

class ZegoSeatItemView extends StatefulWidget {
  const ZegoSeatItemView(
      {
      required this.seat,
      required this.lockSeatNoti,
      this.onPressed,
      this.onLongPressed,

      });

  final ZegoLiveAudioRoomSeat seat;
  final ValueNotifier<bool> lockSeatNoti;

  final void Function(ZegoLiveAudioRoomSeat seat)? onPressed;
  final void Function(ZegoLiveAudioRoomSeat seat)? onLongPressed;

  @override
  State<ZegoSeatItemView> createState() => _ZegoSeatItemViewState();
}

class _ZegoSeatItemViewState extends State<ZegoSeatItemView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return ValueListenableBuilder<ZegoSDKUser?>(
        valueListenable: widget.seat.currentUser,
        builder: (context, user, _) {
          if (user != null) {
            return userSeatView(user,fem,ffem);
          } else {
            return emptySeatView(fem,ffem);
          }
        });
  }

  Widget userSeatView(ZegoSDKUser userInfo, double fem, double ffem) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) widget.onPressed!(widget.seat);
      },
      // onTap: (){
      //   if (widget.onLongPressed != null) widget.onLongPressed!;
      // },
      child: userAvatar(userInfo,fem,ffem),
    );
  }

  Widget userAvatar(ZegoSDKUser userInfo, double fem, double ffem) {
    return ValueListenableBuilder<String?>(
        valueListenable: userInfo.avatarUrlNotifier,
        builder: (context, avatarUrl, _) {
          if (avatarUrl != null && avatarUrl.isNotEmpty) {
            return activeUser(userInfo,fem, ffem, widget.seat.seatIndex, widget.seat.seatIndex==0, context, vip: true);
          } else {
            return SizedBox(
              width: 55,
              height: 55,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                            height: 20,
                            child: Text(
                              userInfo.userID.substring(0, 1),
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
                      ))),
            );
          }
        });
  }

  Widget userNameText(ZegoSDKUser userInfo) {
    return SizedBox(
      height: 10,
      child: Text(
        userInfo.userName,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget emptySeatView(double fem, double ffem) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null && !widget.lockSeatNoti.value) {
          widget.onPressed!(widget.seat);
        }
      },
      child: setEmptySeatView(fem,ffem),
    );
  }

  Widget setEmptySeatView(double fem, double ffem) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.lockSeatNoti,
        builder: (context, isLock, _) {
          return inActiveUser(fem, ffem, widget.seat.seatIndex);
        });
  }

  Widget emptySeatImage(bool isLock) {
    return isLock
        ? Image.asset(
            'assets/icons/seat_lock_icon.png',
            fit: BoxFit.fill,
          )
        : Image.asset(
            'assets/dino/sofa.png',
            fit: BoxFit.fill,
          );
  }

  Widget activeUser(ZegoSDKUser userInfo,double fem, double ffem, int index, bool isHost, BuildContext context, {bool vip=false}){
    return InkWell(
      child: Container(
        // seatuJy (1:6847)
        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
        padding: EdgeInsets.only(top: isHost?3:0),
        height: isHost? 81.75*fem : 77.45*fem,
        width:  55*fem,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
              width: 55*fem,
              height: 55*fem,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  isHost ? Positioned(
                    // activeusermc5 (I1:6847;112:14805)
                    left:  isHost? -6.5: 0,
                    top:  isHost? -6.5: 0,
                    child: Align(
                      child: SizedBox(
                        width: 68*fem,
                        height: 68*fem,
                        child: Image.asset(
                          'assets/audio_room/activeuser.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ): SizedBox(),
                  Positioned(
                    // usersv1 (I1:6847;111:14760)
                    left: 0,
                    top:  0,
                    child: Align(
                      child: SizedBox(
                        width: 55*fem,
                        height: 55*fem,
                        child: Container(
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(27.5*fem),
                            image: DecorationImage (
                              fit: BoxFit.cover,
                              image: NetworkImage (
                                userInfo.avatarUrlNotifier.value!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupxfo7mkV (9Y5nGvYmWHvDsVmv2jxFo7)
              margin: EdgeInsets.fromLTRB(vip?2*fem: 2*fem, 8.45*fem, 0*fem, 0*fem),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vip? Container(
                    // starVwP (I1:6847;111:14757)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4.29*fem, 0*fem),
                    width: 11.77*fem,
                    height: 11.77*fem,
                    child: Image.asset(
                      'assets/audio_room/star-vuF.png',
                      width: 11.77*fem,
                      height: 11.77*fem,
                    ),
                  ): SizedBox(),
                  Text(
                    // DcV (I1:6847;111:14756)
                    (index+1).toString(),
                    style: SafeGoogleFont (
                      'Avenir LT Std',
                      fontSize: 10*ffem,
                      height: 1.2575*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }

  Widget inActiveUser(double fem, double ffem, int index){
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.red
      //   )
      // ),
      // seatuJy (1:6847)
      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
      height: 77.45*fem,
      width: 55*fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // autogroupvvz3qyK (9Y5nDRebb25YxA5DFtVVZ3)
            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
            width: 55*fem,
            height: 55*fem,
            child: Stack(
              children: [
                Align(
                  child: SizedBox(
                    width: 55*fem,
                    height: 55*fem,
                    child: Container(
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(27.5*fem),
                        image: DecorationImage (
                          fit: BoxFit.cover,
                          image: AssetImage (
                            'assets/audio_room/group-3-E49.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // autogroupxfo7mkV (9Y5nGvYmWHvDsVmv2jxFo7)
            margin: EdgeInsets.fromLTRB( 2*fem, 8.45*fem, 0*fem, 0*fem),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // DcV (I1:6847;111:14756)
                  (index+1).toString(),
                  style: SafeGoogleFont (
                    'Avenir LT Std',
                    fontSize: 10*ffem,
                    height: 1.2575*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
