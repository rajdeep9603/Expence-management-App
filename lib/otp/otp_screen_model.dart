import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class OtpScreenModel extends BaseViewModel{

  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();

  FocusNode onef = FocusNode();
  FocusNode twof = FocusNode();
  FocusNode threef = FocusNode();
  FocusNode fourf = FocusNode();

  String? otp, code;

  init(String? id, String? rid, String? o, [String? un]){
    uid = id!;
    randomid = rid!;
    username = un!;
    otp = o!;
  }

  check() async {
    unfocusall();

    if(code!.isNotEmpty){
      if(code == otp){

        Useless.checkok().then((value) async {
          if(value!.messageCode == 1){

            Get.to(() => const GroupScreen());

            Map<String, dynamic> bodyData = {
              "id": uid,
              "randomId": randomid,
              "username": username
            };

            String sd = json.encode(bodyData);

            final prefs = await SharedPreferences.getInstance();
            prefs.setString('data', sd);
            notifyListeners();

            print('--------$uid');
            print('--------$randomid');
            print('--------$username');


          }else{

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
          'Wrong OTP',
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
        'Enter OTP',
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
    onef.unfocus();
    twof.unfocus();
    threef.unfocus();
    fourf.unfocus();
  }

}