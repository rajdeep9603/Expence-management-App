import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:stacked/stacked.dart';

class ReceiveScreenModel extends BaseViewModel{

  var db = DatabaseHelper();

  deleteItem(int? id) async{

    int i1 = await db.deleteTransaction(id!);

    if(i1 > 0){
      int i = await db.deleteReceive(id);
      if(i != null && i > 0){
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

}