import 'package:get/get.dart';
import 'package:teego/model/country_model.dart';
import 'package:teego/utils/constants/app_constants.dart';

class RegionViewModel extends GetxController {
  final List<CountryModel> countryModelList = [
    CountryModel(name: 'Sweden', flag: AppImagePath.swedishFlag),
    CountryModel(name: 'USA', flag: "assets/svg/america_flags.svg"),
    CountryModel(name: 'UK', flag: AppImagePath.englandFlag),
    CountryModel(name: 'Saudi Arabia', flag: AppImagePath.saudiFlag),
    CountryModel(name: 'Canada', flag: AppImagePath.canadaFlag),
    CountryModel(name: 'Pakistan', flag: AppImagePath.pakistanFlag),
    CountryModel(name: 'Ukraine', flag: AppImagePath.ukraineFlag),
    CountryModel(name: 'France', flag: AppImagePath.franceFlag),
  ].obs;

  RegionViewModel();
}
