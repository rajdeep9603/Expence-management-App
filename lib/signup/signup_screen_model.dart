import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/signup_model.dart';
import 'package:personal_expenses/otp/otp_screen.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

class SignUpScreenModel extends BaseViewModel{

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  FocusNode confirmPassWordFocusNode = FocusNode();

  SignUp su = SignUp();
  bool showText = true;
  bool cshowText = true;
  var db = DatabaseHelper();

  init(){
    Future.delayed(Duration.zero, () async{

      var lol = await openDatabase(StringRes.dbName);
      int? count = Sqflite.firstIntValue(await lol.rawQuery('SELECT COUNT(*) FROM profile'));

      if(count! > 0){
        final _userAuthData=await db.profiles();

        nameController.text = _userAuthData.first.uname!;
        mobileController.text = _userAuthData.first.mobile.toString();

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

  next(){
    if(nameController.text.isNotEmpty && mobileController.text.isNotEmpty && passWordController.text.isNotEmpty && confirmPassWordController.text.isNotEmpty){

      if(passWordController.text == confirmPassWordController.text){
        setBusy(true);
        notifyListeners();
        SignupUser.checkSignup(nameController.text, passWordController.text, mobileController.text).then((value) async {

          if(value!.messageCode == 1){

            su = value;
            setBusy(false);
            Get.to(() => OtpScreen(id: value.data!.emum!.id.toString(),rid: value.data!.emum!.randomId,otp: value.data!.otp, un: value.data!.emum!.userName,));

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
        setBusy(false);
        notifyListeners();
        Get.snackbar(
          'Error',
          'Password Not Match',
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

  unfocusall(){
    nameFocusNode.unfocus();
    mobileFocusNode.unfocus();
    passWordFocusNode.unfocus();
    confirmPassWordFocusNode.unfocus();
  }

}