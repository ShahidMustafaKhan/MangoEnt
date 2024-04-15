import 'package:flutter/material.dart';
import '../../internal/sdk/express/express_service.dart';

class ZegoAudioVideoView extends StatefulWidget {
  const ZegoAudioVideoView({required this.userInfo, this.fromMultiGuest=false, this.seat, this.userAvatar});

  final ZegoSDKUser userInfo;
  final bool fromMultiGuest;
  final int? seat;
  final String? userAvatar;

  @override
  State<ZegoAudioVideoView> createState() => _ZegoAudioVideoViewState();
}

class _ZegoAudioVideoViewState extends State<ZegoAudioVideoView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ValueListenableBuilder<bool>(
      valueListenable: widget.userInfo.isCamerOnNotifier,
      builder: (context, isCameraOn, _) {
        return createView(isCameraOn,fem,ffem);
      },
    );
  }

  Widget createView(bool isCameraOn,double fem , double ffem,) {
    if (isCameraOn) {
      return videoView();
    } else {
      if (widget.userInfo.streamID != null) {
        return widget.fromMultiGuest==false ? coHostNomalView(): widget.seat == 4 || widget.seat == 6 ? multiGuestCameraOffView(fem,ffem,widget.seat!): multiGuestCameraOffView9_12(fem,ffem,widget.seat!,);
      } else {
        return Container();
      }
    }
  }

  Widget multiGuestCameraOffView(double fem , double ffem, int seat, { double ? height, double? width }  ){

    return Container(
      padding: EdgeInsets.fromLTRB(1*fem, 0.9*fem, 1*fem, 7*fem),
      width:  width ?? 126*fem,
      height: height ?? 125*fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: seat==4 ? 0: 2,),
          Visibility(
            visible: widget.userAvatar != null,
            child: CircleAvatar(
              radius: seat==4 ? 35: 33,
              // height: 63.91*fem,
              backgroundImage: NetworkImage(
                // widget.userInfo.avatarUrlNotifier.value!,
                widget.userAvatar!,
              ),
            ),
          ),
          SizedBox(height: seat==4 ? 3: 0,),

        ],
      ),
    );
  }

  Widget multiGuestCameraOffView9_12(double fem , double ffem, int seat, { double ? height, double? width }  ){

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red
        )
      ),
      // padding: EdgeInsets.fromLTRB(1*fem, 0.9*fem, 1*fem, 7*fem),
      width:  width ?? 126*fem,
      height: height ?? 125*fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: seat==4 ? 0: 2,),
          Padding(
            padding:  EdgeInsets.only(bottom:  seat==2 ? 0: 15),
            child: Visibility(
              visible: widget.userAvatar != null ,
              child: CircleAvatar(
                radius: seat==2 ? 18: 14,
                // height: 63.91*fem,
                backgroundImage: NetworkImage(
                  // widget.userInfo.avatarUrlNotifier.value!,
                  widget.userAvatar!,
                ),
              ),
            ),
          ),

        ],
      ),
    );;
  }





  Widget backGroundView() {
    return Stack(
      children: [
        Image.asset(
          'assets/icons/bg.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              border: Border.all(width: 0),
            ),
            child: Center(
              child: SizedBox(
                  height: 20,
                  child: Text(
                    widget.userInfo.userName[0],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Widget coHostNomalView() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration (
            color: Color(0xffffffff),
            gradient: LinearGradient (
              begin: Alignment(-5.689, 1.344),
              end: Alignment(-1, 3.344),
              colors: <Color>[Color(0xff1659b0), Color(0xff380f5f)],
              stops: <double>[0, 1],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(90)),
              child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                ),
                // child: Image.network(widget.liveStreamingModel!.getImage!.url!),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget videoView() {
  //   return ValueListenableBuilder<Widget?>(
  //     valueListenable: widget.userInfo.videoViewNotifier,
  //     builder: (context, view, _) {
  //       if (view != null) {
  //         return view;
  //       } else {
  //         return Container();
  //       }
  //     },
  //   );
  // }
  Widget videoView() {
    return ValueListenableBuilder<Widget?>(
      valueListenable: widget.userInfo.videoViewNotifier,
      builder: (context, view, _) {
        if (view != null) {
          // return Container();
          return view;
        } else {
          return Container();
        }
      },
    );
  }
}
