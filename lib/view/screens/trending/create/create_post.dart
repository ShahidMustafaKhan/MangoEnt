import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/trending/create/select-privacy.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/communityController.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../../../../helpers/quick_help.dart';
import '../../../../parse/others/video_editor_model.dart';
import '../../../../utils/Utils.dart';
import '../../../../view_model/userViewModel.dart';
import '../../reels/feed/videoutils/video.dart';
import '../../reels/video_editor_screen.dart';
import 'add-location.dart';
import 'create_reel.dart';

class PostScreen extends StatefulWidget {
  final int? currentIndex;
  PostScreen(this.currentIndex);
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Utils util = Utils();
  final TextEditingController _textController = TextEditingController();
  String? _selectedMedia;
  String _selectedPrivacy = 'Public';
  String _location = 'Tags';
  final ImagePicker _picker = ImagePicker();
  File? _pickedFile;
  ParseFile ? parseFileThumbnail;
  String ? thumbnailImage;
  final List<File> imageList = [];
  RxBool isBold = false.obs;
  RxBool isUnderline = false.obs;
  RxBool isItalic = false.obs;

  bool get isVideoChosen => _selectedMedia == 'video';


  void openCamera(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );

    if (result != null) {
      setState(() {
        _pickedFile = result["videoFile"];
        parseFileThumbnail = result["parseFileThumbnail"];
        thumbnailImage = result["uploadPhoto"];
        _selectedMedia = 'video';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25.sp,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text('Post',
                        style: sfProDisplayBold.copyWith(
                          color: Colors.white,
                          fontSize: 20.h,
                        )),
                  ),
                ),
                SizedBox(width: 48.w)
              ],
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.grey900,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                            return TextField(
                              controller: _textController,
                              style: sfProDisplaySemiBold.copyWith(
                                  color: AppColors.black, fontSize: 18.h,
                                fontStyle: isItalic.value ? FontStyle.italic : FontStyle.normal,
                                fontWeight: isBold.value==true ? FontWeight.bold : FontWeight.w400,
                                decoration: isUnderline.value ? TextDecoration.underline : TextDecoration.none,),
                              maxLines: 2,
                              decoration: InputDecoration(
                                filled: true,
                                focusedBorder: InputBorder.none,
                                focusColor: Colors.transparent,
                                fillColor: AppColors.white,
                                hintText: "What's on your mind ......",
                                hintStyle: sfProDisplayMedium.copyWith(
                                    fontSize: 13.sp, color: AppColors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            );
                          }
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Text('B',
                                  style: sfProDisplayBold.copyWith(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                  )),
                              onPressed : ()=>isBold.value= !isBold.value,
                            ),
                            IconButton(
                              icon: Text('I',
                                  style: sfProDisplayBold.copyWith(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontStyle: FontStyle.italic)),
                              onPressed : ()=>isItalic.value= !isItalic.value,
                            ),
                            IconButton(
                              icon: Text('U',
                                  style: sfProDisplayBold.copyWith(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      decoration: TextDecoration.underline)),
                              onPressed : ()=>isUnderline.value= !isUnderline.value,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextButton.icon(
                              onPressed: () {
                                openCamera(context);
                              },
                              icon: Icon(
                                Icons.camera_enhance,
                                color: Colors.green,
                                size: 14.sp,
                              ),
                              label: Text(
                                'Photo/Video',
                                style: sfProDisplayBold.copyWith(
                                  color: AppColors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextButton.icon(
                              onPressed: () {
                                Get.to(AddLocation())!.then((value){
                                  _location = value['address'];
                                  setState(() {

                                  });
                                });
                              },
                              icon: Icon(
                                Icons.location_on_sharp,
                                color: Colors.red,
                                size: 14.sp,
                              ),
                              label: Text(
                                _location,
                                style: sfProDisplayBold.copyWith(
                                  color: AppColors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: TextButton.icon(
                              onPressed: () {
                                Get.to(SelectPrivacy())!.then((value){
                                  _selectedPrivacy=value["privacy"];
                                  setState(() {

                                  });
                                });
                              },
                              icon: Icon(
                                Icons.remove_red_eye_rounded,
                                color: Colors.blueAccent,
                                size: 14.sp,
                              ),
                              label: Text(
                                _selectedPrivacy,
                                style: sfProDisplayBold.copyWith(
                                  color: AppColors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Media',
                  style: sfProDisplayBold.copyWith(
                    color: AppColors.white,
                    fontSize: 22.sp,
                  )),
            ),
            SizedBox(height: 10),
            thumbnailImage != null ? _buildMediaPreview(thumbnailImage!) : Container(),
            Spacer(),
            ElevatedButton(
              onPressed: savePost,
              style: ElevatedButton.styleFrom(
                primary: AppColors.yellowBtnColor,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50), // <-- matches the height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: Text(
                'Submit',
                style: sfProDisplaySemiBold.copyWith(
                  color: AppColors.black,
                  fontSize: 20.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future savePost() async {
    if (_pickedFile != null) {
      QuickHelp.showLoadingDialogWithText(context, description: 'Uploading, please wait...',);

      final user = Get
          .find<UserViewModel>()
          .currentUser;
      PostsModel postsModel = PostsModel();
      postsModel.setAuthor = user!;
      postsModel.setAuthorId = user.objectId!;
      if(parseFileThumbnail!=null)
      postsModel.setVideoThumbnail = parseFileThumbnail!;
      if (_textController.text.isNotEmpty)
        postsModel.setCaption = _textController.text;
      if (_pickedFile != null) {
        ParseFile parseFile = ParseFile(File(_pickedFile!.path));
        // await parseFile.save();
        if (_selectedMedia == "image") {
          postsModel.setImage = parseFile;
        } else {
          postsModel.setVideo = parseFile;
        }
      }
      postsModel.setPostType = "video";
      postsModel.setExclusive = false;

      // Display loading dialog

      // Save post
      ParseResponse response = await postsModel.save();
      QuickHelp.hideLoadingDialog(context);

      if (response.success) {
        VideoInfo videoInfo = VideoInfo(
          postModel: postsModel,
          currentUser: user,
          url: postsModel.getVideo!.url,
        );
        Get.find<CommunityController>().videosList.add(videoInfo);
        Get.find<CommunityController>().update();
        Get.find<CommunityController>().loadFeedsVideo(Get.find<UserViewModel>().currentUser, false, updateBuild: false);
        QuickHelp.showAppNotificationAdvanced(
          context: context,
          title: "feed.post_posted_title".tr(),
          message: "feed.post_posted".tr(),
          isError: false,
        );
        Navigator.of(context).pop();
      } else {
        QuickHelp.showAppNotificationAdvanced(
            context: context,
            title: "feed.post_not_posted".tr(),
            message: response.error!.message,
            isError: true,
            user: user);
      }
    }
    else
    QuickHelp.showAppNotificationAdvanced(
    context: context,
    title: "Please add a video to upload.",
    isError: true,);
  }

  Widget _buildButton(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: 12.sp,
          ),
          label: Text(
            label,
            style: sfProDisplayBold.copyWith(
              color: AppColors.black,
              fontSize: 10.sp,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.0.w),
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview(String imagePath) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: imagePath.endsWith('.mp4')
          ? Center(
        child: Icon(
          Icons.videocam,
          color: AppColors.grey,
          size: 50.w,
        ),
      )
          : ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
