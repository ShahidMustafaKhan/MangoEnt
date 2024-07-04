import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/storeController.dart';
import 'bagmodel.dart';
import 'sticker_dialoge.dart';

class Bag extends StatefulWidget {
  const Bag();

  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
  StoreController storeController = Get.find();

  List<BagModel> get cat => [
        BagModel(name: 'Gift', list: [
          BagsList(name: "Castle", image: castle),
          BagsList(name: "Star", image: star),
          BagsList(name: "Heart", image: heart),
          BagsList(name: "Ride", image: ride),
        ]),
        BagModel(name: 'Cards', list: []),
        BagModel(name: 'Avatar\nFrame', list: []),
        BagModel(name: 'Cards\nFrame', list: []),
        BagModel(name: 'Room\nDecor', list: []),
        BagModel(name: 'Profile\nDecor', list: []),
        BagModel(name: 'Chat\nBubble', list: []),
      ];
  List<BagsList> avatarList= [];
  List<BagsList> decorList= [];


  @override
  void initState() {

    storeController.myAvatarItems.forEach((item) {
      avatarList.add(BagsList(name: item["name"], image: item["image"]));
    });

    storeController.myRoomDecorItems.forEach((item) {
      decorList.add(BagsList(name: item["name"], image: item["image"]));
    });

    setState(() {
      
    });
    super.initState();
  }

  int selectedIndex = 0;

  List<BagsList> item=[];

  @override
  Widget build(BuildContext context) {
    if(selectedIndex==2)
      item=avatarList;
    else if(selectedIndex==0)
      item=cat[0].list;
    else if(selectedIndex==3)
      item=decorList;
    else
      item=[];

    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Your Bag',
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

      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80.0 * cat.length,
            width: 108.w,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Color(0xff252526) : AppColors.white,
              border: Border.all(
                color: Colors.white70,
                width: 0.2,
              ),
            ),
            child: ListView.separated(
              itemCount: cat.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: SizedBox(
                  height: 66.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      cat[index].name,
                      style: TextStyle(
                        color:
                            selectedIndex == index ? amberColor : Get.isDarkMode ? Colors.white : AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (_, index) => Divider(
                color:  Get.isDarkMode ?  Colors.white70 : Colors.black.withOpacity(0.4),
                thickness: 0.2,
              ),
            ),
          ),
          item.isEmpty
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65.h,
                        width: 65.w,
                        child: Image.asset(
                          bag,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 9.h,),
                      Text(
                        "Empty Bag",
                        style: TextStyle(
                          color:  Get.isDarkMode ?  Colors.white70 : Colors.black.withOpacity(0.4),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )
              : Column(
                  children: List.generate(
                    item.length,
                    (index) => GestureDetector(
                      onTap: () => Get.dialog(
                        StickerDialoge(
                          sticker: item[index].image,
                          name: item[index].name,
                          avatarFrameSelected: selectedIndex==2 ? true : false ,
                        ),
                      ),
                      child: Container(
                        height: 89.h,
                        width: 235.w,
                        margin: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode ? Color(0xff252526) : AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5,),
                            if(selectedIndex!=2)
                            Image.asset(
                              item[index].image,
                              height: 73.h,
                              width: 73.h,
                            ),
                            if(selectedIndex==2)
                              Container(
                                height: 73.h,
                                width: 73.h,
                                child: SvgPicture.asset(item[index].image,),
                              ),
                            SizedBox(width: selectedIndex==0 ? 32: 14.w,),
                            Container(
                              width: selectedIndex==0 ? null : 130.w,
                              decoration: BoxDecoration(
                              ),
                              child: Text(
                                item[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: selectedIndex==0 ? 22.sp : 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
  String addLineBreaksAfterTwoWords(String input) {
    List<String> words = input.split(' '); // Split the string into words
    StringBuffer result = StringBuffer(); // Use StringBuffer for efficient string concatenation

    for (int i = 0; i < words.length; i++) {
      result.write(words[i]); // Add the current word
      if ((i + 1) % 2 == 0 && i != words.length - 1) {
        result.write('\n'); // Add a line break after every two words, except after the last word
      } else if (i != words.length - 1) {
        result.write(' '); // Add a space between words
      }
    }

    return result.toString();
  }

}
