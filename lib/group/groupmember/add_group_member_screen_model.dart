import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/contact.dart';
import 'package:personal_expenses/group/addgroupexpanse/whopaid/who_paid_screen.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/group/groupmember/add_group_member_screen.dart';
import 'package:personal_expenses/group/groupmember/contact/contact_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/add_contact_model.dart';
import 'package:personal_expenses/onlionapi/allexpenselist_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/check_whopaid_done_model.dart';
import 'package:personal_expenses/onlionapi/get_group_contact.dart';
import 'package:personal_expenses/splitx/splitx_screen.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';


class AddGroupMemberScreenModel extends BaseViewModel{

  late int gid;
  late String  gname;
  bool showFloatingmenu = false;
  File? file;
  File? file_img;
  File? result;
  DateTime _date = DateTime.now();
  bool check = false;
  List<Contact>? _contacts;
  List<Contact> selectedcontact = [];
  Contact? singalcontact;
  bool _permissionDenied = false;
  GetSingalGroupContact g = GetSingalGroupContact();
  Expenselist e = Expenselist();
  List<EwpList> list = [];
  List<EeList> edisplay = [];
  List<Map> selected2 = [];
  List<EcList> groupcontactlist = [];

  var db = DatabaseHelper();

  init(int id){
    gid = id;
    setBusy(true);
    notifyListeners();
    GetSingalGroup.singalgroupinfo(id).then((value) async {
      if(value !=  null){
        if(value.messageCode == 1){
          g = value;
          notifyListeners();
          setBusy(true);

          if(ucontactid == 0){
            value.data!.ecList!.forEach((element) {
              if(element.mobileNo == umobile){
                ucontactid = element.id!;
              }
            });
          }

          print('----------------------------$umobile');
          print('-----------------no.......$ucontactid');

          groupcontactlist = g.data!.ecList!;
          gname = g.data!.gdList!.first.name!;

          GetAllExpense.list(id).then((value){
            if(value != null){
              if(value.messageCode == 1){
                setBusy(false);
                e = value;

                e.data!.eeList!.forEach((element) {
                  edisplay.add(element);
                });

                notifyListeners();

              }else{
                e = Expenselist(data: null);
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

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(_date);

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
          String no = singalcontact!.phones.first.number;
          String newno = no.substring(no.length-10);
          SaveContact.contacts(gid,fullname,newno).then((value) async {

            if(value!.messageCode == 1){
              setBusy(false);
              notifyListeners();

              AddContact ac = value;



              ContactTable ct = ContactTable(gid: gid, contactname: fullname, contactnumber: newno, enterby: username, entertime: formattedDate);

              int i = await db.insertContact(ct);

              if(i >0){
                selectedcontact.add(singalcontact!);
                notifyListeners();

                Get.offAll(() => AddGroupMemberScreen(id: gid,));
                
                Get.snackbar(
                  'Hoorey',
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
              }

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

  pickFile() async{

    try {

      List<PlatformFile> _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      ))!.files;

      if(_paths.isNotEmpty){
        file_img = File(_paths.single.path!);
        //file = await compressAndGetFile(File(file_img!.path));
        result = file_img;
        _paths = [];
        notifyListeners();
      }else{
        print('No file Selected');
      }

    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
  }

  delete(int? eid){
    setBusy(true);
    notifyListeners();
    DeleteEx.letsdelete(eid, gid).then((value) {
      if(value!=null){

        if(value.messageCode == 1){
          setBusy(false);
          notifyListeners();
          Get.offAll(() => const GroupScreen());
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
        print('error to fetch');
        setBusy(false);
        notifyListeners();
      }
    });
  }

  whopaiddone(int? eid, double? amount){

    setBusy(true);
    notifyListeners();
    Whopaidlist.getlist(eid, gid).then((value){
      if(value!=null){
        if(value.messageCode == 1){

          selected2 = [];

          setBusy(false);
          notifyListeners();
          list = value.data!.ewpList!;

          list.forEach((element) {
            groupcontactlist.forEach((el) {
              if(element.contactId == el.id){
                Map v2 = {
                  "id" : el.id,
                  "name": el.name,
                  "number": el.mobileNo,
                };

                selected2.add(v2);

              }
            });

          });


          print('----------------$selected2');

          Get.to(() => SplitXScreen(gid: gid,eid: eid,amount: amount,contacts: selected2,));

        }else{
          setBusy(false);
          notifyListeners();
          Get.to(()=>WhoPaidScreen(gid: gid, eid: eid, amount: amount,gn: gname,));
        }
      }else{
        setBusy(false);
        notifyListeners();
        Get.snackbar(
          StringRes.error,
          'Please try again after sometime',
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


    print('------------------$eid');

  }

  void _logException(String message) {}
}