import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/expense.dart';
import 'package:personal_expenses/group/addgroupexpanse/whopaid/who_paid_screen.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/expense_model.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class AddGroupExpensesScreenModel extends BaseViewModel{

  late String gn;
  TextEditingController categoryContoller = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController titleContoller = TextEditingController();
  TextEditingController descriptionContoller = TextEditingController();
  TextEditingController dateContoller = TextEditingController();


  FocusNode categoryFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();

  Uint8List? result;

  DateTime selectedDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy');
  var db = DatabaseHelper();

  double amount =0.0;

  SingalExpenseAdd e = SingalExpenseAdd();

  init(String name){
    gn = name;
  }

  birthDay(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
    descriptionFocusNode.unfocus();
    dateFocusNode.unfocus();
  }

  addE(int? gid) async {

    //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    unfocusall();


    if(categoryContoller.text.isNotEmpty && titleContoller.text.isNotEmpty && result != null && descriptionContoller.text.isNotEmpty && dateContoller.text.isNotEmpty && amount > 0.0){

      setBusy(true);
      notifyListeners();

      AddExpense.expense(gid!, titleContoller.text, categoryContoller.text, descriptionContoller.text, dateContoller.text, amount).then((value) {
        if(value != null){
          if(value.messageCode == 1){

            e = value;
            setBusy(false);
            notifyListeners();

            Get.to(() => WhoPaidScreen(gid: gid, eid: e.data!.eeList!.first.id, amount: amount,gn: gn,));

            Get.snackbar(
              StringRes.hoorey,
              value.message.toString(),
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
          else{

            setBusy(false);
            notifyListeners();
            e = SingalExpenseAdd(data: null);

            Get.snackbar(
              StringRes.error,
              value.message.toString(),
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
          print('no data found');
        }
      });

      /*ExpenseTable et = ExpenseTable(date: dateContoller.text, gid: gid, price: amount, catagorydis: descriptionContoller.text, catagoryname: categoryContoller.text, logo: result, catagorytitle: titleContoller.text, entryby: 'xyz', entrytime: formattedDate);

      int i = await db.insertExpense(et);

      if(i > 0){

        Get.snackbar(
          'Hoorey',
          'Save Successfully...',
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
      }*/

    }else{

      Get.snackbar(
        StringRes.error,
        StringRes.errorData,
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

  nextwho(int? gid) async{

    addE(gid);
    /*String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    if(categoryContoller.text.isNotEmpty && titleContoller.text.isNotEmpty && result != null && descriptionContoller.text.isNotEmpty && dateContoller.text.isNotEmpty && amount > 0.0){

      ExpenseTable et = ExpenseTable(date: dateContoller.text, gid: gid, price: amount, catagorydis: descriptionContoller.text, catagoryname: categoryContoller.text, logo: result, catagorytitle: titleContoller.text, entryby: 'xyz', entrytime: formattedDate);

      int i = await db.insertExpense(et);

      if(i > 0){

        Get.snackbar(
          'Hoorey',
          'Save Successfully...',
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

        ExpenseTable gh1 = (await db.getlaste(i))!;

        if(gh1 != null){
          Get.to(() => WhoPaidScreen(gid: gid,eid: gh1.id,amount: amount,));
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

    }*/
    //Get.to(() => WhoPaidScreen(gid: gid,eid: 1,amount: amount,));
  }

}