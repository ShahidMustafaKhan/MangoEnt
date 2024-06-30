import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/dashboard/wallet/receipt.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/transaction_controller.dart';

import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';


class Checkout extends StatefulWidget {
  final bool customAmount;
  final double withDrawAmount;
  const Checkout({required this.customAmount, required this.withDrawAmount});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<PaymentMethodModel> get list => [
        PaymentMethodModel(
            name: "Paypal", checkoutEnum: CheckoutEnum.paypal, image: paypal),
        PaymentMethodModel(
            name: "Venmo", checkoutEnum: CheckoutEnum.venmo, image: venmo),
        PaymentMethodModel(
            name: "Stripe", checkoutEnum: CheckoutEnum.stripe, image: stripe),
        PaymentMethodModel(
            name: "XE", checkoutEnum: CheckoutEnum.xe, image: xe),
        PaymentMethodModel(
            name: "Wise", checkoutEnum: CheckoutEnum.wise, image: wise),
        PaymentMethodModel(
            name: "Helcim", checkoutEnum: CheckoutEnum.helcim, image: helcium),
      ];

  CheckoutEnum selectedMethod = CheckoutEnum.paypal;
  String selectedMethodName = "PayPal";

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Wallet',
          style: SafeGoogleFont('sfProDisplayMedium', fontSize: 16.sp),

        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 24.h),
          Container(
            height: 64.h,
            width: 277.w,
            decoration: BoxDecoration(
              color: const Color(0xff323232),
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: const Color(0xff494848),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Get.back(result: [false, false]),
                  child: Container(
                    height: double.infinity,
                    width: 143.w,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
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
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(result: [true, widget.customAmount]),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff484848),
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
                              color: Colors.white,
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
            width: double.infinity,
            height: 600.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.r),
                topLeft: Radius.circular(24.r),
              ),
              border:  Border.all(

                  color: Color(0xff494848),

              ),
              color: Colors.transparent,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) => Card(
                      color: const Color(0xff494848),
                      surfaceTintColor: const Color(0xff494848),
                      child: ListTile(
                        leading: Image.asset(list[index].image),
                        title: Text(
                          list[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        trailing: Radio(
                            value: list[index].checkoutEnum,
                            groupValue: selectedMethod,
                            activeColor: amberColor,
                            fillColor:
                                MaterialStateProperty.resolveWith((Set states) {
                              if (states.contains(MaterialState.disabled)) {
                                return amberColor.withOpacity(.32);
                              }
                              return amberColor;
                            }),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  selectedMethod = val as CheckoutEnum;
                                  selectedMethodName=  list[index].name;
                                });
                              }
                            }),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      "\$ ${widget.withDrawAmount}",
                      style: TextStyle(
                        color: amberColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {
                    Get.find<TransactionController>().makeWithdrawRequest(selectedMethodName, widget.withDrawAmount);
                  },
                  child: Container(
                    height: 51.93.h,
                    width: 342.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.r),
                      color: amberColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PaymentMethodModel {
  final String name;
  final CheckoutEnum checkoutEnum;
  final String image;
  PaymentMethodModel(
      {required this.name, required this.checkoutEnum, required this.image});
}
