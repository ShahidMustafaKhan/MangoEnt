import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/nothing_widget.dart';
import 'package:teego/view_model/storeController.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../helpers/quick_actions.dart';
import '../../../../helpers/quick_help.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/colors_constant.dart';

class MoreBatch extends StatefulWidget {
  MoreBatch();

  @override
  State<MoreBatch> createState() => _MoreBatchState();
}

class _MoreBatchState extends State<MoreBatch> {
  late List item;
  StoreController store = Get.find();
  @override
  void initState() {
    item = store.selectedTitle == store.title[0] ? store.avatarFrames : store.selectedTitle == store.title[1] ? store.roomDecor : [] ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserViewModel user = Get.find();
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          store.selectedTitle,
          style: SafeGoogleFont('sfProDisplayMedium', fontSize: 16.sp,
              color: Get.isDarkMode ? AppColors.white : AppColors.black
          ),

        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
                color: Get.isDarkMode ? AppColors.white : AppColors.black
            )),
        actions: [IconButton(
            onPressed: () {
                Get.toNamed(AppRoutes.bag);
            },
            icon: Icon(
              Icons.shopping_bag_outlined,
                color: Get.isDarkMode ? AppColors.white : AppColors.black
            )),],
      ),
      body: GetBuilder<UserViewModel>(
          init: user,
          builder: (user) {
            return GetBuilder<StoreController>(
                init: store,
                builder: (store) {
                  if(item.isNotEmpty)
                  return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.95,
                  ),
                  children: List.generate(
                    item.length,
                    (index) => GestureDetector(
                      onTap: (){
                        int amount = item[index]["price"];
                        if(store.checkItem(item[index]["name"], store.selectedTitle == store.title[0]? true : false )==false)
                        {
                          if (user.coins >= amount)
                            QuickActions.showAlertDialog(context,
                                "Are you sure you want to purchase this item?",
                                    () {
                                  if (store.selectedTitle == store.title[0]) {
                                    Get.back();
                                    store.setMyAvatarItem({
                                      'name': item[index]["name"],
                                      'image': item[index]["image"]
                                    }).then(
                                            (value) {
                                          QuickActions.showSuccessPaymentDialog(
                                              context);
                                        });
                                  }
                                  else
                                  if (store.selectedTitle == store.title[1]) {
                                    Get.back();
                                    store.setMyRoomDecorItem({
                                      'name': item[index]["name"],
                                      'image': item[index]["image"]
                                    }).then(
                                            (value) {
                                          QuickActions.showSuccessPaymentDialog(
                                              context);
                                        });
                                  }
                                });
                          else
                            QuickHelp.showAppNotificationAdvanced(
                                title: "Insufficient coins!", context: context);
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
                              color: Get.isDarkMode ?  Color(0xff494848)  : AppColors.white

                            ),
                            child: store.selectedTitle == store.title[0] ? SvgPicture.asset(item[index]["image"]) : Image.asset(item[index]["image"]),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item[index]["name"],
                            style: TextStyle(
                              color:  Get.isDarkMode ? Colors.white70 : Colors.black.withOpacity(0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          if(store.checkItem(item[index]["name"], store.selectedTitle == store.title[0]? true : false )==false)
                          Row(
                            children: [
                              Image.asset(
                                coin,
                                height: 16.h,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                item[index]["price"].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "1000",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Get.isDarkMode ? Colors.white70 : Colors.black.withOpacity(0.7),
                                  color:  Get.isDarkMode ? Colors.white70 : Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          if(store.checkItem(item[index]["name"], store.selectedTitle == store.title[0]? true : false )==true)
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
          );
                  return NothingIsHere();
              }
            );
        }
      ),
    );
  }
}
