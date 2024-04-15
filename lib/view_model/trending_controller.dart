import 'package:get/get.dart';
import 'package:mango_ent/model/trending_card_model.dart';
import 'package:mango_ent/utils/constants/app_constants.dart';

class TrendingViewModel extends GetxController {
  final List<TrendingModel> trendingModelList = [
    TrendingModel(
        name: 'Vis1245',
        flag: AppImagePath.swedishFlag,
        country: 'AG No.2',
        achievementCount: 16163,
        image: AppImagePath.cardImage1),
    TrendingModel(
        name: 'Ronald',
        flag: AppImagePath.pakistanFlag,
        country: 'PK No.2',
        achievementCount: 16163,
        image: AppImagePath.cardImage2),
    TrendingModel(
        name: '✌️✌️Gladys',
        flag: AppImagePath.pakistanFlag,
        country: 'PK No.2',
        achievementCount: 16163,
        image: AppImagePath.cardImage3),
    TrendingModel(
        name: 'Ronald',
        flag: AppImagePath.franceFlag,
        country: 'GR No.2',
        achievementCount: 16163,
        image: AppImagePath.cardImage4),
    TrendingModel(
        name: '️Gladys',
        flag: AppImagePath.canadaFlag,
        country: 'AG No.2',
        achievementCount: 16163,
        image: AppImagePath.cardImage1),
    TrendingModel(
        name: '🚨🚨Kyle',
        flag: AppImagePath.pakistanFlag,
        country: 'PK No.2',
        achievementCount: 16163,
        image: AppImagePath.cardImage2),
  ].obs;

  TrendingViewModel();
}
