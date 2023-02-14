import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/loan.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class LoanScreenModel extends BaseViewModel{

  double amount =0.0;

  int index =1;

  LoanTable? item;

  List<LoanTable>? items;

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController loanController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  FocusNode loanFocusNode = FocusNode();
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

  startDayUpdate(BuildContext context, String? starttime) async{

    selectedDate = DateTime.parse(starttime!);
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
      startDateController.text = starttime;
      selectedDate = DateTime.parse(startDateController.text);
      notifyListeners();
    }
  }


  endDayUpdate(BuildContext context, String? endtime) async{

    DateTime dis = DateTime.parse(endtime!);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dis,
      firstDate: startDate!,
      lastDate: DateTime(2500),
    );

    if(picked != null){
      endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate = DateTime.parse(endDateController.text);
      notifyListeners();
    }else{
      endDateController.text = endtime;
      selectedDate = DateTime.parse(endDateController.text);
      notifyListeners();
    }
  }

  updateLoanInfo(String? type, int? id1) async{

    String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if(type == StringRes.home){
      final byteData = await rootBundle.load('images/lh.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);

      TransactionTable tt = TransactionTable(id: id1,tcatagory: type, date: startDateController.text, entrydate: d1, ttypeid: 3, ttype: StringRes.income, price: double.parse(amountController.text), subtitle: loanController.text, ttitle: nameController.text, logo: _bytesImage);

      int r = await db.updateTransactionInfo(tt);
      if(r > 0){
        LoanTable lt = LoanTable(id: id1,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.updateLoan(lt);
        if(result != null && result > 0){
          Get.offAll(() => const HomeScreen());
          Get.snackbar(
            'Hoorey',
            'Update Successfully',
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
            backgroundColor: Colors.green,
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

    }else if (type == StringRes.personal){

      final byteData = await rootBundle.load('images/lp.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);

      TransactionTable tt = TransactionTable(id: id1,tcatagory: type, date: startDateController.text, entrydate: d1, ttypeid: 3, ttype: StringRes.income, price: double.parse(amountController.text), subtitle: loanController.text, ttitle: nameController.text, logo: _bytesImage);

      int r = await db.updateTransactionInfo(tt);
      if(r > 0){
        LoanTable lt = LoanTable(id: id1,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.updateLoan(lt);
        if(result != null && result > 0){
          Get.offAll(() => const HomeScreen());
          Get.snackbar(
            'Hoorey',
            'Update Successfully',
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
            backgroundColor: Colors.green,
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

    }else if(type == StringRes.car){

      final byteData = await rootBundle.load('images/lc.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);

      TransactionTable tt = TransactionTable(id: id1,tcatagory: type, date: startDateController.text, entrydate: d1, ttypeid: 3, ttype: StringRes.income, price: double.parse(amountController.text), subtitle: loanController.text, ttitle: nameController.text, logo: _bytesImage);

      int r = await db.updateTransactionInfo(tt);
      if(r > 0){
        LoanTable lt = LoanTable(id: id1,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.updateLoan(lt);
        if(result != null && result > 0){
          Get.offAll(() => const HomeScreen());
          Get.snackbar(
            'Hoorey',
            'Update Successfully',
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
            backgroundColor: Colors.green,
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

    }else if(type == StringRes.education){

      final byteData = await rootBundle.load('images/le.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);

      TransactionTable tt = TransactionTable(id: id1,tcatagory: type, date: startDateController.text, entrydate: d1, ttypeid: 3, ttype: StringRes.income, price: double.parse(amountController.text), subtitle: loanController.text, ttitle: nameController.text, logo: _bytesImage);

      int r = await db.updateTransactionInfo(tt);
      if(r > 0){
        LoanTable lt = LoanTable(id: id1,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.updateLoan(lt);
        if(result != null && result > 0){
          Get.offAll(() => const HomeScreen());
          Get.snackbar(
            'Hoorey',
            'Update Successfully',
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
            backgroundColor: Colors.green,
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

    }else if(type == StringRes.other){

      final byteData = await rootBundle.load('images/lo.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);

      TransactionTable tt = TransactionTable(id: id1,tcatagory: type, date: startDateController.text, entrydate: d1, ttypeid: 3, ttype: StringRes.income, price: double.parse(amountController.text), subtitle: loanController.text, ttitle: nameController.text, logo: _bytesImage);

      int r = await db.updateTransactionInfo(tt);
      if(r > 0){
        LoanTable lt = LoanTable(id: id1,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.updateLoan(lt);
        if(result != null && result > 0){
          Get.offAll(() => const HomeScreen());
          Get.snackbar(
            'Hoorey',
            'Update Successfully',
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
            backgroundColor: Colors.green,
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

  submit(){

    /*print(startDateController.text);
    print(startDate!.day);
    print(startDate!.month);
    print(startDate!.year);

    int m = startDate!.month+ int.parse(endDateController.text);

    if(m < 10){

    }

    String fd = '${startDate!.year}-${()}-${startDate!.day}';
    print(endDateController.text);

    print(fd);*/

    if(amount >0.0 && nameController.text.isNotEmpty && loanController.text.isNotEmpty && startDateController.text.isNotEmpty && endDateController.text.isNotEmpty){
      insertLoan();
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

  insertLoan() async{
    String type = '';

    if(index == 1){
      type = StringRes.home;

      final byteData = await rootBundle.load('images/lh.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);
      String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
      TransactionTable tt = TransactionTable(tcatagory: type,ttypeid: 3,entrydate: d1,date: startDateController.text,subtitle: loanController.text,logo: _bytesImage,price: double.parse(amountController.text),ttitle: nameController.text,ttype: StringRes.income);
      int id = await db.insertTransaction(tt);
      TransactionTable tt1 = (await db.getLastTransaction(id))!;
      if(tt1 != null){
        LoanTable lt = LoanTable(id: id,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.insertLoan(lt);
        if(result != null && result > 0){
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
        amount = 0.0;
        startDateController.clear();
        endDateController.clear();
        loanController.clear();
        nameController.clear();
        startDate = null;
        selectedDate = DateTime.now();
        notifyListeners();
      }
    }
    else if(index == 2){
      type = StringRes.personal;

      final byteData = await rootBundle.load('images/lp.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);
      String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
      TransactionTable tt = TransactionTable(tcatagory: type,ttypeid: 3,entrydate: d1,date: startDateController.text,subtitle: loanController.text,logo: _bytesImage,price: double.parse(amountController.text),ttitle: nameController.text,ttype: StringRes.income);
      int id = await db.insertTransaction(tt);
      TransactionTable tt1 = (await db.getLastTransaction(id))!;
      if(tt1 != null){
        LoanTable lt = LoanTable(id: id,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.insertLoan(lt);
        if(result != null && result > 0){
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
        amount = 0.0;
        startDateController.clear();
        endDateController.clear();
        loanController.clear();
        nameController.clear();
        startDate = null;
        selectedDate = DateTime.now();
        notifyListeners();
      }

    }
    else if(index == 3){
      type = StringRes.car;

      final byteData = await rootBundle.load('images/lc.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);
      String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
      TransactionTable tt = TransactionTable(tcatagory: type,ttypeid: 3,entrydate: d1,date: startDateController.text,subtitle: loanController.text,logo: _bytesImage,price: double.parse(amountController.text),ttitle: nameController.text,ttype: StringRes.income);
      int id = await db.insertTransaction(tt);
      TransactionTable tt1 = (await db.getLastTransaction(id))!;
      if(tt1 != null){
        LoanTable lt = LoanTable(id: id,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.insertLoan(lt);
        if(result != null && result > 0){
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
        amount = 0.0;
        startDateController.clear();
        endDateController.clear();
        loanController.clear();
        nameController.clear();
        startDate = null;
        selectedDate = DateTime.now();
        notifyListeners();
      }
    }else if(index == 4){
      type = StringRes.education;
      final byteData = await rootBundle.load('images/le.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);
      String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
      TransactionTable tt = TransactionTable(tcatagory: type,ttypeid: 3,entrydate: d1,date: startDateController.text,subtitle: loanController.text,logo: _bytesImage,price: double.parse(amountController.text),ttitle: nameController.text,ttype: StringRes.income);
      int id = await db.insertTransaction(tt);
      TransactionTable tt1 = (await db.getLastTransaction(id))!;
      if(tt1 != null){
        LoanTable lt = LoanTable(id: id,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.insertLoan(lt);
        if(result != null && result > 0){
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
        amount = 0.0;
        startDateController.clear();
        endDateController.clear();
        loanController.clear();
        nameController.clear();
        startDate = null;
        selectedDate = DateTime.now();
        notifyListeners();
      }

    }else if(index == 5){
      type = StringRes.other;
      final byteData = await rootBundle.load('images/lo.png');
      var buffer = byteData.buffer;
      var m = base64.encode(Uint8List.view(buffer));
      Uint8List _bytesImage = Base64Decoder().convert(m);
      String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
      TransactionTable tt = TransactionTable(tcatagory: type,ttypeid: 3,entrydate: d1,date: startDateController.text,subtitle: loanController.text,logo: _bytesImage,price: double.parse(amountController.text),ttitle: nameController.text,ttype: StringRes.income);
      int id = await db.insertTransaction(tt);
      TransactionTable tt1 = (await db.getLastTransaction(id))!;
      if(tt1 != null){
        LoanTable lt = LoanTable(id: id,amount: amount, giverName: nameController.text, interest: double.parse(loanController.text), starttime: startDateController.text, endtime: endDateController.text, type: type);
        int result = await db.insertLoan(lt);
        if(result != null && result > 0){
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
        amount = 0.0;
        startDateController.clear();
        endDateController.clear();
        loanController.clear();
        nameController.clear();
        startDate = null;
        selectedDate = DateTime.now();
        notifyListeners();
      }
    }
  }

  unfocusall(){
    nameFocusNode.unfocus();
    loanFocusNode.unfocus();
    startDateFocusNode.unfocus();
    endDateFocusNode.unfocus();
  }


  deleteItem(int? id) async{
    int i = await db.deleteTransaction(id!);
    if(i != null && i > 0){

      int i1 = await db.deleteLoan(id);

      if(i1 != null && i1 > 0){
        Get.offAll(() => const HomeScreen());
        Get.snackbar(
          'Hoorey',
          'Delete Successfully',
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
      }

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


  }





}