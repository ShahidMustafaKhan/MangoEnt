import 'dart:math';

import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:english_words/english_words.dart';

import '../helpers/quick_help.dart';
import '../parse/PaymentsModel.dart';
import '../view/screens/dashboard/wallet/receipt.dart';
import '../view/screens/dashboard/wallet/wallet.dart';

class TransactionController extends GetxController {

  int purchaseItemIndex=-1.obs;
  int withdrawItemIndex=-1.obs;
  double singleCoinPrice = 0.0106;


  List<CoinsModel> get coins => [
    CoinsModel(coins: 20, amount: 0.29),
    CoinsModel(coins: 1120, amount: 16.99),
    CoinsModel(coins: 1515, amount: 22.99),
    CoinsModel(coins: 2045, amount: 30.99),
    CoinsModel(coins: 2905, amount: 43.99),
    CoinsModel(coins: 4955, amount: 74.99),
    CoinsModel(coins: 6000, amount: 89.99),
    CoinsModel(coins: 16500, amount: 249.99)

  ];


  bool checkBalance(double amount){
    return Get.find<UserViewModel>().myBalance >= amount;
  }

  makeWithdrawRequest(String method, double balance){
    String referenceNumber = generateReferenceNumber();
    withdrawTransaction(
        method,
        referenceNumber,
        balance);
    Get.to(Receipt(amount: balance,
      referenceNumber: referenceNumber,
      withdraw : true,
    ));
  }

  withdrawTransaction(String method, String referenceNumber, double balance  ) async {
    UserModel currentUser = Get.find<UserViewModel>().currentUser;
    PaymentsModel paymentModel=PaymentsModel();
    // if(type==PaymentsModel.keyPaymentTypePayPal){
    //   paymentModel.setPayPalEmail=paymentId;
    // }
    // else {
    //   paymentModel.setQiwiWalletNo=paymentId;
    // }
    paymentModel.setAuthor=currentUser;
    paymentModel.setFullName=currentUser.getFullName!;
    paymentModel.setAuthorId=currentUser.getUid!.toString();
    paymentModel.setMethod=method;
    paymentModel.setAmount=balance;
    paymentModel.setStatus=PaymentsModel.paymentStatusPending;
    paymentModel.setTransactionType=PaymentsModel.keyTransactionTypeWithdraw;
    paymentModel.setReferenceNumber = referenceNumber;

    ParseResponse response= await paymentModel.save();

    if(response.success){
      Get.find<UserViewModel>().deductBalance(getCoinsFromAmount(balance));
    }
    else{
    }

  }

  successfulPayment(int coins, double amount, {Function()? onReturn}){
      String referenceNumber = generateReferenceNumber();
     purchaseTransaction(
          referenceNumber,
         coins,
         amount);
      Get.to(Receipt(amount: amount,
        referenceNumber: referenceNumber,
        withdraw : false,
      ))!.then((value){
        if(onReturn!=null)
          onReturn();
      });
  }

  paymentFailed(){
    QuickHelp.showAppNotificationAdvanced(title: 'Payment Failed', context: Get.context!);
  }


  purchaseTransaction(String referenceNumber, int coins, double balance ) async {
    Get.find<UserViewModel>().addBalance(coins).then((value){
      UserModel currentUser = Get.find<UserViewModel>().currentUser;
      PaymentsModel paymentModel=PaymentsModel();
      paymentModel.setAuthor=currentUser;
      paymentModel.setFullName=currentUser.getFullName!;
      paymentModel.setAuthorId=currentUser.getUid!.toString();
      paymentModel.setCoinsAmount=coins;
      paymentModel.setAmount=balance;
      paymentModel.setTransactionType=PaymentsModel.keyTransactionTypePurchase;
      paymentModel.setMethod=PaymentsModel.keyTransactionTypePurchaseMethod;
      paymentModel.setReferenceNumber = referenceNumber;


      paymentModel.save();

    });
    }

  String generateReferenceNumber() {
    final random = Random();

    // Generate 4 random words with exactly 4 characters each
    final words = generateWordPairs()
        .map((wp) => wp.first)
        .where((word) => word.length == 2)
        .take(2)
        .toList();

    // Ensure we have exactly 4 words, regenerate if necessary
    while (words.length < 2) {
      words.addAll(generateWordPairs()
          .map((wp) => wp.first)
          .where((word) => word.length == 2)
          .take(2 - words.length));
    }

    // Generate 4 random numbers, each being 4 digits long
    final numbers = List.generate(2, (_) => random.nextInt(9999).toString().padLeft(2, '0'));

    // Combine words and numbers
    final combined = <String>[];
    for (var i = 0; i < 2; i++) {
      combined.add(words[i]);
      combined.add(numbers[i]);
    }

    return combined.join('-');
  }

  int getCoinsFromAmount(double amount){
    return amount~/singleCoinPrice;
  }





}
