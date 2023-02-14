import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class SettelupScreenModel extends BaseViewModel{


  String sd = '';
  DateTime selectedDate = DateTime.now();
  DateTime lastDate = DateTime.now();

  birthDay(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if(picked != null){
      sd = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate = DateTime.parse(sd);
      notifyListeners();
    }

  }
}