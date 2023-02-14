import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:file_picker/file_picker.dart';

class AddExpenseScreenModel extends BaseViewModel{

  TextEditingController categoryContoller = TextEditingController();
  TextEditingController titleContoller = TextEditingController();
  TextEditingController discriptionContoller = TextEditingController();
  TextEditingController amountContoller = TextEditingController();
  TextEditingController dateContoller = TextEditingController();

  FocusNode categoryFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode discriptionFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();

  File? file;
  File? file_img;
  Uint8List? result;

  DateTime selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy');
  var db = DatabaseHelper();

  birthDay(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: selectedDate,
    );

    if(picked != null){
      dateContoller.text = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate = DateTime.parse(dateContoller.text);
      notifyListeners();
    }else{
      dateContoller.text = StringRes.date;
    }

  }

  unfocusall(){
    categoryFocusNode.unfocus();
    titleFocusNode.unfocus();
    discriptionFocusNode.unfocus();
    dateFocusNode.unfocus();
    amountFocusNode.unfocus();
  }

  submit() async{

    String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());

    unfocusall();
    if(result != null && categoryContoller.text.isNotEmpty && titleContoller.text.isNotEmpty && discriptionContoller.text.isNotEmpty && amountContoller.text.isNotEmpty && dateContoller.text.isNotEmpty){

      TransactionTable tt = TransactionTable(tcatagory: categoryContoller.text,entrydate: d1,ttypeid: 2,date: dateContoller.text,subtitle: discriptionContoller.text,logo: result,price: double.parse(amountContoller.text),ttitle: titleContoller.text,ttype: StringRes.expense);

      int id = await db.insertTransaction(tt);

      if(id >0){

        Get.offAll(() => const HomeScreen());

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
          'Something is Fissy... ',
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

    }else{

      Get.snackbar(
        'Error',
        'Enter All Data',
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