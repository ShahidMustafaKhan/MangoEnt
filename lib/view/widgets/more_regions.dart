import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../model/country_model.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/typography.dart';
import '../../view_model/region_controller.dart';
import '../../view_model/trending_controller.dart';

class MoreRegionWidget extends StatefulWidget {
  MoreRegionWidget({Key? key}) : super(key: key);

  @override
  _MoreRegionWidgetState createState() => _MoreRegionWidgetState();
}

class _MoreRegionWidgetState extends State<MoreRegionWidget> {
  late final AmericaRegionViewModel americaRegionViewModel;
  late final AsiaRegionViewModel asiaRegionViewModel;
  late final EuropeRegionViewModel europeRegionViewModel;
  late final MiddleEastRegionViewModel middleEastRegionViewModel;
  TrendingViewModel trendingViewModel = Get.find();
  String selectedRegion = "America";

  @override
  void initState() {
    super.initState();
    americaRegionViewModel = Get.put(AmericaRegionViewModel());
    asiaRegionViewModel = Get.put(AsiaRegionViewModel());
    europeRegionViewModel = Get.put(EuropeRegionViewModel());
    middleEastRegionViewModel = Get.put(MiddleEastRegionViewModel());
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? Colors.black : Colors.white;
    final textColorFaded = isLightTheme ? Colors.black54 : Colors.grey;
    return BaseScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        // color: AppColors.textWhite,
                        color: textColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Countries & Regions",
                      style: sfProDisplayRegular.copyWith(
                        // color: AppColors.textWhite,
                          color: textColor,
                          fontSize: 17.sp),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      AppImagePath.searchIcon,
                      color: textColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRegionOption("America", textColor, textColorFaded),
                    Spacer(),
                    buildRegionOption("Asia", textColor, textColorFaded),
                    Spacer(),
                    buildRegionOption("Middle East", textColor, textColorFaded),
                    Spacer(),
                    buildRegionOption("Europe", textColor, textColorFaded),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  // color: AppColors.textWhite,
                  color: textColor,

                  height: 1.5,
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
          if (selectedRegion == "America")
            GetBuilder<AmericaRegionViewModel>(
              builder: (americaController) {
                return buildRegionGrid(
                    americaController.americaModelList, context);
              },
            ),
          if (selectedRegion == "Asia")
            GetBuilder<AsiaRegionViewModel>(
              builder: (asiaController) {
                return buildRegionGrid(asiaController.asiaModelList, context);
              },
            ),
          if (selectedRegion == "Middle East")
            GetBuilder<MiddleEastRegionViewModel>(
              builder: (middleEastController) {
                return buildRegionGrid(
                    middleEastController.middleEastModelList, context);
              },
            ),
          if (selectedRegion == "Europe")
            GetBuilder<EuropeRegionViewModel>(
              builder: (europeController) {
                return buildRegionGrid(
                    europeController.europeModelList, context);
              },
            ),
        ],
      ),
    );
  }

  Widget buildRegionOption(
      String regionName, Color textColor, Color textColorFaded) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRegion = regionName;
        });
      },
      child: Column(
        children: [
          Text(
            regionName,
            style: sfProDisplayRegular.copyWith(
                color: selectedRegion == regionName
                // ? Colors.white
                // : AppColors.textWhite.withOpacity(0.6),
                    ? textColor
                    : textColorFaded,
                fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          if (selectedRegion == regionName)
            Container(
              width: 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                // color: Colors.white,
                color: textColor,

                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildRegionGrid(List<CountryModel> modelList, BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 17.h),
      children: List.generate(modelList.length, (index) {
        return GestureDetector(
          onTap: () {
            trendingViewModel.chosenCountryFlag.value = modelList[index].flag;
            trendingViewModel.chosenCountry.value = modelList[index].name;
            trendingViewModel.updateListForChosenCountry(modelList[index].name);
            Get.back();
          },
          child: buildCountries(
            cFlag: modelList[index].flag,
            cName: modelList[index].name,
            context: context,
          ),
        );
      }),
    );
  }

  Widget buildCountries(
      {required String cFlag,
        required String cName,
        required BuildContext context}) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          cFlag,
          height: 32.h,
          width: 44.w,
        ),
        Text(cName,
            style: sfProDisplayRegular.copyWith(
              // color: Colors.white,
                color: isLightTheme ? Colors.black : Colors.white,
                fontSize: 12.sp))
      ],
    );
  }
}
