import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class Coin{


  static const productId=['mango_20','mango_16500', 'mango_2045','mango_2905','mango_1120','mango_6000','mango_1515','mango_4955'];
}
class PurchaseApi{
  static const _apiKey='goog_ktrhyGbCrWyfYXUlrStILIkzoIN';

  static Future init()async{
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey);

  }
  static Future<List<Offering>> fetchOfferByIds(List<String> ids)async{

    final offers=await fetchOffer(ids);
   print("offers${offers.length}");
    return offers.where((element) => ids.contains(element.identifier)).toList();
  }
  static Future<List<Offering>> fetchOffer(List<String> ids)async{
    try{
      final offering=await Purchases.getOfferings();
      final current=offering.all;
      List<Offering> list=[];
      for(String id in ids){
        if(current.containsKey(id)){
          list.add(current[id]!);
        }
      }
      return list;
    }on PlatformException catch(e){
      return [];
    }
  }
}