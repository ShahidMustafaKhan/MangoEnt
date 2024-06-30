import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../view_model/storeController.dart';
import '../wallet/receipt.dart';
import 'more_batch.dart';

class Store extends StatefulWidget {
  const Store();

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {

  @override
  Widget build(BuildContext context) {
    StoreController store = Get.find();
    store.initializeObject();
    UserViewModel user = Get.find();
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Store',
          style: SafeGoogleFont('sfProDisplayMedium', fontSize: 16.sp),

        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: GetBuilder<UserViewModel>(
          init: user,
          builder: (user) {
            return GetBuilder<StoreController>(
                init: store,
                builder: (store) {
                  return ListView(
                children: [
                  Container(
                    height: 400.h,
                    width: 375.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                      border:  Border.all(

                          color: Color(0xff36383D),

                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(storeCover),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            store.buttons.length,
                            (index) => GestureDetector(
                              onTap: (){
                                store.selectedTitle = store.title[index];
                                Get.to(() => MoreBatch());
                              },
                              child: Column(
                                children: [
                                  Image.asset(store.buttons[index].value),
                                  Text(
                                    store.buttons[index].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    width: 375.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                      border:  Border.all(

                          color: Color(0xff36383D),

                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Column(
                      children: List.generate(
                        2,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    store.title[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      store.selectedTitle=store.title[index];
                                      Get.to(() => MoreBatch());
                                    },
                                    child: Text(
                                      "More >",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                height: 346.h,
                                width: 343.w,
                                child: GridView(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8.h,
                                    crossAxisSpacing: 16.w,
                                    childAspectRatio: 0.95,
                                  ),
                                  children: List.generate(
                                    4,
                                    (gridIndex) => GestureDetector(
                                      onTap: (){
                                        if(store.checkItem(index ==0 ? store.avatarFrames[gridIndex]["name"]
                                            : store.roomDecor[gridIndex]["name"], index ==0 ? true : false )==false) {
                                          int amount = index == 0 ? store
                                              .avatarFrames[gridIndex]["price"]
                                              : store
                                              .roomDecor[gridIndex]["price"];
                                          if (user.coins >= amount)
                                            QuickActions.showAlertDialog(
                                                context,
                                                "Are you sure you want to purchase this item?",
                                                    () {
                                                  if (index == 0) {
                                                    Get.back();
                                                    store.setMyAvatarItem(
                                                        {
                                                          'name': store
                                                              .avatarFrames[gridIndex]["name"],
                                                          'image': store
                                                              .avatarFrames[gridIndex]["image"]
                                                        }).then(
                                                            (value) {
                                                          QuickActions
                                                              .showSuccessPaymentDialog(
                                                              context);
                                                        });
                                                  }
                                                  else {
                                                    Get.back();
                                                    store.setMyRoomDecorItem({
                                                      'name': store
                                                          .roomDecor[gridIndex]["name"],
                                                      'image': store
                                                          .roomDecor[gridIndex]["image"]
                                                    });
                                                  }
                                                });
                                          else
                                            QuickHelp
                                                .showAppNotificationAdvanced(
                                                title: "Insufficient coins!",
                                                context: context);
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 120.h,
                                            width: 163.w,
                                            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 14.h),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.r),
                                              color: const Color(0xff494848),
                                            ),
                                            child: index ==0 ? SvgPicture.asset(store.avatarFrames[gridIndex]["image"]) : Image.asset(store.roomDecor[gridIndex]["image"]),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            index ==0 ? store.avatarFrames[gridIndex]["name"]
                                                : store.roomDecor[gridIndex]["name"],
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          if(store.checkItem(index ==0 ? store.avatarFrames[gridIndex]["name"]
                                              : store.roomDecor[gridIndex]["name"], index ==0 ? true : false )==false)
                                          Row(
                                            children: [
                                              Image.asset(
                                                coin,
                                                height: 16.h,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                index ==0 ? store.avatarFrames[gridIndex]["price"].toString()
                                                : store.roomDecor[gridIndex]["price"].toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "1000",
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  decorationColor: Colors.white70,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if(store.checkItem(index ==0 ? store.avatarFrames[gridIndex]["name"]
                                              : store.roomDecor[gridIndex]["name"], index ==0 ? true : false)==true)
                                            Row(
                                              children: [
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Purchased",
                                                  style: TextStyle(
                                                    color: AppColors.yellowColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),

                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
          );
              }
            );
        }
      ),
    );
  }
}
