import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import '../../../../helpers/quick_actions.dart';
import '../../../../helpers/quick_help.dart';
import '../../../../parse/LiveStreamingModel.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../view_model/live_controller.dart';


class WishListStreamerSheet extends StatefulWidget {
  WishListStreamerSheet();

  @override
  State<WishListStreamerSheet> createState() => _WishListStreamerSheetState();
}

class _WishListStreamerSheetState extends State<WishListStreamerSheet> {
  LiveViewModel liveViewModel = Get.find();
  
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    bool bottomSwitch = false;
    
    

    int length;

    if(liveViewModel.myWishList!=null){
      length=liveViewModel.myWishList!.length + 1;
    }
    else{
      length = 1;
    }

    int diamondWorth=0;
    int temp=0;

    for (int i = 0; i < liveViewModel.myWishList!.length; i++) {
      temp=temp+(int.parse(liveViewModel.myWishList![i][LiveStreamingModel.keyAmount])*3);
      if(i==(liveViewModel.myWishList!.length-1)){
        diamondWorth=temp;
      }
    }
    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (liveViewModel) {
          int length;

          if(liveViewModel.myWishList!=null){
            length=liveViewModel.myWishList!.length + 1;
          }
          else{
            length = 1;
          }

          int diamondWorth=0;
          int temp=0;

          for (int i = 0; i < liveViewModel.myWishList!.length; i++) {
            temp=temp+(int.parse(liveViewModel.myWishList![i][LiveStreamingModel.keyAmount])*3);
            if(i==(liveViewModel.myWishList!.length-1)){
              diamondWorth=temp;
            }
          }
          return GetBuilder<LiveViewModel>(
              init: liveViewModel,
              builder: (liveViewModel) {
                return Container(
                  width: 377.65*fem,
                  height: 613*fem,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0*fem,
                        top: 3*fem,
                        child: Align(
                          child: SizedBox(
                            width: 376*fem,
                            height: 610*fem,
                            child: Container(
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(14*fem),
                                color: Color(0xff1d1927),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 93*fem,
                        top: 584*fem,
                        child: Container(
                          width: 171*fem,
                          height: 14*fem,
                          child: Stack(
                            children: [
                              Positioned(
                                // aeroplaneVGb (1:19972)
                                left: 0*fem,
                                top: 0*fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 157*fem,
                                    height: 14*fem,
                                    child: Text(
                                      'You have added ${liveViewModel.myWishList!.length} gifts worth ',
                                      style: SafeGoogleFont (
                                        'DM Sans',
                                        fontSize: 11*ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2727272727*ffem/fem,
                                        color: Color(0xff9e9e9e),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 156*fem,
                                top: 1*fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 12*fem,
                                    height: 12*fem,
                                    child: Opacity(
                                      opacity: 0.9,
                                      child: Image.asset(
                                        AppImagePath.coinsIcon,
                                        width: 12*fem,
                                        height: 12*fem,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0*fem,
                        top: 0*fem,
                        child: Align(
                          child: SizedBox(
                            width: 377*fem,
                            height: 113*fem,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13*fem),
                              child: Image.asset(
                                'assets/png/overlay.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // giftsvectorTFM (1:19975)
                        left: 110*fem,
                        top: 249.4127960205*fem,
                        child: Container(
                          width: 62.26*fem,
                          height: 142.4*fem,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(21*fem),
                          ),
                        ),
                      ),
                      Positioned(
                        // baggageBh9 (1:19976)
                        left: 176*fem,
                        top: 23.6778869629*fem,
                        child: Container(
                          width: 26*fem,
                          height: 22.4*fem,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(21*fem),
                          ),
                          child: Container(
                            // frame395ut3 (1:19977)
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(21*fem),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // top104kw (1:19978)
                        left: 30*fem,
                        top: 75*fem,
                        child: Container(
                          width: 355.65*fem,
                          height: 34*fem,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(11*fem),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                // btnbgmvF (1:19979)
                                left: 0*fem,
                                top: 0*fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 335*fem,
                                    height: 34*fem,
                                    child: Container(
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(11*fem),
                                        color: Color(0x632a2634),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // jeanettekingVbM (1:19980)
                                left: 26*fem,
                                top: 12.0596218109*fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 300*fem,
                                    height: 14*fem,
                                    child: Text(
                                      ' Make a Wish And your Audience will help you Achieve it ',
                                      style: SafeGoogleFont (
                                        'DM Sans',
                                        fontSize: 11*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2727272727*ffem/fem,
                                        color: Color(0xffffbd2b),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                // asset154x1Byy (1:20000)
                                left: 6*fem,
                                top: 8*fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 12.55*fem,
                                    height: 19.71*fem,
                                    child: Image.asset(
                                      'assets/png/zee.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        // group52970K4b (1:19981)
                        left: 21*fem,
                        right: 15*fem,
                        top: 128*fem,
                        child: Container(
                          height: 400*fem,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    !liveViewModel.liveStreamingModel.getDisableWishList! ? 'Enable WishList' : 'Disable Wishlist',
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xffFFFFFF)),
                                  ),
                                  const Spacer(),
                                  CupertinoSwitch(
                                      value: !liveViewModel.liveStreamingModel.getDisableWishList! ,
                                      trackColor: const Color(0xffcecece),
                                      onChanged: (val) {
                                        liveViewModel.liveStreamingModel.setDisableWishList = !val;
                                        liveViewModel.liveStreamingModel.update();
                                        liveViewModel.liveStreamingModel.save();

                                      })
                                ],
                              ),
                              const Divider(
                                color: Color(0xff494848),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: GridView.builder(
                                padding: EdgeInsets.only(bottom: 60*fem),
                                itemCount: length,
                                shrinkWrap: true,// Provide the number of items in your grid
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.75,// Set the number of columns
                                  crossAxisSpacing: 12.42*fem, // Set spacing between columns
                                  mainAxisSpacing: 12*fem, // Set spacing between rows
                                ),
                                itemBuilder: (context, index) {
                                  return index!=(length-1) ? SizedBox(
                                    width: 106.58*fem,
                                    height: 141.46*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // bg2jh (1:19982)
                                          left: 0*fem,
                                          top: 0.879119873*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 106.58*fem,
                                              height: 140.58*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(5*fem),
                                                  color: const Color(0xff2a2634),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0x3f000000),
                                                      offset: Offset(0*fem, 4*fem),
                                                      blurRadius: 2*fem,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // Wes (1:19983)
                                          left: 47*fem,
                                          top: 124*fem,
                                          child: Align(
                                            child: SizedBox(
                                              height: 14*fem,
                                              child: Text(
                                                '${(int.parse(liveViewModel.myWishList![index][LiveStreamingModel.keyReceived])*3)}/${(int.parse(liveViewModel.myWishList![index][LiveStreamingModel.keyAmount])*3).toString()}',
                                                style: SafeGoogleFont (
                                                  'DM Sans',
                                                  fontSize: 10*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.4*ffem/fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 77*fem,
                                          child: Container(
                                            width:  106.58*fem,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 30.21*fem,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 2.21*fem),
                                                        child: Text(
                                                          liveViewModel.myWishList![index][LiveStreamingModel.keyName],
                                                          style: SafeGoogleFont (
                                                            'DM Sans',
                                                            fontSize: 10*ffem,
                                                            fontWeight: FontWeight.w400,
                                                            height: 1.4*ffem/fem,
                                                            color: Color(0xff9e9e9e),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 47*fem,
                                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0.63*fem),
                                                              width: 11*fem,
                                                              height: 11*fem,
                                                              child: Image.asset(
                                                                AppImagePath.coinsIcon,
                                                                width: 11*fem,
                                                                height: 11*fem,
                                                              ),
                                                            ),
                                                            Text(
                                                              '3',
                                                              style: SafeGoogleFont (
                                                                'DM Sans',
                                                                fontSize: 10.5*ffem,
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.4*ffem/fem,
                                                                color: Color(0xff9e9e9e),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 17*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 76.12*fem,
                                              height: 76.12*fem,
                                              child: Image.asset(
                                                liveViewModel.myWishList![index][LiveStreamingModel.keyPath],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 9 * fem,
                                          top: 112 * fem,
                                          child: SizedBox(
                                            width: 88 * fem,
                                            height: 5 * fem,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14 * fem),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(14 * fem),
                                                child: LinearProgressIndicator(
                                                  backgroundColor: AppColors.progressBgColor,
                                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.progressLinearGreenColor1), // Color of the progress indicator
                                                  value: double.parse(liveViewModel.myWishList![index][LiveStreamingModel.keyReceived])/double.parse(liveViewModel.myWishList![index][LiveStreamingModel.keyAmount]) , // Set the value of the progress bar (between 0.0 and 1.0)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          right: 5*fem,
                                          top: 5*fem,
                                          child: InkWell(
                                            onTap: (){
                                              liveViewModel.myWishList!.removeAt(index);
                                              liveViewModel.liveStreamingModel.setMyWishWholeList= liveViewModel.myWishList! ;
                                              liveViewModel.liveStreamingModel.save();
                                              setState((){});

                                            },
                                            child: Align(
                                              child: SizedBox(
                                                width: 9*fem,
                                                height: 9*fem,
                                                child: Image.asset(
                                                  'assets/png/ic_cross.png',
                                                  color: AppColors.white.withOpacity(0.5),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
                                  InkWell(
                                    onTap: (){
                                      myWishListOptionsBroadcaster(fem, ffem, context, liveViewModel.liveStreamingModel).then((value) => setState((){}));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(27*fem, 52.45*fem, 22.58*fem, 44.13*fem),
                                      width: 106.58*fem,
                                      height: 140.58*fem,
                                      decoration: BoxDecoration (
                                        color: Color(0xff2a2634),
                                        borderRadius: BorderRadius.circular(5*fem),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x3f000000),
                                            offset: Offset(0*fem, 4*fem),
                                            blurRadius: 2*fem,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 3*fem, 8*fem),
                                            child: Text(
                                              '+ ',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'DM Sans',
                                                fontSize: 41*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 0.5365853659*ffem/fem,
                                                color: Color(0xff777777),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Add wishes',
                                            style: SafeGoogleFont (
                                              'DM Sans',
                                              fontSize: 10*ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.4*ffem/fem,
                                              color: Color(0xff9e9e9e),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                            ),
                              ),
                         ] ),
                        ),),

                      Positioned(
                        left: 21*fem,
                        top: 529*fem,
                        child: InkWell(
                          onTap: (){
                            QuickHelp.goBack(context);
                            QuickHelp.showAppNotification(title: "Items Published Successfully!", context: context, isError: false);
                          },
                          child: Container(
                            width: 337*fem,
                            height: 49*fem,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(24*fem),
                              color: AppColors.yellowColor
                            ),
                            child: Center(
                              child: Text(
                                'Publish',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'DM Sans',
                                  fontSize: 22*ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1*ffem/fem,
                                  color: Color(0xff1E2121),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // jeanetteking8X9 (1:19998)
                        left: 123*fem,
                        top: 25*fem,
                        child: Align(
                          child: SizedBox(
                            width: 118*fem,
                            height: 14*fem,
                            child: Text(
                              'My Wish List',
                              style: SafeGoogleFont (
                                'DM Sans',
                                fontSize: 19*ffem,
                                fontWeight: FontWeight.w700,
                                height: 0.7368421053*ffem/fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // aeroplanedD1 (1:19999)
                        left: 265*fem,
                        top: 585*fem,
                        child: Align(
                          child: SizedBox(
                            height: 14*fem,
                            child: Text(
                              '$diamondWorth',
                              style: SafeGoogleFont (
                                'DM Sans',
                                fontSize: 10*ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.4*ffem/fem,
                                color: Color(0xff9e9e9e),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
      }
    );
  }

  Future myWishListOptionsBroadcaster(double fem, double ffem,
      BuildContext context, LiveStreamingModel liveStreamingModel) {
    int selected = -1;
    int amount = 1;
    String category = 'All Gifts';
    List images = [AppImagePath.lamborghiniImage, AppImagePath.bearCastleImage , AppImagePath.yachtIslandImage,
      AppImagePath.babyDragonImage, AppImagePath.heartsImage, AppImagePath.kissingImage , AppImagePath.motorCycleImage ];
    List name = ['lamborghini' , 'bear castle' , 'yacht island' , 'hearts', 'hearts' , 'kissing',];

    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20 * fem), // Set the radius for the top border
        ),),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState
                /*You can rename this!*/) {
              return SizedBox(
                width: 555 * fem,
                height: 535 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 376 * fem,
                      height: 73 * fem,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(
                              25 * fem, 2 * fem, 19.27 * fem, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff777777)),
                            color: const Color(0xff2a2634),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20 * fem),
                              topRight: Radius.circular(20 * fem),
                              bottomRight: Radius.circular(1 * fem),
                              bottomLeft: Radius.circular(1 * fem),
                            ),
                          ),
                          child: Row(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 20 * fem,
                                    height: 20 * fem,
                                    child: Image.asset(
                                      "assets/png/back.png",
                                      width: 20 * fem,
                                      height: 20 * fem,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10 * fem),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: SizedBox(
                                      width: 211 * fem,
                                      height: 25 * fem,
                                      child: Center(
                                        child: Text(
                                          'Select gifts and amount',
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 0.7777777778 * ffem / fem,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                InkWell(
                                  onTap: () {
                                    String name;
                                    if (selected == 0) {
                                      name = 'lamborghini';
                                    }
                                    else if (selected == 1) {
                                      name = 'bear castle';
                                    }
                                    else if (selected == 2) {
                                      name = 'yacht island';
                                    }
                                    else if (selected == 3) {
                                      name = 'baby dragon';
                                    }
                                    else if (selected == 4) {
                                      name = 'hearts';
                                    }
                                    else {
                                      name = 'kissing';
                                    }

                                    if (selected != -1) {
                                      Map<String, dynamic> item = {
                                        LiveStreamingModel.keyAmount: amount
                                            .toString(),
                                        LiveStreamingModel.keyReceived: "0",
                                        LiveStreamingModel.keyName: name,
                                        LiveStreamingModel.keyPath: images[selected],
                                      };
                                      liveViewModel.myWishList!.add(item);
                                      liveStreamingModel.setMyWishList = item;
                                      liveStreamingModel.save();
                                      QuickHelp.goBack(context);
                                    }
                                    else {
                                      QuickHelp.goBack(context);
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 66.73 * fem,
                                      height: 30 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff50b0ed)),
                                        borderRadius: BorderRadius.circular(
                                            24 * fem),
                                        gradient: const LinearGradient (
                                          begin: Alignment(0, -1),
                                          end: Alignment(0, 1),
                                          colors: <Color>[
                                            Color(0xff3d8ee1),
                                            Color(0xff68c5e2)
                                          ],
                                          stops: <double>[0, 1],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Done',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.4666666667 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            4 * fem, 0 * fem, 0 * fem, 33 - 13 * fem),
                        width: 555 * fem,
                        height: 555 - 44.81 * fem,
                        decoration: const BoxDecoration (
                          color: Color(0xff1d1927),
                          // borderRadius: BorderRadius.circular(14*fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // decoration: BoxDecoration(border: Border.all(color:Colors.red)),
                              // autogrouppzlbFPd (7eFAjq2h87LUBU3jhWPZLB)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0.35 * fem),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 115 - 20 - 20 - 10 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // baggagekrB (1:21156)
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 115 - 20 - 20 - 10 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            21 * fem),
                                        // border: Border.all(color:Colors.green)
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 15.5*fem),
                                        // frame3955Nf (1:21157)
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 51.19 - 20 * fem, 0 * fem,
                                            49.81 - 20 - 10 - 10 * fem),
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              21 * fem),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                category = "All Gifts";
                                                setModalState(() {});
                                              },
                                              child: Text(
                                                'All Gifts',
                                                style: SafeGoogleFont(
                                                  'DM Sans',
                                                  fontSize: category == "All Gifts"
                                                      ? 18 *ffem : 14 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.0769230769 * ffem /
                                                      fem,
                                                  color: category == "All Gifts"
                                                      ? Color(0xffffffff)
                                                      : Color(0xff777777),
                                                ),
                                              ),
                                            ),


                                            InkWell(
                                              onTap: () {
                                                category = "My Bag";
                                                setModalState(() {});
                                              },
                                              child: Container(
                                                // baggageJWK (1:21191)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem, 0 * fem, 0 * fem,
                                                    0 * fem),
                                                child: Text(
                                                  'My Bag  ',
                                                  style: SafeGoogleFont(
                                                    'DM Sans',
                                                    fontSize: category == "My Bag"
                                                        ? 18 *ffem : 14 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.0769230769 *
                                                        ffem / fem,
                                                    color: category == "My Bag"
                                                        ? Color(0xffffffff)
                                                        : Color(0xff777777),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                category = "new";
                                                setModalState(() {});
                                              },
                                              child: Text(
                                                // baggageDdH (1:21194)
                                                'New',
                                                style: SafeGoogleFont(
                                                  'DM Sans',
                                                  fontSize: category == "new"
                                                      ? 18 *ffem : 14 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.0769230769 * ffem /
                                                      fem,
                                                  color: category == "new"
                                                      ? Color(0xffffffff)
                                                      : Color(0xff777777),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300 * fem,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  // You can adjust the cross axis count as needed
                                  mainAxisSpacing: 3.0,
                                  crossAxisSpacing: 0.0,
                                  childAspectRatio: 0.87, // Adjust this ratio to fit your needs
                                ),
                                itemCount: 6,
                                // Set itemCount to the number of items you have
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      selected = index;
                                      setModalState(() {});
                                    },
                                    child: Container(
                                      width: 124.58 * fem,
                                      height: 149.51 * fem,
                                      decoration: BoxDecoration(
                                        border: selected == index
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 3)
                                            : null,
                                        color: const Color(0xff1d1927),
                                        borderRadius: BorderRadius.circular(
                                            5 * fem),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x3f000000),
                                            offset: Offset(0 * fem, 4 * fem),
                                            blurRadius: 2 * fem,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // button5rP (1:21205)
                                            right: 0 * fem,
                                            top: 0 * fem,
                                            child: Visibility(
                                              visible: selected != -1 &&
                                                  selected == index,
                                              child: Container(
                                                width: amount == 200
                                                    ? 38
                                                    : 32.73 * fem,
                                                height: 22 * fem,
                                                child: SizedBox(
                                                  width: amount == 200
                                                      ? 38
                                                      : 32.73 * fem,
                                                  height: 18 * fem,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff3991ec)),
                                                      borderRadius: BorderRadius
                                                          .only(
                                                        topLeft: Radius
                                                            .circular(1 * fem),
                                                        topRight: Radius
                                                            .circular(1 * fem),
                                                        bottomRight: Radius
                                                            .circular(1 * fem),
                                                        bottomLeft: Radius
                                                            .circular(9 * fem),
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin: Alignment(0, -1),
                                                        end: Alignment(0, 1),
                                                        colors: <Color>[
                                                          Color(0xff3d8ee1),
                                                          Color(0xff68c5e2)
                                                        ],
                                                        stops: <double>[0, 1],
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'x$amount',
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: SafeGoogleFont(
                                                          'DM Sans',
                                                          fontSize: amount ==
                                                              200
                                                              ? 12 * fem
                                                              : 15 * ffem,
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          height: 1.4666666667 *
                                                              ffem / fem,
                                                          color: Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10.52 * fem, selected == index
                                                ? 5.58
                                                : 14.58 * fem, 16.9 * fem, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Container(
                                                  // Qhm (1:21164)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem, 0 * fem, 0 * fem,
                                                      2.77 * fem),
                                                  width: 97.16 * fem,
                                                  height: 88.4 * fem,
                                                  child: Image.asset(
                                                    images[index],
                                                    // fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  // contentWVu (1:21160)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem, 0 * fem, 0 * fem,
                                                      0 * fem),
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                        // aeroplane3Vq (1:21162)
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0 * fem, 0 * fem,
                                                            0 * fem,
                                                            3.25 * fem),
                                                        child: Text(
                                                          name[index],
                                                          style: SafeGoogleFont(
                                                            'DM Sans',
                                                            fontSize: 10 * ffem,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            height: 1.4 * ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff9e9e9e),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0.18 * fem, 0 * fem,
                                                            0 * fem, 0 * fem),
                                                        width: double.infinity,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                  0 * fem,
                                                                  0.21 * fem,
                                                                  5.85 * fem,
                                                                  0 * fem),
                                                              width: 12 *
                                                                  fem,
                                                              height: 12 *
                                                                  fem,
                                                              child: Image
                                                                  .asset(
                                                                AppImagePath.coinsIcon,
                                                                width: 12 *
                                                                    fem,
                                                                height: 12 *
                                                                    fem,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 2*fem),
                                                              child: Text(
                                                                // hTu (1:21161)
                                                                '3',
                                                                style: SafeGoogleFont(
                                                                  'DM Sans',
                                                                  fontSize: 11 *
                                                                      ffem,
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  height: 1.4 *
                                                                      ffem / fem,
                                                                  color: Color(
                                                                      0xff9e9e9e),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ),
                            Container(
                              // dotsgf9 (1:21195)
                              margin: EdgeInsets.fromLTRB(
                                  171 * fem, 12 * fem, 0 * fem, 17.1 * fem),
                              width: 31.04 * fem,
                              height: 6.9 * fem,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Container(
                                    width: 6.9 * fem,
                                    height: 6.9 * fem,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 6.9 * fem,
                                    height: 6.9 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF605B69),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 6.9 * fem,
                                    height: 6.9 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF605B69),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // autogrouproujny5 (7eFDGAzWiNGsequUiWroUj)
                              margin: EdgeInsets.fromLTRB(
                                  10 * fem, 0 * fem, 0 * fem, 0 * fem),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // aeroplane7VZ (1:21123)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 9 * fem, 0 * fem),
                                    child: Text(
                                      'Amount',
                                      style: SafeGoogleFont(
                                        'DM Sans',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.1666666667 * ffem / fem,
                                        color: Color(0xff9e9e9e),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 1;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroup5qgkdio (7eFDXR47eLroEPtgf65qgK)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 12 * fem, 0 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 1
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '1',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8235294118 * ffem / fem,
                                            color: selected != -1 && amount == 1
                                                ? Color(0xffffffff)
                                                : Color(0xff9e9e9e),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 5;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroupsy1qxPh (7eFDeL2GCRvTUfMGHFSy1q)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 10 * fem, 0 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 5
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '5',
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 0.8235294118 * ffem / fem,
                                            color: selected != -1 && amount == 5
                                                ? Color(0xffffffff)
                                                : Color(0xff9e9e9e),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 10;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroupshyrS3y (7eFDjuhJDB9CEKgd8hshyR)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 10 * fem, 0 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 10
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '10',
                                          style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 17 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 0.8235294118 * ffem / fem,
                                              color: selected != -1 &&
                                                  amount == 10 ? Color(
                                                  0xffffffff) : Color(
                                                  0xff9e9e9e)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 50;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),
                                      // autogroupurrkfxK (7eFDpKjcFVkNgCnR4YUrrK)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 10 * fem, 1 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 50
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '50',
                                          style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 17 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 0.8235294118 * ffem / fem,
                                              color: selected != -1 &&
                                                  amount == 50 ? Color(
                                                  0xffffffff) : Color(
                                                  0xff9e9e9e)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (selected != -1) {
                                        amount = 200;
                                        setModalState(() {});
                                      }
                                      else {
                                        QuickHelp.showAppNotificationAdvanced(
                                            title: "Please select an item!",
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2),

                                      // autogroupeqsqvNT (7eFDtpc7aGyEiVq2uveQsq)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                      width: 46 * fem,
                                      height: 29 * fem,
                                      decoration: BoxDecoration(
                                        border: selected != -1 && amount == 200
                                            ? Border.all(
                                            color: Color(0xFF57AAFF), width: 2)
                                            : null,
                                        color: Color(0xff605b69),
                                        borderRadius: BorderRadius.circular(
                                            16 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '200',
                                          style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 17 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 0.8235294118 * ffem / fem,
                                              color: selected != -1 &&
                                                  amount == 200 ? Color(
                                                  0xffffffff) : Color(
                                                  0xff9e9e9e)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
