import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../utils/theme/colors_constant.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class FilterWordWidget extends StatefulWidget {
  const FilterWordWidget();

  @override
  State<FilterWordWidget> createState() => _FilterWordWidgetState();
}

class _FilterWordWidgetState extends State<FilterWordWidget> {
  final FocusNode _focusNode = FocusNode();
  RxBool openKeyBoard = false.obs;
  int inset=0;
  List filterWords= [];
  TextEditingController textEditingController= TextEditingController();
  LiveViewModel liveViewModel= Get.find();



  @override
  void initState() {
    filterWords = liveViewModel.liveStreamingModel.getFilteredList ?? [];
    // liveViewModel.liveStreamingModel.removeFilteredList = filterWords;
    super.initState();
  }

  @override
  void dispose() {
    // liveViewModel.liveStreamingModel.setFilteredList = filterWords;
    liveViewModel.liveStreamingModel.save();
    _focusNode.dispose();
    super.dispose();
  }





  void _requestFocus() {
    Future.delayed(Duration(seconds: 1), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (liveViewModel) {
          return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 130),
                          child: Text(
                            'Filter words',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.close)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Divider(
                    color: AppColors.grey300,
                    height: 3,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Edit the words you don't want to see in the comments, and the \nrelevant comments will be automatically filtered.One user can set \n(50) filtered words. It is not recommended to block common \nwords such as 'Hi, Hello, a, good...'",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      height: 150.h,
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 2.6,
                        ),
                        itemCount: filterWords.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 91.w,
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            decoration: BoxDecoration(
                              color: Color(0xff212121),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    filterWords[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                GestureDetector(
                                    onTap :() async {
                                      liveViewModel.liveStreamingModel.removeFilteredList = filterWords[index] ;
                                      ParseResponse response = await liveViewModel.liveStreamingModel.save();
                                      if(response.success){
                                        filterWords.removeAt(index);

                                      }

                                      setState(() {

                                      });
                                    },
                                    child: Image.asset(AppImagePath.deleteIcon)), // replace with AppImagePath.deleteIcon
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                 Obx(() {
                     return Visibility(
                           visible: openKeyBoard.value==true,
                           child: Container(
                             height: 72.h,
                             width: Get.width,
                             color: AppColors.navBarColor,
                             padding: EdgeInsets.symmetric(vertical: 16.h ,horizontal:  8.w),
                             child: Row(
                               children: [
                                 Expanded(
                                   child: Container(
                                     child: TextFormField(
                                       maxLines: 1,
                                       controller: textEditingController,
                                       focusNode: _focusNode,
                                       onSaved: (value) {
                                         openKeyBoard.value = false;
                                       },
                                       onFieldSubmitted: (value) {
                                         openKeyBoard.value = false;
                                       },
                                       onTap: () {
                                       },
                                       style: sfProDisplayRegular.copyWith(fontSize: 14.sp, color: Colors.white70),
                                       scrollPadding: EdgeInsets.zero,
                                       decoration: InputDecoration(
                                         contentPadding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0),
                                         hintText: "Aa",
                                         filled: true,
                                         hintStyle: sfProDisplayRegular.copyWith(fontSize: 14.sp, color: Colors.white70),
                                         fillColor: Color(0xff494848),
                                         border: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(
                                               28.0), // Set the border radius for rounded corners
                                         ),
                                         enabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(28.0),
                                           borderSide: BorderSide(
                                             color: Colors.transparent,
                                             width: 1.0, // Set the border width
                                           ),
                                         ),
                                         focusedBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(28.0),

                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 10.w,),
                                 PrimaryButton(
                                   height: 52.h, width: 38.w, bgColor: AppColors.yellowBtnColor, borderRadius: 38.r,
                                   textStyle: sfProDisplayRegular.copyWith(fontSize: 14.sp, color: Colors.black),
                                   onTap: (){
                                     filterWords.add(textEditingController.text);
                                     liveViewModel.liveStreamingModel.setFilteredList = textEditingController.text;
                                     liveViewModel.liveStreamingModel.save();
                                     textEditingController.text='';
                                     openKeyBoard.value = false;
                                     setState(() {

                                     });

                                   }, title: 'Send',),
                               ],
                             ),

                            ),
                         );
                   }
                 ),

                  Obx(() {
                      return Visibility(
                        visible: openKeyBoard.value==false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [
                              Container(
                                width: 163.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    color: Color(0xff252626),
                                    border: Border.all(
                                        color: AppColors.yellowBtnColor)),
                                child: Center(
                                  child: Text(
                                    "Clear",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.yellowBtnColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  openKeyBoard.value = true;
                                  _requestFocus();
                                },
                                child: Container(
                                  width: 163.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: AppColors.yellowBtnColor),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  ),



                  Obx(() {
                      return SizedBox(
                        height: openKeyBoard.value==false ? 20.h : 0.h,
                      );
                    }
                  ),
                ],
              )),
        );
      }
    );
  }
}
