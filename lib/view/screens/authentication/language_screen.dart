import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/authentication/broadcaster.dart';
import 'package:teego/view/widgets/appButton.dart';

import '../../../generated/assets.dart';
import '../../../parse/UserModel.dart';
import '../../../utils/routes/app_routes.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/base_scaffold.dart';

List<String> countryNames = [
  "English",
  // "Japanese",
  // "Hindi",
  // "Bangle",
  // "Indonesia",
  // "Russian",
  // "Chinese",
];

List<String> countryImages = [
  AppImagePath.englandFlag,
  // Assets.flagsJapanese,
  // Assets.flagsHindi,
  // Assets.flagsBangla,
  // Assets.flagsIndonesia,
  // Assets.flagsRussian,
  // Assets.flagsChina,
];

class LanguageScreen extends StatefulWidget {
  LanguageScreen();

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

TextEditingController searchController = TextEditingController();

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    bool settings = false;
    settings = Get.arguments ?? false;
    return BaseScaffold(
      body: Column(
        children: [
          SizedBox(height: 15.h,),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
               Text(
                'Languages',
                style: sfProDisplayMedium.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(15)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: AppTextFormField(
                controller: searchController,
                isPrefixIcon: true,
                prefixIcon: const Icon(Icons.search),
                validator: (val) {
                  return null;
                },
                hintText: "search"),
          ),
          SizedBox(height: ScreenUtil().setHeight(24)),
          SizedBox(
            height: ScreenUtil().setHeight(500),
            child: ListView.builder(
              itemCount: countryNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 20.w, right: 5.w),
                  horizontalTitleGap: 10,
                  leading: SvgPicture.asset(countryImages[index], height: 20.h, width: 32.w,),
                  title: Text(countryNames[index]),
                  trailing: Radio(
                      activeColor: AppColors.yellow,
                      value: countryNames[index],
                      groupValue: _selectedLanguage,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedLanguage =
                              value; // Update the selected language
                        });
                      }),
                );
              },
            ),
          ),
          Spacer(),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: AppButton(context, "Next",
                (){
              if(_selectedLanguage != null){
                      if(settings == false)
                        Get.toNamed(AppRoutes.trendingBroadcastersScreen);
                      else
                        Get.back();}
              else{
                QuickHelp.showAppNotificationAdvanced(title: 'Please select a language!', context: context);
              }
                }),
          ),
          SizedBox(height: ScreenUtil().setHeight(24)),

        ],
      ),
    );
  }
}
