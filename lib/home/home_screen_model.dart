import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/catagorywithimage.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/login/login_screen.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/expense_splitx_list_model.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

String uid = '';
int ucontactid = 0;
String randomid = '';
String username = '';
String umobile = '';

class HomeScreenModel extends BaseViewModel{

  int index=1;
  double total = 0.0;
  double totalexpense = 0.0;
  double totalincome = 0.0;
  bool show = false;
  Uint8List? result;
  var db = DatabaseHelper();
  /*List<TransactionTable> localexpense = [];
  List<int> ids = [];
  List<int> exids = [];
  List<EwpList> expenselist = [];*/

  check() async {


    final prefs = await SharedPreferences.getInstance();

    if(prefs.getString('data') != null ){

      String? val = prefs.getString('data');
      Map v = json.decode(val!);
      uid = v['id'].toString();
      randomid = v['randomId'];
      umobile = v['mobile'];

      Get.to(() => const GroupScreen());

    }else{
      Get.to(() => const LoginScreen());
    }

  }

  init() async {



    final prefs = await SharedPreferences.getInstance();
    prefs.setString('first', "true");
    notifyListeners();

    Future.delayed(Duration.zero, () async{

      var lol = await openDatabase(StringRes.dbName);
      int? count = Sqflite.firstIntValue(await lol.rawQuery('SELECT COUNT(*) FROM profile'));

      if(count! > 0){
        final _userAuthData=await db.profiles();

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
    
    insertFirst();

    if(prefs.getString('data') != null ){
      String? val = prefs.getString('data');
      Map v = json.decode(val!);
      uid = v['id'].toString();
      randomid = v['randomId'];
      umobile = v['mobile'];
    }

  }

  insertFirst() async {

    final dbg = await db.db;
    var lol = await openDatabase(StringRes.dbName);

    int? count = Sqflite.firstIntValue(await lol.rawQuery('SELECT COUNT(*) FROM catagorywithimage'));

    if(count == 0 || count! < 0){

      await add('images/movie.png',StringRes.movie);
      await add('images/games.png',StringRes.games);
      await add('images/food.png',StringRes.food);
      await add('images/sports.png',StringRes.sports);
      await add('images/grocery.png',StringRes.grocery);
      await add('images/mortgage.png',StringRes.mortgage);
      await add('images/repairing.png',StringRes.repairing);
      await add('images/furniture.png',StringRes.furniture);
      await add('images/electricity.png',StringRes.electricity);
      await add('images/pets.png',StringRes.pets);
      await add('images/lifeInsurance.png',StringRes.life);
      await add('images/clothes.png',StringRes.clothes);
      await add('images/gifts.png',StringRes.gifts);
      await add('images/taxes.png',StringRes.taxes);
      await add('images/medicalemergency.png',StringRes.medical);
      await add('images/fuel.png',StringRes.fuel);
      await add('images/texi.png',StringRes.texi);
      await add('images/parking.png',StringRes.parking);
      await add('images/travelicon.png',StringRes.travel);
      await add('images/interneticon.png',StringRes.internet);
      await add('images/bills.png',StringRes.bills);
      await add('images/householdsupplies.png',StringRes.household);
    }
  }


  add(String path, String name) async{
    final byteData = await rootBundle.load('$path');

    var buffer = byteData.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    Uint8List _bytesImage = Base64Decoder().convert(m);
    print('------------>$m');
    print('------------>$_bytesImage');

    CatagoryWithImageTable ct = CatagoryWithImageTable(image: _bytesImage,title: name);

    int i = await db.insertCatagoryWithImage(ct);


  }

  /*load(){

    setBusy(true);
    notifyListeners();
    AllGroups.groups().then((value) {
      if(value !=  null){
        if(value.messageCode == 1){

          value.data!.gdList!.forEach((element) {
            ids.add(element.id!);
          });

          getsingalg();

        }
        else{
          setBusy(false);
          notifyListeners();
        }
      }
      else{
        print("no data found");
        setBusy(false);
        notifyListeners();
      }
    });

  }

  getsingalg(){

    ids.forEach((id) {
      ucontactid = 0;
      GetSingalGroup.singalgroupinfo(id).then((value) async {
        if(value !=  null){
          if(value.messageCode == 1){

            if(ucontactid == 0){
              value.data!.ecList!.forEach((element) {
                if(element.mobileNo == umobile){
                  ucontactid = element.id!;
                }
              });
            }

            print('----------------------------$umobile');
            print('-----------------no.......$ucontactid');

            GetAllExpense.list(id).then((value1){
              if(value1 != null){
                if(value1.messageCode == 1){

                  value1.data!.eeList!.forEach((element) {
                    exids.add(element.id!);
                  });

                  exids.forEach((element) {

                    ExpenseSplit.getsingalexpensesplitlist(id, element).then((value2) {
                      if(value2 != null){
                        if(value2.messageCode == 1){

                          value2.data!.ewpList!.forEach((element) {

                            if(ucontactid == element.contactId){
                              expenselist.add(element);
                            }

                          });

                          expenselist.forEach((element) {

                            localexpense.forEach((el) {
                              if(el.ttypeid == 6){
                                if(el.price != element.amount){

                                }
                              }
                            });

                          });

                        }

                      }else{
                        print('error to get expense splitx member...');
                      }
                    });

                  });

                  notifyListeners();

                }else{
                  setBusy(false);
                  notifyListeners();
                }
              }else{
                print("no expense found");
                setBusy(false);
                notifyListeners();
              }
            });

          }
          else{
            setBusy(false);
            notifyListeners();
          }
        }
        else{
          print("no contact found");
          setBusy(false);
          notifyListeners();
        }
      });

    });

  }
*/
}