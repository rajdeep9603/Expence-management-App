import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class LoanCalculatorModel extends BaseViewModel{

  TextEditingController amount = TextEditingController();
  TextEditingController interest = TextEditingController();
  TextEditingController duration = TextEditingController();

  FocusNode af = FocusNode();
  FocusNode inf = FocusNode();
  FocusNode df = FocusNode();

  double r = 0.0;
  double p = 0.0;
  double t = 0.0;
  double outstanding = 0.0;
  double monthlyintrest = 0.0;
  double newintrest = 0.0;
  double reduceamount = 0.0;
  double principal = 0.0;
  List<Map> emilist = [];


  check(){
    af.unfocus();
    inf.unfocus();
    df.unfocus();
    emilist.clear();
    notifyListeners();

    if(amount.text.isNotEmpty){
      if(interest.text.isNotEmpty){
        if(duration.text.isNotEmpty){


          r = double.parse(interest.text);
          t = double.parse(duration.text);
          p = double.parse(amount.text);

          print('new ---------$r-----------$t---------$p');

          monthlyintrest = r/12;
          outstanding = p;

          r = r / (12 * 100); // one month interest
          t = t * 12; // one month period
          principal = (p * r * math.pow(1 + r,t)) / (math.pow(1+r, t) - 1);

          calculate();
          
          //print(emilist);

        }else{
          Get.snackbar(
            StringRes.error,
            "Enter Time Duration",
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
          StringRes.error,
          "Enter Interest Rate",
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
        StringRes.error,
        "Enter Amount",
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


  calculate(){

    if(outstanding > 0){
      print(principal);

      newintrest = (outstanding * monthlyintrest)/100;
      reduceamount = principal - newintrest;
      outstanding = outstanding - reduceamount;
      notifyListeners();

      print('----amount-----$reduceamount');
      print('----intrest-----$newintrest');
      print('----out-----$outstanding');

      Map v = {
        "outstanding" : outstanding.toStringAsFixed(1),
        "emi" : principal.toStringAsFixed(1),
        "interest" : newintrest.toStringAsFixed(1),
        "repayment" : reduceamount.toStringAsFixed(1)
      };
      
      emilist.add(v);
      notifyListeners();

      calculate();

    }else{
      print(emilist);
    }


  }

}