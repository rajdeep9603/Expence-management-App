import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/expense.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class SplitXScreenModel extends BaseViewModel{

  int? gid,eid;
  double? amount;
  String? sendam;
  int split = 1;
  bool allselected = false;
  List check = [];
  List<Map> selected = [];
  List<Map>? con;
  var db = DatabaseHelper();

  List<TextEditingController> controllers = [];
  List<FocusNode> focusnodes = [];

  List<TextEditingController> controllers3 = [];
  List<FocusNode> focusnodes3 = [];

  List<TextEditingController> controllers4 = [];
  List<FocusNode> focusnodes4 = [];

  double? firstsplit;

  double secondspend = 0.0;
  double? secondremaining;

  double thirdspend = 0.0;
  double? thirdremaining = 100.0;

  double fourspend = 0.0;
  double? fourremaining;

  bool isbreak = false;


  init(int? gid1, int? eid1, double? amount1, List<Map>? contacts){
    gid = gid1;
    eid = eid1;
    String conv1 = amount1!.toStringAsFixed(0);
    amount = double.parse(conv1);
    secondremaining = amount;
    fourremaining = amount1;
    con = contacts;
    notifyListeners();
  }

  next(){
    if(split == 1){

      if(selected.length > 0){
        firstsplit = (amount! / selected.length);

        selected.forEach((element) {
          element['Amount'] = firstsplit.toString();
        });

        //sendam = firstsplit.toString();

        callapi();
        print('--submit----$selected');

      }else{
        Get.snackbar(
          'Error',
          'Select contact for split',
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
    else if(split ==2){

      selected.clear();
      secondspend = 0.0;
      secondremaining = amount;

      focusnodes.forEach((element) {
        element.unfocus();
      });

      for(int i=0; i<controllers.length ; i++){
        if(controllers[i].text.isNotEmpty){
          Map v = {'ContactId': con![i]['id'],"Amount" : controllers[i].text};
          selected.add(v);
          double dummy1 = double.parse(controllers[i].text) + secondspend ;
          String conv1 = dummy1.toStringAsFixed(1);
          secondspend = double.parse(conv1);
          double dummy = secondremaining! - double.parse(controllers[i].text);
          String conv = dummy.toStringAsFixed(1);
          secondremaining = double.parse(conv);
        }
      }

      if(secondremaining == 0.0){

        callapi();
      }
      else if(secondremaining!.isNegative){
        Get.snackbar(
          'Error',
          'Remaining amount is negative',
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
      else{
        Get.snackbar(
          'Error',
          'Complete your settlement',
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

      print('---------selected-----------$selected');

      notifyListeners();

    }
    else if(split ==3){

      selected.clear();
      thirdspend = 0.0;
      thirdremaining = 100.0;

      focusnodes3.forEach((element) {
        element.unfocus();
      });

      for(int i=0; i<controllers3.length ; i++){
        if(controllers3[i].text.isNotEmpty){
          double put = amount! * (double.parse(controllers3[i].text)/100);
          Map v = {'ContactId': con![i]['id'],"Amount" : put.toString()};
          selected.add(v);
          double dummy1 = double.parse(controllers3[i].text) + thirdspend ;
          String conv1 = dummy1.toStringAsFixed(1);
          thirdspend = double.parse(conv1);
          double dummy = thirdremaining! - double.parse(controllers3[i].text);
          String conv = dummy.toStringAsFixed(1);
          thirdremaining = double.parse(conv);
        }
      }

      if(thirdremaining == 0.0){
        callapi();
      }
      else if(thirdremaining!.isNegative){
        Get.snackbar(
          'Error',
          'Remaining amount is negative',
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
      else{
        Get.snackbar(
          'Error',
          'Complete your settlement',
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

      print('---------selected-----------$selected');

      notifyListeners();

    }
    else{

      selected.clear();
      fourspend = 0.0;
      isbreak = false;
      fourremaining = amount;

      focusnodes4.forEach((element) {
        element.unfocus();
      });

      for(int i=0; i<controllers4.length ; i++){

        if(controllers4[i].text.isNotEmpty){
          Map v = {'ContactId': con![i]['id'],"Amount" : controllers4[i].text};
          selected.add(v);
          double dummy1 = double.parse(controllers4[i].text) + fourspend ;
          String conv1 = dummy1.toStringAsFixed(1);
          fourspend = double.parse(conv1);
          double dummy = fourremaining! - double.parse(controllers4[i].text);
          String conv = dummy.toStringAsFixed(1);
          fourremaining = double.parse(conv);
        }else{
          isbreak = true;
          break;
        }
      }

      if(fourremaining == 0.0){
        callapi();
      }
      else if(fourremaining!.isNegative){
        Get.snackbar(
          'Error',
          'Remaining amount is negative',
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
      else{
        if(isbreak == true){
          Get.snackbar(
            'Error',
            'Please select all user',
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
        }else{
          Get.snackbar(
            'Error',
            'Complete your remaining settlement',
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

      print('---------selected-----------$selected');

      notifyListeners();

    }
  }

  callapi(){




    selected.forEach((element) {
      if(element['ContactId'] == ucontactid){

        sendam = element['Amount'];
      }
    });

    notifyListeners();

    setBusy(true);
    notifyListeners();
    Split.list1(gid!, eid!, amount!, selected).then((value) async {
      if(value != null){
        if(value.messageCode == 1){

          final byteData = await rootBundle.load('images/bills.png');

          var buffer = byteData.buffer;
          var m = base64.encode(Uint8List.view(buffer));
          Uint8List _bytesImage = Base64Decoder().convert(m);

          String d1 = DateFormat('yyyy-MM-dd').format(DateTime.now());

          TransactionTable tt = TransactionTable(tcatagory: StringRes.bills,entrydate: d1,ttypeid: 6,date: d1,subtitle: 'group expense',logo: _bytesImage,price: double.parse(sendam!),ttitle: "group",ttype: StringRes.expense);

          int id = await db.insertTransaction(tt);

          Settelement.letssettel(eid, gid).then((value) {
            if(value != null){
              if(value.messageCode == 1){
                setBusy(false);
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
                notifyListeners();

                Get.offAll(() => const GroupScreen());
              }
              else{
                setBusy(false);
                Get.snackbar(
                  StringRes.error,
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
                notifyListeners();
                Get.offAll(() => const GroupScreen());
              }
            }else{
              setBusy(false);
              Get.snackbar(
                StringRes.error,
                'Please try again',
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
              notifyListeners();
              Get.offAll(() => const GroupScreen());
            }
          });



        }else{

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


  }

}