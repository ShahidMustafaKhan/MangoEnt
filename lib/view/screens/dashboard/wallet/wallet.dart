import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/Utils.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/dashboard/wallet/receipt.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/nothing_widget.dart';
import 'package:teego/view_model/transaction_controller.dart';
import '../../../../purchase/purchase.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../view_model/userViewModel.dart';
import 'checkout.dart';

class Wallet extends StatefulWidget {
  const Wallet();

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool withdraw = false;
  bool customAmount = false;
  String amount = '';
  List<Package> packages = [];
  bool isLoading = true;
  int? userCoins;

  TransactionController transactionController = Get.put(TransactionController());
  UserViewModel userViewModel = Get.find();

  List<KeypadModel> get keypad => [
        KeypadModel(digit: "1", char: ""),
        KeypadModel(digit: "2", char: "ABC"),
        KeypadModel(digit: "3", char: "DEF"),
        KeypadModel(digit: "4", char: "GHI"),
        KeypadModel(digit: "5", char: "JKL"),
        KeypadModel(digit: "6", char: "MNO"),
        KeypadModel(digit: "7", char: "PQR"),
        KeypadModel(digit: "8", char: "STU"),
        KeypadModel(digit: "9", char: ""),
        KeypadModel(digit: "", char: ""),
        KeypadModel(digit: "0", char: ""),
        KeypadModel(digit: "", char: ""),
      ];

  List<String> get wallet => [
        "100",
        "150",
        "200",
        "250",
        "500",
        "1000",
      ];

  Future<void> fetchOffers() async {
    try {
      final offering = await PurchaseApi.fetchOfferByIds(Coin.productId);
      if (offering.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No Plan found')),
        );
      } else {

        packages = offering
            .map((e) => e.availablePackages)
            .expand((element) => element)
            .toList();
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching offers: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    userCoins = Get.find<UserViewModel>().coins;
    super.initState();
    fetchOffers();

  }


  @override
  Widget build(BuildContext context) {
    userCoins = Get.find<UserViewModel>().coins;
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Wallet',
          style: SafeGoogleFont('sfProDisplayMedium', fontSize: 16.sp, color: Get.isDarkMode ? AppColors.white : AppColors.black),

        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
                color: Get.isDarkMode ? AppColors.white : AppColors.black
            )),
      ),
      body: GetBuilder<TransactionController>(
          init: transactionController,
          builder: (transactionController) {
            return GetBuilder<UserViewModel>(
                init: userViewModel,
                builder: (transactionController) {
                  return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 24.h),
                  Container(
                    height: 64.h,
                    width: 277.w,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? Color(0xff323232) :  AppColors.white,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(
                        color: Get.isDarkMode ? Color(0xff494848) :  AppColors.white,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              withdraw = false;
                              customAmount = false;
                            });
                          },
                          child: Container(
                            height: double.infinity,
                            width: 143.w,
                            decoration: BoxDecoration(
                              color: withdraw
                                  ? Colors.transparent
                                  : Get.isDarkMode ? Color(0xff484848): Color(0xffF3F5F7),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  coin,
                                  height: 24.h,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "Purchase Coins",
                                  style: TextStyle(
                                    color: Get.isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                withdraw = true;
                                customAmount = false;
                              });
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: !withdraw
                                    ? Colors.transparent
                                    : Get.isDarkMode ? Color(0xff484848): Color(0xffF3F5F7),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.wallet,
                                    color: Color(0xffC1C1C1),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Withdraw",
                                    style: TextStyle(
                                      color: Get.isDarkMode ? Colors.white : Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    key: UniqueKey(),
                    width: double.infinity,
                    height: 600.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24.r),
                        topLeft: Radius.circular(24.r),
                      ),
                      border: Border.all(
                        color: Color(0xff494848),
                      ),
                      color: Colors.transparent,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: customAmount
                        ? customAmountWidget
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  withdraw
                                      ? Text(
                                        "Your Balance",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      )
                                      : Text(
                                          "Your Coins",
                                          style: TextStyle(
                                            fontSize: 14.sp,

                                          ),
                                        ),
                                  TextButton.icon(
                                      onPressed: ()=> Get.toNamed(AppRoutes.transactionHistory),
                                      icon: ImageIcon(
                                        AssetImage(transactionIcon),
                                        color: Get.isDarkMode  ? Color(0xffC0C0C0) : AppColors.black.withOpacity(0.7),
                                      ),
                                      label: Text(
                                        "Transaction History",
                                        style: TextStyle(
                                          color: Get.isDarkMode  ? Color(0xffC0C0C0) : AppColors.black.withOpacity(0.7),
                                          fontSize: 12.h,
                                        ),
                                      ))
                                ],
                              ),
                              if(!withdraw)
                              SizedBox(height: 3.h),
                              if(!withdraw)
                                Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    coin,
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    userCoins.toString(),
                                    style: sfProDisplayBold.copyWith(
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                              if(withdraw)
                                Text(
                                "\$ ${userViewModel.myBalance}",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: amberColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 27.h),

                              withdraw
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Withdraw",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(height: 5.h,),
                                        Text(
                                          "Minimum amount of withdraw is \$100",
                                          style: TextStyle(
                                            color: Get.isDarkMode ? Colors.white70 : AppColors.black.withOpacity(0.7),
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Buy Coins",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),

                              SizedBox(height: withdraw ? 26.h : 16.h ,),
                              //* Menu

                              Expanded(
                                child: withdraw ? walletGrid : coinsGrid,
                              ),

                              ...withdraw ? walletButtons : coinsButton,
                              SizedBox(height: 12.h),
                            ],
                          ),
                  )
                ],
          );
              }
            );
        }
      ),
    );
  }

  Widget get customAmountWidget => Column(
        children: [
          SizedBox(height: 16.h),
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(userViewModel.currentUser.getAvatar!.url!),
              ),
              Positioned(
                bottom: -15,
                child: Container(
                  height: 24.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff363339),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "..6917",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 32.h),
          Text(
            "${userViewModel.currentUser.getFirstName} 💫 ",
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          Text(
            "\$ $amount",
            style: TextStyle(
              fontSize: 32.sp,
            ),
          ),
          GestureDetector(
            onTap: () {
              if(withdraw==false){
                transactionController.successfulPayment(transactionController.getCoinsFromAmount(double.parse(amount),), double.parse(amount),
                    onReturn: ()=> setState((){customAmount = false;}));
              }
              else{
                double withDrawAmount = double.parse(amount);
                if(withDrawAmount >= 100) {
                    if (transactionController.checkBalance(withDrawAmount)) {
                      Get.to(() =>
                          Checkout(
                            customAmount: customAmount,
                            withDrawAmount: withDrawAmount,
                          ))?.then((val) {
                          setState(() {
                            withdraw = true;
                            customAmount = false;
                          });
                      });
                    }
                    else {
                      QuickHelp.showAppNotificationAdvanced(
                          title: 'Insufficient Balance!', context: context);
                    }
                }
                else{
                  QuickHelp.showAppNotificationAdvanced(
                      title: 'Minimum amount of withdraw is \$100', context: context);
                }
              }
            },
            child: button(
              "Confirm",
              null,
              amberColor,
              Colors.black,
              16.sp,
              FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
              child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.7,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 16.w,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              12,
              (index) => index == 9
                  ? const SizedBox.shrink()
                  : index == 11
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              amount = amount.substring(0, amount.length - 1);
                            });
                          },
                          icon: Image.asset(back))
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              amount = amount + keypad[index].digit;
                            });
                          },
                          child: Container(
                            height: 65.h,
                            width: 102.w,
                            decoration: BoxDecoration(
                              color: Get.isDarkMode ? Color(0xff363339) : AppColors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  keypad[index].digit,
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                  ),
                                ),
                                Text(
                                  keypad[index].char,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ))
        ],
      );

  List get walletButtons => [
        GestureDetector(
          onTap: () => setState(() {
            customAmount = true;
          }),
          child: button(
            "Custom Amount",
            null,
            const Color(0xff363339),
            Colors.white70,
            16.sp,
            FontWeight.bold,
          ),
        ),
        SizedBox(height: 24.h),
        GestureDetector(
          onTap: () {
            double withDrawAmount = double.parse(wallet[transactionController.withdrawItemIndex]);
            if(transactionController.withdrawItemIndex != -1)
            if(transactionController.checkBalance(withDrawAmount)){
            Get.to(() => Checkout(
                customAmount: customAmount,withDrawAmount: withDrawAmount,
              ))?.then((val) {
            if (val != null) {
              setState(() {
                withdraw = val[0];
                customAmount = false;
              });
            }
          });}
            else{
              QuickHelp.showAppNotificationAdvanced(title: 'Insufficient Balance!', context: context);
            }
            },
          child: button(
            "Next",
            null,
            const Color(0xffF9C034),
            Colors.black,
            18.sp,
            FontWeight.w700,
          ),
        ),
      ];
  List get coinsButton => [
        GestureDetector(
          onTap: () => setState(() {
            customAmount = true;
          }),
          child: button(
            "Get Custom Amount",
            coin,
            const Color(0xff363339),
            const Color(0xff676767),
            12.sp,
            FontWeight.w500,
          ),
        ),
        SizedBox(height: 24.h),
         GestureDetector(
          onTap: () => setState(() {
            if(transactionController.purchaseItemIndex !=  -1) {
              transactionController.successfulPayment(
                  transactionController.coins[transactionController.purchaseItemIndex].coins,
                  transactionController.coins[transactionController.purchaseItemIndex].amount);
            }
          }),
          child: button(
            "Confirm",
            null,
            const Color(0xffF9C034),
            Colors.black,
            18.sp,
            FontWeight.w700,
          ),
        ),
      ];

  Widget get walletGrid => GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24.w,
          mainAxisSpacing: 24.h,
          childAspectRatio: 1.5,
        ),
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: List.generate(
          wallet.length,
          (index) => GestureDetector(
            onTap: () {
              transactionController.withdrawItemIndex=index;
              transactionController.update();
              },
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Get.isDarkMode ? Color(0xff494848) : AppColors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                "\$ ${wallet[index]}",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: transactionController.withdrawItemIndex==index ? AppColors.yellowColor : Get.isDarkMode ? Colors.white: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  Widget get coinsGrid {

      if(isLoading==true)
        return QuickHelp.appLoading();
      if(isLoading==false && packages.isEmpty)
        return NothingIsHere();

      return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 9.w,
        mainAxisSpacing: 9.h,
        childAspectRatio: 1.4,
      ),
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: List.generate(
          packages.length,
              (index) {
            final package = packages[index];

            return GestureDetector(
              onTap: () async {
                Purchases.purchaseStoreProduct(package.storeProduct).then((value){
                    transactionController.successfulPayment(transactionController.getCoinsFromAmount(package.storeProduct.price), package.storeProduct.price,
                        onReturn: ()=> setState((){customAmount = false;}));

                });

              },
              child: Container(
                width: 108.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Get.isDarkMode ?  null : AppColors.white ,
                  border: Border.all(
                    color: Get.isDarkMode ? Color(0xff484848) : Colors.transparent,
                  ),

                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          coin,
                          height: 18.h,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "${package.storeProduct.title.split(' ').first}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Get.isDarkMode ? amberColor : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 15.h,
                      width: 73.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffF9C034).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${package.storeProduct.currencyCode} ${package.storeProduct.price}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Get.isDarkMode ? amberColor : AppColors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );}
      ),
    );}

    Widget button(String text, String? icon, Color bgColor, Color fgColor,
        double size, FontWeight weight) =>
        Container(
          height: 51.93.h,
          width: 342.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.r),
            color: bgColor,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Image.asset(
                icon,
                height: 16.h,
              )
                  : const SizedBox.shrink(),
              SizedBox(
                width: 16.w,
              ),
              Text(
                text,
                style: TextStyle(
                  color: fgColor,
                  fontSize: size,
                  fontWeight: weight,
                ),
              )
            ],
          ),
        );
  }


class KeypadModel {
  final String digit;
  final String char;
  KeypadModel({required this.digit, required this.char});
}

class CoinsModel {
  final int coins;
  final double amount;
  CoinsModel({required this.coins, required this.amount});
}
