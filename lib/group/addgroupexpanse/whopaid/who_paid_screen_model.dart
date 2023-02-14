import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/group/groupmember/add_group_member_screen.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/get_group_contact.dart';
import 'package:personal_expenses/splitx/splitx_screen.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';


class WhoPaidScreenModel extends BaseViewModel{

  int? eid;
  bool isavailable = false;
  bool isavailable2 = false;
  String? gname;
  double? amount;
  List check = [];
  List<Map> selected = [];
  List<Map> selected2 = [];
  GetSingalGroupContact g = GetSingalGroupContact();

  init(int? gid, int? id, double? amo, String? gn){

    eid = id;
    amount = amo;
    gname = gn;

    print('------------$eid');

    setBusy(true);
    notifyListeners();
    GetSingalGroup.singalgroupinfo(gid!).then((value) {
      if(value !=  null){
        if(value.messageCode == 1){
          g = value;
          setBusy(false);
          notifyListeners();
        }
        else{
          g = GetSingalGroupContact(data:null);
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

  }

  next(int? gid){

    selected.forEach((element) {
      if(element['ContactId'] == g.data!.ecList!.first.id){
        isavailable2 = true;
      }
    });

    selected2.forEach((element) {
      if(element['name'] == gname){
        isavailable = true;
      }
    });

    if(isavailable == false){

      Map v2 = {
        "id" : g.data!.ecList!.first.id,
        "name": g.data!.ecList!.first.name,
        "number": g.data!.ecList!.first.mobileNo,
      };

      selected2.add(v2);

    }

    if(isavailable2 == false){
      Map v = {
        "ContactId" : g.data!.ecList!.first.id,
        "Amount" : 0.0,
      };
      selected.add(v);
    }


    setBusy(true);
    notifyListeners();
    Split.list(gid!, eid!, amount!, selected).then((value){
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



          Get.offAll(() => AddGroupMemberScreen(id: gid));


          //Get.to(() => SplitXScreen(gid: value.data!.ewpList!.first.groupId,eid: eid,amount: amount,contacts: selected2,));

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