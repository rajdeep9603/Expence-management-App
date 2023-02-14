import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:personal_expenses/database/model/bank.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

class BankDetailsScreenModel extends BaseViewModel{

  bool isBankAvailable = false;
  PageController pageController = PageController(viewportFraction: 1, keepPage: true);
  int? count;
  int loca = 0;
  BankTable? item;
  void change(int index){
    item = null;
    loca =  index;
    notifyListeners();
  }



}