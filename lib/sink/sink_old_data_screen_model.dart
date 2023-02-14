import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/expense_splitx_list_model.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class SinkDataScreenModel extends BaseViewModel{

  bool isSearch = false;
  List find = [];
  SyncData sd = SyncData();
  var db = DatabaseHelper();
  List<TransactionTable> localexpense = [];
  bool check = false;

  init(){

    newdata();
  }

  alldata(){
    setBusy(true);
    notifyListeners();
    ExpenseSplit.getsingalexpensesplitlistall().then((value) {
      if(value != null){
        if(value.messageCode == 1){
          sd = value;
          setBusy(false);
          notifyListeners();
        }else{
          sd = SyncData(data: null);
          setBusy(false);
          notifyListeners();
        }
      }else{
        sd = SyncData(data: null);
        print('no expenses');
        setBusy(false);
        notifyListeners();
      }
    });
  }

  newdata(){
    print('--------$randomid');

    setBusy(true);
    notifyListeners();
    ExpenseSplit.getsingalexpensesplitlist().then((value) {
      if(value != null){
        if(value.messageCode == 1){
          sd = value;
          setBusy(false);
          notifyListeners();
        }else{
          sd = SyncData(data: null);
          setBusy(false);
          notifyListeners();
        }
      }else{
        sd = SyncData(data: null);
        print('no expenses');
        setBusy(false);
        notifyListeners();
      }
    });
  }

  addto()async{

    setBusy(true);
    notifyListeners();

    await db.transactions().then((value) {
      if(value != null){
        localexpense = value;
      }
    });

    sd.data!.ewpList!.forEach((element) async {
      check = false;
      localexpense.forEach((el) {
        if(el.ttypeid == 6){
          if(el.price == element.amount){
            check = true;
          }
        }

        print('--------${el.price}------${element.amount}');
        print('--------------${check}');

      });

      if(check == false){
        final byteData = await rootBundle.load('images/bills.png');

        var buffer = byteData.buffer;
        var m = base64.encode(Uint8List.view(buffer));
        Uint8List _bytesImage = Base64Decoder().convert(m);

        String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String d2 = DateFormat('yyyy-MM-dd').format(element.entryTime!);

        TransactionTable tt = TransactionTable(tcatagory: StringRes.bills,entrydate: d1,ttypeid: 6,date: d2,subtitle: 'group expense',logo: _bytesImage,price: element.amount,ttitle: "group",ttype: StringRes.expense);

        await db.insertTransaction(tt);
      }

    });
    setBusy(false);
    notifyListeners();
    Get.offAll(() => const HomeScreen());

  }

}