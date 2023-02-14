import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

class LoginScreenModel extends BaseViewModel{

  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  var db = DatabaseHelper();
  bool showText = true;

  init(){
    Future.delayed(Duration.zero, () async{

      var lol = await openDatabase(StringRes.dbName);
      int? count = Sqflite.firstIntValue(await lol.rawQuery('SELECT COUNT(*) FROM profile'));

      if(count! > 0){
        final _userAuthData=await db.profiles();

        userNameController.text = _userAuthData.first.uname!;

        print(_userAuthData.first.uname);
        print(_userAuthData.first.birthdate);
        print(_userAuthData.first.gender);
        print(_userAuthData.first.mail);
        print(_userAuthData.first.address);
        print(_userAuthData.first.mobile);
        notifyListeners();
      }else{
        print('no user');
      }


    });
  }

  unfocusall(){
    userNameFocusNode.unfocus();
    passWordFocusNode.unfocus();
  }

  next(){

    if(userNameController.text.isNotEmpty && passWordController.text.isNotEmpty){
      setBusy(true);
      notifyListeners();
      VerifyLogin.checkLogin(userNameController.text, passWordController.text).then((value) async {

        if(value!.messageCode == 1){

          setBusy(false);

          Map<String, dynamic> bodyData = {
            "id": value.data!.emum!.id,
            "randomId": value.data!.emum!.randomId,
            "username": value.data!.emum!.userName,
            "mobile":value.data!.emum!.mobileNo!
          };

          uid = value.data!.emum!.id.toString();
          randomid = value.data!.emum!.randomId!;
          username = value.data!.emum!.userName!;
          umobile = value.data!.emum!.mobileNo!;



          String sd = json.encode(bodyData);

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('data', sd);
          notifyListeners();
          Get.to(() => const GroupScreen());

        }else{
          setBusy(false);
          notifyListeners();
          Get.snackbar(
            'Error',
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

      });

    }else{
      Get.snackbar(
        'Error',
        'Fill All Data',
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