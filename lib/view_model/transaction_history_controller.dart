
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/PaymentsModel.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../utils/constants/app_constants.dart';
import '../utils/constants/status.dart';
import '../view/screens/dashboard/wallet/transaction_history.dart';


class TransactionHistoryViewModel extends GetxController {


  List<Transaction> transactionsData = [];

  Status status= Status.Loading;

  void fetchTransactionHistory() async {
    List<Transaction> data=[];
    QueryBuilder<PaymentsModel> queryBuilder =
    QueryBuilder(PaymentsModel());
    queryBuilder.whereEqualTo(
        PaymentsModel.keyAuthorId, Get
        .find<UserViewModel>()
        .currentUser
        .getUid.toString());
    queryBuilder.orderByDescending(PaymentsModel.keyCreatedAt);

    ParseResponse parseResponse = await queryBuilder.query();
    if (parseResponse.success) {
      if (parseResponse.results != null) {
        List resultList =
        parseResponse.results!;
        for (var payment in resultList) {
          PaymentsModel paymentsModel = payment as PaymentsModel;
          data.add(Transaction(
          DateTime.parse("${paymentsModel.createdAt!.year}-${addLeadingZero(paymentsModel.createdAt!.month.toString())}-${addLeadingZero(paymentsModel.createdAt!.day.toString())}"),
              paymentsModel.getTransactionType!,
              paymentsModel.getMethod!,
              "${isTransactionTypeWithdraw(paymentsModel.getTransactionType!)? "-" : "+"}\$${paymentsModel.getAmount}",
              isTransactionTypeWithdraw(paymentsModel.getTransactionType!)? incomeIcon : outGoIcon,
               status: isTransactionTypeWithdraw(paymentsModel.getTransactionType!) ? paymentsModel.getStatus! : ''

          ));
        }
        transactionsData=data;
        status= Status.Completed;
        update();
      }
    }
    else{
      status= Status.Completed;
      update();
    }

  }

  String addLeadingZero(String digit) {
    // Ensure the input is a valid digit and parse it to an integer
    int num = int.parse(digit);

    // If the number is 9 or less, add a leading zero and return it
    if (num <= 9) {
      return num.toString().padLeft(2, '0');
    }

    // Otherwise, return the number as a string
    return num.toString();
  }

  bool isTransactionTypeWithdraw(String type){
    return PaymentsModel.keyTransactionTypeWithdraw==type;
  }

  List<Widget> generateTransactionList(List<Transaction> transactions) {
    List<Widget> transactionWidgets = [];
    DateTime? currentDate;

    for (var transaction in transactions) {
      if (currentDate == null || currentDate != transaction.date) {
        currentDate = transaction.date;
        transactionWidgets.add(Text(
          "${currentDate.day == DateTime
              .now()
              .day ? 'Today' : currentDate!.toLocal().toShortDateString()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ));
      }

      transactionWidgets.add(tile(
          transaction.icon, transaction.type, transaction.description,
          transaction.amount, transaction.status));
    }

    return transactionWidgets;
  }

  Widget tile(String icon, String title, subtitle, String price, String status) =>
      ListTile(
        leading: Image.asset(icon),
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              status.isEmpty ? '' : "  ($status)",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: const Color(0xff79767D),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          price,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

}

extension DateHelpers on DateTime {
  String toShortDateString() {
    return "${this.month}/${this.day}/${this.year}";
  }
}

class Transaction {
  final DateTime date;
  final String type;
  final String description;
  final String amount;
  final String icon;
  final String status;

  Transaction(this.date, this.type, this.description, this.amount, this.icon, {this.status=''});
}