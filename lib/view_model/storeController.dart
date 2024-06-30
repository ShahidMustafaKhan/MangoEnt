
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../parse/StoreModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/app_constants.dart';
import '../view/screens/dashboard/wallet/receipt.dart';



class StoreController extends GetxController {

  StoreModel storeModel= StoreModel();
  List myAvatarItems=[];
  List myRoomDecorItems=[];

  List<ReceiptModel> buttons = [
    ReceiptModel(title: "Avatar", value: avatar),
    ReceiptModel(title: "Room", value: room),
    ReceiptModel(title: "Chat", value: chat),
    ReceiptModel(title: "Gift", value: gift),
  ];

  List title = ["Avatar Frames","Room Decor","Chat bubbles", "Gift"];
  String selectedTitle= "Avatar Frames";


  List avatarFrames = [
    {"image":AppImagePath.avatarFrameWhite,"price":600,"name":"Winged Fantasy Frame"},
    {"image":AppImagePath.avatarFramePurple1,"price":900,"name":"Chain Elegance Frame"},
    {"image":AppImagePath.avatarFramePurple2,"price":720,"name":"Floral Fantasy Frame"},
    {"image":AppImagePath.avatarFrameOrange,"price":890,"name":"Golden Circle Frame"},
  ];

  List roomDecor = [
    {"image":AppImagePath.roomDecor1,"price":900,"name":"Gothic Room Decor"},
    {"image":AppImagePath.roomDecor2,"price":720,"name":"Floral Room Decor"},
    {"image":AppImagePath.roomDecor3,"price":600,"name":"Thorny Room Decor"},
    {"image":AppImagePath.roomDecor4,"price":890,"name":"Ornate Wooden Room Decor"},
    {"image":AppImagePath.roomDecor5,"price":890,"name":"Sleek Wooden Decor"},
    {"image":AppImagePath.roomDecor6,"price":890,"name":"Geometric Wooden Decor"},
    {"image":AppImagePath.roomDecor7,"price":890,"name":"Curved Wooden Decor"},
    {"image":AppImagePath.roomDecor1,"price":900,"name":"Gothic Room Decor"},

  ];

  bool checkItem(String storeFrameName, bool avatarFrame) {

    // Iterate over the avatarFrames list
    if(avatarFrame==true)
    for (int index = 0; index < myAvatarItems.length; index++) {
      // Check if the names match
      if (storeFrameName == myAvatarItems[index]["name"]) {
        return true;
      } else {
        print('No match for: ${myAvatarItems[index]["name"]}');
      }
    }
    else
      for (int index = 0; index < myRoomDecorItems.length; index++) {
        // Check if the names match
        if (storeFrameName == myRoomDecorItems[index]["name"]) {
          return true;
        } else {
          print('No match for: ${myRoomDecorItems[index]["name"]}');
        }
      }
    return false;
  }


  Future initializeObject() async {
    UserModel userModel = Get.find<UserViewModel>().currentUser;
    QueryBuilder<StoreModel> queryBuilder = QueryBuilder<StoreModel>(StoreModel());
    queryBuilder.whereEqualTo(StoreModel.keyAuthorUid, userModel.getUid);
    ParseResponse apiResponse = await queryBuilder.query();
    if(apiResponse.success){
      if(apiResponse.results!=null && apiResponse.results!.isNotEmpty){
        StoreModel storesModel = apiResponse.results!.first! as StoreModel;
        if(storesModel.getAuthorUid!=null){
          storeModel=storesModel;
          getMyItemList();
        }
        else{
          storeModel.setAuthor=userModel;
          storeModel.setAuthorUid=userModel.getUid!;
          storeModel.save();
        }
      }
      else{
        storeModel.setAuthor=userModel;
        storeModel.setAuthorUid=userModel.getUid!;
        storeModel.save();
      }
    }
  }


  Future setMyAvatarItem(Map<String, dynamic> item) async{
      storeModel.incrementMyAvatarItems= item;
      ParseResponse response = await storeModel.save();
      if(response.success && response.results != null){
        storeModel = response.results!.first;
        getMyItemList();
        update();
      }
  }

  Future setMyRoomDecorItem(Map<String, dynamic> item) async{
    storeModel.incrementMyRoomDecorItems = item;
    ParseResponse response = await storeModel.save();
    if(response.success && response.results != null){
      storeModel = response.results!.first;
      getMyItemList();
      update();
    }
  }

  Future<void> getMyItemList()  async {
      myAvatarItems = storeModel.getMyAvatarItems!;
      myRoomDecorItems = storeModel.getMyRoomDecorItems!;
      update();
  }


  Future selectItem(UserModel userModel,String id,{Function? then}) async {
    userModel.setAvatarSelected=true;
    userModel.setAvatarId=id;
    userModel.save().then((value){
      if(then!=null){
        then();
      }
    });
  }


  Future unSelectItem(UserModel userModel,{Function? then}) async {
    userModel.setAvatarSelected=false;
    userModel.setAvatarId='';
    userModel.save().then((value){
      if(then!=null){
        then();
      }
    });
  }


  @override
  void onInit() {
    initializeObject();
    super.onInit();
  }
}

