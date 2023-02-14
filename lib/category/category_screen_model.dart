import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:personal_expenses/database/model/catagorywithimage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

class CategoryScreenModel extends BaseViewModel{

  bool back = false;
  int? count;
  var db = DatabaseHelper();

  TextEditingController searchController = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  bool showsearchbar = false;
  List listvalue = [];
  List find = [];

  void runFilter(String enteredKeyword) {
    List sortinglist = [];
    List results = [];

    print(listvalue);

    List<Map> data = [];
    listvalue.forEach((element) {
      data.add(element.toMap());
    });

    if (enteredKeyword.isEmpty) {
      results = [];
      find  = [];
    } else {
      data.forEach((element) {

        print(element['title']);

        sortinglist.add(element);
      });
      results = sortinglist
          .where((user) =>
          user['title'].toLowerCase().contains(enteredKeyword.toLowerCase())
      ).toList();
    }
    find = results;

    print(find);

    notifyListeners();
  }

}