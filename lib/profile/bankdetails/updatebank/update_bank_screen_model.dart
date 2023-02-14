import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/bank.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class UpdateScreenModel extends BaseViewModel{

  var db = DatabaseHelper();
  int old = 0;
  BankTable? bankTable;

  TextEditingController bankNameController = TextEditingController();
  TextEditingController acNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();

  FocusNode bankNameFocusNode = FocusNode();
  FocusNode acNoFocusNode = FocusNode();
  FocusNode ifscFocusNode = FocusNode();
  FocusNode branchNameFocusNode = FocusNode();

  init(int id) async{

    old = id;

    bankTable = await db.getSingalBank(id);

    if(bankTable != null){
      if(bankNameController.text.isEmpty){
        bankNameController = TextEditingController(text: bankTable!.name ?? StringRes.bankname);
      }

      if(acNoController.text.isEmpty){
        acNoController = TextEditingController(text: bankTable!.acno.toString());
      }

      if(ifscController.text.isEmpty){
        ifscController = TextEditingController(text: bankTable!.ifsc ?? StringRes.ifsc);
      }

      if(branchNameController.text.isEmpty){
        branchNameController = TextEditingController(text: bankTable!.branchname ?? StringRes.branchname);
      }
      notifyListeners();
    }

  }

  updateInfo() async{
    unfocusall();

    if(branchNameController.text.isNotEmpty && acNoController.text.isNotEmpty && ifscController.text.isNotEmpty && bankNameController.text.isNotEmpty){

      BankTable bt = BankTable(id: old,name: bankNameController.text, acno: int.parse(acNoController.text), ifsc: ifscController.text, branchname: branchNameController.text);

      int id = await db.updateBankInfo(bt);

      if(id != null && id > 0){

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

    }else{

      Get.snackbar(
        'Error',
        'Enter All Data',
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

  unfocusall(){
    bankNameFocusNode.unfocus();
    acNoFocusNode.unfocus();
    ifscFocusNode.unfocus();
    branchNameFocusNode.unfocus();
  }

}