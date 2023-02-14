import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/get_group_contact.dart';
import 'package:personal_expenses/onlionapi/splituser_model.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class BalanceScreenModel extends BaseViewModel{

  bool show = false;
  late int gid, eid;
  late double amount;
  int totalperson = 0;
  double ppe = 0.0;
  PaidUser pu = PaidUser();
  GetSingalGroupContact contacts = GetSingalGroupContact();
  List<Map> name = [];
  List<Map> notpaid = [];

  init(int? gd,int? ed, double? amo){

    gid = gd!;
    eid = ed!;
    amount = amo!;

    print('----------expanse--------$eid');
    print('----------group--------$gid');
    print('----------amount--------$amount');

    setBusy(true);
    notifyListeners();

    UserWiseExpense.userexpenselist(eid, gid).then((value) {
      if(value != null){

        if(value.messageCode == 1){

          pu = value;

          print(pu.data!.ewpList!.first.contactId);
          print(pu.data!.ewpList!.first.amount);

          print('---length------${pu.data!.ewpList!.length}');

          GetSingalGroup.singalgroupinfo(gid).then((value) {
            if(value !=  null){
              if(value.messageCode == 1){
                contacts = value;
                notifyListeners();
                setBusy(true);

                totalperson = contacts.data!.ecList!.length;

                String a = (amount / totalperson).toStringAsFixed(2);

                ppe = double.parse(a);

                print('---length------${totalperson}');
                print('---length------${ppe}');

                pu.data!.ewpList!.forEach((element) {

                  print('----${element.contactId}');
                  Map v = {"id": element.contactId, "name": "", "mobile" : "", "amount" : element.amount};

                  name.add(v);

                });

                contacts.data!.ecList!.forEach((element) {

                  name.forEach((el) {

                    if(el['id'] == element.id){
                      el['name'] = element.name;
                      el['mobile'] = element.mobileNo;
                    }

                  });

                  print('----${element.id}');
                  print('----${element.name}');
                  print('----${element.mobileNo}');

                });

                print('-----$name');


              }
              else{
                contacts = GetSingalGroupContact(data:null);
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

        }else{

          pu = PaidUser(data: null);
          setBusy(false);
          notifyListeners();

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