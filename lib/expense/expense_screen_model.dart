import 'package:flutter/material.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:stacked/stacked.dart';

class ExpenseScreenModel extends BaseViewModel{

  bool back = false;
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool showsearchbar = false;
  List<TransactionTable>? items;
  List listvalue = [];
  var listkeys;
  var db = DatabaseHelper();
  List find = [];

  void runFilter(String enteredKeyword) {
    List sortinglist = [];
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = [];
      find  = [];
      isSearch = false;
    } else {
      listvalue.forEach((element) {
        if(element.length > 1){
          element.forEach((el){
            sortinglist.add(el);
          });
        }else{
          sortinglist.add(element.first);
        }
      });
      results = sortinglist
          .where((user) =>
          user['title'].toLowerCase().contains(enteredKeyword.toLowerCase())
      ).toList();
      isSearch = true;
    }
    find = results;
    notifyListeners();
  }


}