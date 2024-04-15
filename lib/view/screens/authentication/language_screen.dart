import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/appButton.dart';

import '../../../generated/assets.dart';
import '../../../utils/routes/app_routes.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/base_scaffold.dart';

List<String> countryNames = [
  "English",
  "Japanese",
  "Hindi",
  "Bangle",
  "Indonesia",
  "Russian",
  "Chinese",
];

List<String> countryImages = [
  Assets.flagsEnglish,
  Assets.flagsJapanese,
  Assets.flagsHindi,
  Assets.flagsBangla,
  Assets.flagsIndonesia,
  Assets.flagsRussian,
  Assets.flagsChina,
];

class LanguageScreen extends StatefulWidget {
  const LanguageScreen();

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

TextEditingController searchController = TextEditingController();

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
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
                  leading: Image.asset(
                    countryImages[index],
                    width: 20,
                    height: 20,
                  ),
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
          SizedBox(height: ScreenUtil().setHeight(24)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: AppButton(context, "Next",
                () => Get.toNamed(AppRoutes.trendingBroadcastersScreen)),
          )
        ],
      ),
    );
  }
}
