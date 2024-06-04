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
class AmericaRegionViewModel extends GetxController {
  final List<CountryModel> americaModelList = [
    CountryModel(name: 'USA', flag: AppImagePath.USA),
    CountryModel(name: 'Brazil', flag: AppImagePath.Brazil),
    CountryModel(name: 'Argentina', flag: AppImagePath.Argentina),
    CountryModel(name: 'Colombia', flag: AppImagePath.Colombia),
    CountryModel(name: 'Mexico', flag: AppImagePath.Mexico),
    CountryModel(name: 'Peru', flag: AppImagePath.Peru),
    CountryModel(name: 'Chile', flag: AppImagePath.Chile),
    CountryModel(name: 'Canada', flag: AppImagePath.Canada),
    CountryModel(name: 'Nigeria', flag: AppImagePath.Nigeria),
    CountryModel(name: 'Venezuela', flag: AppImagePath.Venezuela),
    CountryModel(name: 'Boliva', flag: AppImagePath.Bolivia),
    CountryModel(name: 'Ecuador', flag: AppImagePath.Ecuador),
    CountryModel(name: 'Panama', flag: AppImagePath.Panama),
    CountryModel(name: 'El Salvador', flag: AppImagePath.EL_Salvador),
    CountryModel(name: 'Costa Rico', flag: AppImagePath.Costa_Rico),
    CountryModel(name: 'Uruguay', flag: AppImagePath.Uruguay),
  ].obs;

  AmericaRegionViewModel();
}

class AsiaRegionViewModel extends GetxController {
  final List<CountryModel> asiaModelList = [
    CountryModel(name: 'Pakistan', flag: AppImagePath.Pakistan),
    CountryModel(name: 'India', flag: AppImagePath.India),
    CountryModel(name: 'Bangladesh', flag: AppImagePath.Bangladesh),
    CountryModel(name: 'China', flag: AppImagePath.China),
  ].obs;

  AsiaRegionViewModel();
}

class EuropeRegionViewModel extends GetxController {
  final List<CountryModel> europeModelList = [
    CountryModel(name: 'France', flag: AppImagePath.France),
    CountryModel(name: 'Germany', flag: AppImagePath.Germany),
    CountryModel(name: 'Italy', flag: AppImagePath.Italy),
    CountryModel(name: 'UK', flag: AppImagePath.UK),
  ].obs;

  EuropeRegionViewModel();
}

class MiddleEastRegionViewModel extends GetxController {
  final List<CountryModel> middleEastModelList = [
    CountryModel(name: 'Israel', flag: AppImagePath.Israel),
    CountryModel(name: 'Qatar', flag: AppImagePath.Qatar),
    CountryModel(name: 'Turkey', flag: AppImagePath.Turkey),
    CountryModel(name: 'UAE', flag: AppImagePath.UAE),
  ].obs;

  MiddleEastRegionViewModel();
}