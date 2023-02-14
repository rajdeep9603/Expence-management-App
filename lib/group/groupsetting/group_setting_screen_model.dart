import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/group/groupmember/contact/contact_screen.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/get_group_contact.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class GroupSettingScreenModel extends BaseViewModel{

  GetSingalGroupContact g = GetSingalGroupContact();
  String? typename;
  bool _permissionDenied = false;
  bool check = false;
  late int gid;
  List<Contact>? _contacts;
  List<Contact> selectedcontact = [];
  Contact? singalcontact;

  init(int id){
    gid = id;
    setBusy(true);
    notifyListeners();
    GetSingalGroup.singalgroupinfo(id).then((value) {
      if(value !=  null){
        if(value.messageCode == 1){
          g = value;
          notifyListeners();
          setBusy(false);
          notifyListeners();

          if(g.data!.gdList!.first.type == "1"){
            typename = "Trip";
          }else if(g.data!.gdList!.first.type == "2"){
            typename = "Home";
          }else if(g.data!.gdList!.first.type == "3"){
            typename = "Couple";
          }else{
            typename = "Other";
          }

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

  Future fetchContacts() async {

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    if (!await FlutterContacts.requestPermission(readonly: true)) {
      _permissionDenied = true;
      notifyListeners();
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      _contacts = contacts;
      check = false;
      notifyListeners();

      Get.to(()=> ContactScreen(contacts: _contacts))!.then((value) async {
        if(value != null){

          singalcontact = value[0]['contact'];

          setBusy(true);
          notifyListeners();
          String fullname = singalcontact!.name.first + singalcontact!.name.last;
          SaveContact.contacts(gid,fullname,singalcontact!.phones.first.number).then((value) async {

            if(value!.messageCode == 1){
              setBusy(false);
              notifyListeners();
              Get.snackbar(
                'Hoorey',
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

              /*ContactTable ct = ContactTable(gid: gid, contactname: fullname, contactnumber: singalcontact!.phones.first.number, enterby: 'xyz', entertime: formattedDate);

              int i = await db.insertContact(ct);*/

              /*if(i >0){
                selectedcontact.add(singalcontact!);
                notifyListeners();

                Get.offAll(() => AddGroupMemberScreen(id: gid,));

                Get.snackbar(
                  'Hoorey',
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
              }*/

            }else{
              setBusy(false);
              notifyListeners();
              Get.snackbar(
                'Error',
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

          });
          /*if(singalcontact != null){
              if(selectedcontact.isNotEmpty){
                selectedcontact.forEach((element) {
                  if(element.displayName == singalcontact!.displayName){
                    check = true;
                    notifyListeners();
                  }
                });

                if(check == false){

                  print(singalcontact!.name);
                  print(singalcontact!.phones.first.number);

                  //String fullname = singalcontact!.name.first + singalcontact!.name.last;



                }

              }else{

                print(singalcontact!.name);
                print(singalcontact!.phones.first.number);

                String fullname = singalcontact!.name.first + singalcontact!.name.last;

                ContactTable ct = ContactTable(gid: gid, contactname: fullname, contactnumber: singalcontact!.phones.first.number, enterby: 'xyz', entertime: formattedDate);

                int i = await db.insertContact(ct);

                if(i >0){
                  selectedcontact.add(singalcontact!);
                }

              }
            }*/
        }
      }
      );

    }
  }

  delete(){

    setBusy(true);
    notifyListeners();
    DeleteG.letsdeleteg(gid).then((value) {
      if(value != null){
        if(value.messageCode == 1){

          setBusy(false);
          notifyListeners();
          Get.snackbar(
            StringRes.hoorey,
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

          Get.offAll(() => const GroupScreen());

        }else{
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
        setBusy(false);
        notifyListeners();
        Get.snackbar(
          StringRes.error,
          'Please Try Again..',
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
    });

  }

}