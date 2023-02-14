import 'dart:typed_data';

import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

class ProfileHomeScreenModel extends BaseViewModel{

  String? name;
  Uint8List? result;
  var db = DatabaseHelper();

  init(){

    Future.delayed(Duration.zero, () async{

      var lol = await openDatabase(StringRes.dbName);
      int? count = Sqflite.firstIntValue(await lol.rawQuery('SELECT COUNT(*) FROM profile'));

      if(count! > 0){
        final _userAuthData=await db.profiles();

        name = _userAuthData.first.uname;
        result = _userAuthData.first.uimage;

        print(_userAuthData.first.uname);
        print(_userAuthData.first.birthdate);
        print(_userAuthData.first.gender);
        print(_userAuthData.first.mail);
        print(_userAuthData.first.address);
        print(_userAuthData.first.mobile);
        notifyListeners();
      }


    });

  }

}