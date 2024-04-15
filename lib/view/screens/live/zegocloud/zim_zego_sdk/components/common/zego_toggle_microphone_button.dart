import 'package:flutter/material.dart';

import '../../zego_sdk_manager.dart';

/// switch cameras
class ZegoToggleMicrophoneButton extends StatefulWidget {
  const ZegoToggleMicrophoneButton({
    Key? key,
  }) : super(key: key);

  @override
  State<ZegoToggleMicrophoneButton> createState() => _ZegoToggleMicrophoneButtonState();
}

class _ZegoToggleMicrophoneButtonState extends State<ZegoToggleMicrophoneButton> {
  // ValueNotifier<bool> isMicOnNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = const Size(96, 96);
    final sizeBoxSize =  const Size(56, 56);
    return ValueListenableBuilder<bool>(
        valueListenable: ZEGOSDKManager.instance.currentUser!.isMicOnNotifier,
        builder: (context, isMicOn, _) {
          return GestureDetector(
            onTap: () {
              ZEGOSDKManager.instance.expressService.turnMicrophoneOn(!isMicOn);
              isMicOn = !isMicOn;
              print("micison${!isMicOn}");

            },
            child:  Container(
              padding: EdgeInsets.all(!isMicOn? 8.7:0),
              width: containerSize.width,
              height: containerSize.height,
              decoration: BoxDecoration(
                color:  Colors.white,
                border: Border.all(
                    color: !isMicOn ? Colors.black : Colors.transparent
                ),

                shape: BoxShape.circle,
              ),
              child: SizedBox.fromSize(
                size: sizeBoxSize,
                child: !isMicOn
                    ? const Image(
                    image: AssetImage('assets/icons/toolbar_mic_off.png'))
                    : const Image(
                    image:
                    AssetImage('assets/userview/ic_mic.png')),
              ),
            ),
          );
        });
  }
}
