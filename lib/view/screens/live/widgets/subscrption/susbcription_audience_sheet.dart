import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/parse/SubscriptionModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/dashboard/subscription/subscribers_list.dart';
import 'package:teego/view/screens/live/widgets/subscrption/single_live_subscriber_sheet.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/subscription_model.dart';
import 'package:teego/view_model/userViewModel.dart';


class Subscribe extends StatefulWidget {
  Subscribe({Key? key}) : super(key: key);

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  SubscriptionViewModel subscriptionViewModel = Get.find();
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
  bool? weekly;

  @override
  void initState() {
    subscriptionViewModel.getSubscribee();
    subscriptionViewModel.getExpiredSubscription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionViewModel>(
        init: subscriptionViewModel,
        builder: (subscriptionViewModel) {
          return GetBuilder<LiveViewModel>(
              builder: (liveViewModel) {
                return Container(
              color: Color(0xff0F0C15),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Exclusive Subscriber',
                              style: TextStyle(
                                  color: Color(0xffBD8DF4),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            color: Color(0xffFFFFFF),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 32.0),
                            child: Container(
                              // height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xff252626),
                                  border: Border.all(
                                      color: const Color(0xffBD8DF4), width: 3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: const BoxDecoration(
                                              color: Color(0xffBD8DF4),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              height: 55,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 72,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0, top: 8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  liveViewModel.liveStreamingModel.getAuthor!.getFullName!.toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                                const SizedBox(height: 15),
                                                GestureDetector(
                                                  onTap: ()=> openBottomSheet(SingleLiveSubscriberSheet(),context),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(10),
                                                        color:
                                                        const Color(0xff545454)),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(5.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Subscriber',
                                                            style: TextStyle(
                                                                color:
                                                                Color(0xffBD8DF4),
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          ),
                                                          // SizedBox(width: 6),
                                                          // Text(
                                                          //   'List',
                                                          //   style: TextStyle(
                                                          //       color: Color(
                                                          //           0xffBD8DF4)),
                                                          // ),
                                                          SizedBox(width: 3),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            size: 16.w,
                                                            color: Color(0xffBD8DF4),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(13, 6, 0, 10),
                                    child: Text(
                                      Get.find<LiveViewModel>().liveStreamingModel.getAuthor!.getSubscribeAnnouncement ?? 'Exclusive features for subscription, active to join now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          const Text(
                            "Subscriber's Privileges",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 5.h),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in the grid
                          crossAxisSpacing: 3.0, // Spacing between columns
                          mainAxisSpacing: 0.0, // Spacing between rows
                          childAspectRatio: 0.95, // Ratio of width to height for each grid item
                        ),
                        padding: EdgeInsets.all(0), // Padding around the grid
                        itemCount: subscribeData.length, // Total number of grid items
                        itemBuilder: (BuildContext context, int index) {
                          var l = subscribeData[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 4.0, right: 5.0, left: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    offset: Offset(2, 1),
                                  ),
                                ],
                                border: Border.all(color: Colors.white.withOpacity(.2)),
                                color: const Color(0xff323232),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              height: 107, // Adjust as needed
                              width: 107, // Adjust as needed
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Image.asset(
                                    l['image'].toString(),
                                    width: 70,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      l['title'].toString(),
                                      style: const TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                    onTap: ()=> setState(() {
                                      weekly=true;
                                    }),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: const Color(0xffBD8DF4),
                                                    width: 2)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Recurring\nSubcription',
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: weekly==true ? AppColors.yellowColor :  Colors.white.withOpacity(.6),
                                              ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  if(subscribeIndex == 0)
                                                    Row(
                                                    children: [
                                                      Image.asset(AppImagePath.coinsIcon, height: 20.w, width: 20.w,),
                                                      const SizedBox(width: 7),
                                                      Text(
                                                        '450',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 19.sp,
                                                            color: weekly==true ? AppColors.yellowColor: Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  if(subscribeIndex == 1)
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '\$ 4.49',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 19.sp,
                                                              color: weekly==true ? AppColors.yellowColor: Colors.white),

                                                        )
                                                      ],
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: -12,
                                            left: -10,
                                            child: Image.asset('assets/png/sales.png'))
                                      ],
                                    ),
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: GestureDetector(
                                    onTap: ()=> setState(() {
                                      weekly=false;
                                    }),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: const Color(0xffBD8DF4),
                                                width: 2)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "1  Month\n",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: weekly==false ? AppColors.yellowColor :  Colors.white.withOpacity(.6)),
                                              ),
                                              const SizedBox(height: 8),
                                              if(subscribeIndex == 0)
                                              Row(
                                                children: [
                                                  Image.asset(AppImagePath.coinsIcon, height: 20.w, width: 20.w,),
                                                  const SizedBox(width: 7),
                                                  Text(
                                                    '500',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 19.sp,
                                                        color: weekly==false ? AppColors.yellowColor: Colors.white),

                                                  )
                                                ],
                                              ),
                                              if(subscribeIndex == 1)
                                                Row(
                                                  children: [
                                                    Text(
                                                      '\$ 4.99',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 19.sp,
                                                          color: weekly==false ? AppColors.yellowColor: Colors.white),

                                                    )
                                                  ],
                                                )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff323232),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomSubcriberWidget(
                                      txt: 'Coins',
                                      image: AppImagePath.coinsIcon,
                                      color: subscribeIndex == 0 ? true : false,
                                      onTap: () {
                                        subscribeIndex = 0;
                                        setState(() {});
                                      },
                                    )),
                                Expanded(
                                    child: CustomSubcriberWidget(
                                      txt: 'App Purchase',
                                      image: 'assets/png/newvec.png',
                                      color: subscribeIndex == 1 ? true : false,
                                      onTap: () {
                                        subscribeIndex = 1;
                                        setState(() {});
                                      },
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: (){
                              if(subscriptionViewModel.isStreamerSubscribed(liveViewModel.liveStreamingModel.getAuthor!)==false) {
                                if (weekly != null) {
                                  subscriptionViewModel.subscribe(
                                      liveViewModel.liveStreamingModel.getAuthor!,
                                      weekly == true ? 450 : 500,
                                      weekly == true ? 'week' : 'month',context);
                                }
                                else
                                  QuickHelp.showAppNotificationAdvanced(
                                      title: "Please select a subscription package",
                                      context: context);
                              }
                              else {
                              QuickHelp.showAppNotificationAdvanced(
                              title: "The user is already subscribed",
                              context: context);
                              }
                            },
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xffBD8DF4),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(subscribeIndex == 0 && subscriptionViewModel.isStreamerSubscribed(liveViewModel.liveStreamingModel.getAuthor!)==false)
                                      Image.asset(
                                        'assets/png/small.png',
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.fill,
                                      ),
                                      if(subscribeIndex == 1 && subscriptionViewModel.isStreamerSubscribed(liveViewModel.liveStreamingModel.getAuthor!)==false)
                                        Text(
                                          '\$',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        const SizedBox(width: 10),
                                       Text(
                                        subscriptionViewModel.isStreamerSubscribed(liveViewModel.liveStreamingModel.getAuthor!)==false ?
                                        '${subscribeIndex == 0 ?  weekly==true ? "450" : "500" : weekly==false ? "4.49" : "4.99"} Subscriber'
                                            : 'Subscribed',
                                        style: TextStyle(fontSize:subscribeIndex == 0 && subscriptionViewModel.isStreamerSubscribed(liveViewModel.liveStreamingModel.getAuthor!)==false ? 17 : 19),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ]),
                  )),
        );
            }
          );
      }
    );
  }
}
class CustomSubcriberWidget extends StatefulWidget {
  String? image;
  String? txt;

  Function()? onTap;
  bool color;

  CustomSubcriberWidget(
      {this.image, this.txt, required this.color, this.onTap});

  @override
  State<CustomSubcriberWidget> createState() => _CustomSubcriberWidgetState();
}

class _CustomSubcriberWidgetState extends State<CustomSubcriberWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.onTap),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.color == true
                  ? const Color(0xff494848)
                  : Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Row(
              children: [
                Image.asset(widget.image!, width: 22.w, height: 22.w,),
                const SizedBox(width: 10),
                Text(
                  widget.txt.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
