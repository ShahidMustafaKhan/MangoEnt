import 'package:flutter/material.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/bottom_bar.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/top_bar.dart';

import '../single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_card.dart';


class MultiGuestLiveView extends StatefulWidget {
  const MultiGuestLiveView({Key? key}) : super(key: key);

  @override
  State<MultiGuestLiveView> createState() => _MultiGuestLiveViewState();
}

class _MultiGuestLiveViewState extends State<MultiGuestLiveView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImagePath.singleLiveBgImage)),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 50),
                  TopBar(),
                  const SizedBox(height: 10),
                  const Spacer(),
                    // ...List.generate(
                    //   4,
                    //       (index) {
                    //     return const Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 20),
                    //       child: Align(alignment: Alignment.topLeft, child: ChatCard()),
                    //     );
                    //   },
                    // ),
                    Column(
                      children: [
                        SizedBox(height: 16),
                        BottomBar(),
                        SizedBox(height: 20),
                      ],
                    ),
                ],
              ),
              // Center(
              //   child: SVGAImage(streamerViewModel.animationController!),
              // ),
            ],
          ),
        )
    );
  }
}
