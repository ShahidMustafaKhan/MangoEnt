import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/trending/widgets/report_comment_sheet.dart';
import '../../../../utils/constants/app_constants.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({Key? key}) : super(key: key);

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final List<bool> _isReplyVisible = List.generate(4, (_) => false);

  int? _selectedCommentIndex;
  bool _isActionVisible = false;

  bool _isHeartHidden = false;

  void _toggleRepliesVisibility(int index) {
    setState(() {
      _isReplyVisible[index] = !_isReplyVisible[index];
    });
  }

  void _showActionContainer(int index) {
    setState(() {
      _selectedCommentIndex = index;
      _isActionVisible = true;
      _isHeartHidden = true;
    });
  }

  void _hideActionContainer() {
    setState(() {
      _isActionVisible = false;
      _isHeartHidden = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideActionContainer,
      child: SizedBox(
        height: 580.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 24.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Divider(
                height: 3.h,
                color: AppColors.grey300,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Stack(
                        // Wrap with Stack
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  _showActionContainer(index);
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      AppImagePath.profilePic,
                                      height: 32.h,
                                      width: 32.w,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'itz.isitaa',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(width: 16),
                                              Text(
                                                "02m",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Check my post plz 😊",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Reply",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.sp),
                                          ),
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () =>
                                                _toggleRepliesVisibility(index),
                                            child: Text(
                                              "-------- View 11 more replies",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          if (_isReplyVisible[index])
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      AppImagePath.profilePic,
                                                      height: 32.h,
                                                      width: 32.w,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'itz.isitaa',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                "02m",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Text(
                                                            "Check my post plz 😊",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    12.sp),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Text(
                                                            "Reply",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    if (!_isHeartHidden)
                                      Column(
                                        children: [
                                          SizedBox(height: 15.h),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Image.asset(
                                                AppImagePath.ic_heart),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text("8098"),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (_isActionVisible &&
                              _selectedCommentIndex == index)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 148.w,
                                height: 84.h,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: Color(0xff494848),
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          backgroundColor: AppColors.grey500,
                                          isScrollControlled: true,
                                          builder: (context) => Wrap(
                                            children: [
                                              // ReportCommentSheet(),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Report',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: Colors.red),
                                          ),
                                          Image.asset(
                                              AppImagePath.deleteCrossIcon)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    GestureDetector(
                                      onTap: _hideActionContainer,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Block account',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: Colors.red),
                                          ),
                                          Image.asset(
                                              AppImagePath.deleteCrossIcon)
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
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    width: 51.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Center(
                      child: Text(
                        "Nice !",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 58.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Center(
                      child: Text(
                        "Great !",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 74.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Center(
                      child: Text(
                        "Amazing !",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Image.asset(AppImagePath.emoji1),
                  SizedBox(width: 10.w),
                  Image.asset(AppImagePath.emoji2),
                  SizedBox(width: 10.w),
                  Image.asset(AppImagePath.emoji3),
                  SizedBox(width: 10.w),
                  Image.asset(AppImagePath.emoji4),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Image.asset(
                    AppImagePath.profilePic,
                    height: 36.h,
                    width: 36.w,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36.h,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffB7B6B9),
                          hintText: '  Add a comment',
                          hintStyle: TextStyle(color: Colors.black),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "@",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Post",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff51B1EE),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
