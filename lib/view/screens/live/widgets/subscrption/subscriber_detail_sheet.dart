import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../view_model/live_controller.dart';
import '../../../../widgets/custom_slider.dart';


class SubscriberDetail extends StatefulWidget {
  SubscriberDetail({Key? key}) : super(key: key);

  @override
  State<SubscriberDetail> createState() => _SubscriberDetailState();
}

class _SubscriberDetailState extends State<SubscriberDetail> {
  LiveViewModel liveViewModel = Get.find();

  List<Map<String, String>> subscribeData = [
    {
      'title': 'Exclusive Badge',
      'image': 'assets/png/newgold.png',
    },
    {
      'title': 'Exclusive Stickers',
      'image': 'assets/png/celebration.png',
    },
    {
      'title': 'Send Wisphers',
      'image': 'assets/png/sub-gift.png',
    },
    {
      'title': 'Exclusive Gif',
      'image': 'assets/png/bonus.png',
    },
  ];

  int subscribeIndex=0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth * 0.27; // Adjust this value as needed
    double containerHeight = screenHeight * 0.17;
    return  customThemeContainer(
        context,
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Top Gifted',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFB461B),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                      AssetImage('assets/png/girl.png'))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFB461B),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                      AssetImage('assets/png/girl.png'))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFB461B),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                      AssetImage('assets/png/girl.png'))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Colors.white.withOpacity(.6),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Room Title',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        liveViewModel.liveStreamingModel.getTitle!.isEmpty ? 'Movie tash' : liveViewModel.liveStreamingModel.getTitle!,
                        style:
                        TextStyle(color: Colors.white.withOpacity(.6)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 8),
                child: Row(
                  children: [
                    const Text(
                      'Room Announcement',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        liveViewModel.liveStreamingModel.getRoomAnnouncement!.isEmpty ?  'Welcome to room' : liveViewModel.liveStreamingModel.getRoomAnnouncement!,
                        style:
                        TextStyle(color: Colors.white.withOpacity(.6)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       color: Color(0xff0F0C15), shape: BoxShape.circle),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Container(
                    //       decoration: const BoxDecoration(
                    //           image: DecorationImage(
                    //               image: AssetImage('assets/png/share.png'))),
                    //       height: 20,
                    //       width: 20,
                    //       padding: const EdgeInsets.all(10),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GetBuilder<UserViewModel>(
                          builder: (controller) {
                            return ElevatedButton.icon(
                              onPressed: () {
                                controller.followOrUnFollow(liveViewModel.liveStreamingModel.getAuthor!.objectId!);
                                setState(() {});
                                if(controller.followingUser(liveViewModel.liveStreamingModel.getAuthor!)==false)
                                  liveViewModel.incrementNewFansCount();
                              },
                              icon: Icon(
                                controller.followingUser(liveViewModel.liveStreamingModel.getAuthor!) ? Icons.check  : Icons.add,
                                color: Color(0xff252626), size: 19.w,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffBD8DF4)),
                              label: Text(
                                '${controller.followingUser(liveViewModel.liveStreamingModel.getAuthor!) ? "Following" : "Follow"}',
                                style: TextStyle(color: Color(0xff252626), fontSize: 13.sp),
                              ));
                        }
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  customThemeContainer(BuildContext context, Widget? child) {
    return Container(
      height: 400.h,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff1D1927),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10), topLeft: Radius.circular(10))),
              child: child,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    // height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff0F0C15),
                        border: Border.all(
                            color: const Color(0xffBD8DF4), width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: Color(0xffBD8DF4),
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                            NetworkImage(liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        liveViewModel.liveStreamingModel.getAuthor!.getFullName!.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'id:${liveViewModel.liveStreamingModel.getAuthor!.getUid}',
                                        style: TextStyle(
                                            color:
                                            Colors.white.withOpacity(.5)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        MySlider(),
                        const SizedBox(height: 15)
                      ],
                    ),
                  ),
                ),
                awardImage()
              ],
            ),
          )

        ],
      ),
    );
  }
  awardImage() {
    return Positioned(
      right: 30,
      top: -2,
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/png/Base.png')),
        ),
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/png/Inner.png')),
          ),
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/png/Vector.png')),
            ),
          ),
        ),
      ),
    );
  }
}
