import 'package:get/get.dart';
import 'package:mango_ent/model/country_model.dart';
import 'package:mango_ent/view/utils/app_constants.dart';

class RegionViewModel extends GetxController {
  final List<CountryModel> countryModelList = [
    CountryModel(name: 'Sweden', flag: AppImagePath.swedishFlag),
    CountryModel(name: 'Bangladesh', flag: AppImagePath.bangladeshFlag),
    CountryModel(name: 'UK', flag: AppImagePath.englandFlag),
    CountryModel(name: 'Saudi Arabia', flag: AppImagePath.saudiFlag),
    CountryModel(name: 'Canada', flag: AppImagePath.canadaFlag),
    CountryModel(name: 'Pakistan', flag: AppImagePath.pakistanFlag),
    CountryModel(name: 'Ukraine', flag: AppImagePath.ukraineFlag),
    CountryModel(name: 'France', flag: AppImagePath.franceFlag),
  ].obs;

  RegionViewModel();
}
