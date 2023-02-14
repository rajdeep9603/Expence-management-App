import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/send.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/send/send_screen.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class AddNewSendScreenModel extends BaseViewModel{

  double amount = 0.0;
  double amountInterest = 0.0;

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController intrestController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  FocusNode amountFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode intrestFocusNode = FocusNode();
  FocusNode startDateFocusNode = FocusNode();
  FocusNode endDateFocusNode = FocusNode();

  DateTime selectedDate = DateTime.now();
  DateTime? startDate;
  var selectedDate1 = DateFormat('dd-MM-yyyy');
  var db = DatabaseHelper();

  startDay(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2500),
    );

    if(picked != null){
      startDate = picked;
      startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate = DateTime.parse(startDateController.text);
      notifyListeners();
    }else{
      //startDateController.text = StringRes.date;
    }

  }


  endDay(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate!,
      firstDate: startDate!,
      lastDate: DateTime(2500),
    );

    if(picked != null){
      endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate = DateTime.parse(endDateController.text);
      notifyListeners();
    }else{
      //endDateController.text = StringRes.date;
    }

  }

  unfocusall(){
    nameFocusNode.unfocus();
    startDateFocusNode.unfocus();
    endDateFocusNode.unfocus();
  }

  submit() async{
    String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if(amount > 0.00 && amountInterest > 0.00 && nameController.text.isNotEmpty && startDateController.text.isNotEmpty && endDateController.text.isNotEmpty){

      final byteData = await rootBundle.load('images/movie.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);

      TransactionTable tt = TransactionTable(tcatagory: StringRes.send, date: startDateController.text, entrydate: d1, ttypeid: 4, ttype: StringRes.expense, price: double.parse(amountController.text), subtitle: intrestController.text, ttitle: nameController.text, logo: _bytesImage);

      int i = await db.insertTransaction(tt);

      if(i > 0){
        SendTable st = SendTable(id: i,borrowerName: nameController.text, samount: amount, sinterest: amountInterest, startDate: startDateController.text, endDate: endDateController.text);

        int i1 = await db.insertSend(st);

        if(i1 > 0){
          Get.offAll(() => const SendScreen());

          Get.snackbar(
            'Hoorey',
            'Save Successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            borderRadius: 20,
            margin: EdgeInsets.all(Get.width/20),
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }else{
          Get.snackbar(
            'Error',
            'Something is Fissy...',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            borderRadius: 20,
            margin: EdgeInsets.all(Get.width/20),
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }


      }
    }else{
      Get.snackbar(
        'Error',
        'Fill All Data...',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        borderRadius: 20,
        margin: EdgeInsets.all(Get.width/20),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }

  }

}