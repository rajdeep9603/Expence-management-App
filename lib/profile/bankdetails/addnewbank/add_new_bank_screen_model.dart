import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/bank.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:stacked/stacked.dart';

class AddNewBankModel extends BaseViewModel{

  TextEditingController bankNameController = TextEditingController();
  TextEditingController acNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();

  FocusNode bankNameFocusNode = FocusNode();
  FocusNode acNoFocusNode = FocusNode();
  FocusNode ifscFocusNode = FocusNode();
  FocusNode branchNameFocusNode = FocusNode();

  var db = DatabaseHelper();
  submit() async {

    if(branchNameController.text.isNotEmpty && acNoController.text.isNotEmpty && ifscController.text.isNotEmpty && bankNameController.text.isNotEmpty){

      BankTable bt = BankTable(name: bankNameController.text, acno: int.parse(acNoController.text), ifsc: ifscController.text, branchname: branchNameController.text);

      int id = await db.insertBank(bt);

      if(id != null && id > 0){

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

  unfocusall(){
    bankNameFocusNode.unfocus();
    acNoFocusNode.unfocus();
    ifscFocusNode.unfocus();
    branchNameFocusNode.unfocus();
  }

}