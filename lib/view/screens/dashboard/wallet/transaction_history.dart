import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/constants/status.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../view_model/transaction_history_controller.dart';


class TransactionHistory extends StatelessWidget {
  const TransactionHistory();


  @override
  Widget build(BuildContext context) {
    TransactionHistoryViewModel transactionHistoryViewModel = Get.put(TransactionHistoryViewModel());
    transactionHistoryViewModel.fetchTransactionHistory();
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Transaction History',
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
      body: GetBuilder<TransactionHistoryViewModel>(
          init: transactionHistoryViewModel,
          builder: (controller) {
            if(controller.status==Status.Loading)
              return QuickHelp.showLoadingAnimation();

            if(controller.generateTransactionList(controller.transactionsData).isEmpty)
              return Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                    Text("No Transaction record found", style: sfProDisplayMedium.copyWith(
                      fontSize: 14.sp,

                    ),),
                  ],
                ),
              );

            return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: ListView.builder(
              itemCount: controller.generateTransactionList(controller.transactionsData).length,
              itemBuilder: (context, index) {
                var transactionList = controller.generateTransactionList(controller.transactionsData);
                return transactionList[index];
              },
            )
          );
        }
      ),
    );
  }



}
