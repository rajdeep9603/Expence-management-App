import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/cards/card_screen.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/card.dart';
import 'package:stacked/stacked.dart';

class CardScreenModel extends BaseViewModel{

  int cardType = 0;
  int cardback = 0;
  int cardimg = 0;
  List<bool> backside = [];
  CardTable? data;


  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  FocusNode cardNameFocusNode = FocusNode();
  FocusNode cardNumberFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode cvvFocusNode = FocusNode();

  var db = DatabaseHelper();

  unfocusall(){
    cardNameFocusNode.unfocus();
    cardNumberFocusNode.unfocus();
    dateFocusNode.unfocus();
    cvvFocusNode.unfocus();
  }

  changecardtheme(int? id) async{

    CardTable ct = CardTable(id: id,name: cardNameController.text, cvv: cvvController.text, number: cardNumberController.text, type: cardType, expirydate: dateController.text, back: cardback);

    int i = await db.updatecardInfo(ct);

    if(i > 0){
      Get.snackbar(
        'Hoorey',
        'Card Theme Change Successfully',
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

      Get.offAll(() => const CardScreen());

      cardNumberController.clear();
      cardNameController.clear();
      dateController.clear();
      cvvController.clear();
      cardType = 0;
    }else{
      Get.snackbar(
        'Error',
        'Something is Fissy...',
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

  deletecard(int? id) async{

    int i = await db.deleteonecard(id!);

    if(i > 0){
      Get.snackbar(
        'Hoorey',
        'Card Save Successfully',
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

      Get.offAll(() => const CardScreen());
    }else{
      Get.snackbar(
        'Error',
        'Something is Fissy...',
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

  updatecard(int? id, int? b) async{
    unfocusall();
    if(cardNameController.text.isNotEmpty && cardNumberController.text.isNotEmpty && cardType > 0 && dateController.text.isNotEmpty && cvvController.text.isNotEmpty){
      CardTable ct = CardTable(back: b,id: id,name: cardNameController.text, cvv: cvvController.text, number: cardNumberController.text, type: cardType, expirydate: dateController.text);

      int i = await db.updatecardInfo(ct);

      if(i > 0){
        Get.snackbar(
          'Hoorey',
          'Card Save Successfully',
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

        Get.offAll(() => const CardScreen());

        cardNumberController.clear();
        cardNameController.clear();
        dateController.clear();
        cvvController.clear();
        cardType = 0;
      }else{
        Get.snackbar(
          'Error',
          'Something is Fissy...',
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

  submit() async {
    unfocusall();
    if(cardNameController.text.isNotEmpty && cardNumberController.text.isNotEmpty && cardType > 0 && dateController.text.isNotEmpty && cvvController.text.isNotEmpty){

      CardTable ct = CardTable(back: 1,name: cardNameController.text, cvv: cvvController.text, number: cardNumberController.text, type: cardType, expirydate: dateController.text);

      int i = await db.insertCard(ct);

      if(i > 0){
        Get.snackbar(
          'Hoorey',
          'Card Save Successfully',
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

        Get.offAll(() => const CardScreen());

        cardNumberController.clear();
        cardNameController.clear();
        dateController.clear();
        cvvController.clear();
        cardType = 0;
      }else{
        Get.snackbar(
          'Error',
          'Something is Fissy...',
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

}