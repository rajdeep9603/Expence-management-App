import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/group.dart';
import 'package:personal_expenses/group/groupmember/add_group_member_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/get_group_contact.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class EditGroupScreenModel extends BaseViewModel{

  int type = 0;
  int? gid;
  bool imagchnage = false;
  bool bannerchnage = false;
  GetSingalGroupContact? data;
  File? file;
  File? file_img;
  File? result;
  late String img,bimg;
  var db = DatabaseHelper();
  late var multipartFile;
  File? bfile;
  File? bfile_img;
  File? bresult;
  DateTime _date = DateTime.now();
  TextEditingController groupNameController = TextEditingController();

  FocusNode groupNameFocusNode = FocusNode();

  init(GetSingalGroupContact g) async {
    data = g;

    img = data!.data!.gdList!.first.image!;
    bimg = data!.data!.gdList!.first.banner!;

    gid = data!.data!.gdList!.first.id!;
    groupNameController = TextEditingController(text: data!.data!.gdList!.first.name!);

    if(data!.data!.gdList!.first.type == "1"){
      type = 1;
      notifyListeners();
    }else if(data!.data!.gdList!.first.type == "2"){
      type = 2;
      notifyListeners();
    }else if(data!.data!.gdList!.first.type == "3"){
      type = 3;
      notifyListeners();
    }else{
      type= 4;
      notifyListeners();
    }

  }

  unfocusall(){

    groupNameFocusNode.unfocus();
  }

  next() async{


    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(_date);

    if(groupNameController.text.isNotEmpty && type > 0){

      if(result != null){

        imagchnage = true;
        bannerchnage = true;

        List<int> imageBytes = result!.readAsBytesSync();
        String  base64Image = base64Encode(imageBytes);
        Uint8List _bytesImage = Base64Decoder().convert(base64Image);

        if(bresult != null){

          List<int> imageBytes = bresult!.readAsBytesSync();
          String  base64Image = base64Encode(imageBytes);
          Uint8List _bytesImageb = Base64Decoder().convert(base64Image);

          setBusy(true);
          notifyListeners();
          AddGroup.updateOneGroup(gid,groupNameController.text, type.toString(), result!.path, bresult!.path,imagchnage,bannerchnage).then((value) async {


            if(value != null){
              //Map v = value;

              //int id =v['messageCode'];

              if(value == true){
                setBusy(false);
                notifyListeners();

                Get.snackbar(
                  StringRes.hoorey,
                  'Done',
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

                GroupHeader gh = GroupHeader(id: gid,name: groupNameController.text, image: _bytesImage, type: type, username: username, time: formattedDate, bimage: _bytesImageb);
                int i = await db.insertinGroup(gh);
                if(i > 0){
                  GroupHeader? gh1 = await db.getSingal(gid!);
                  if(gh1 != null){
                    Get.to(() => AddGroupMemberScreen(id: gh1.id,));
                  }
                }else{
                  Get.snackbar(
                    'Error',
                    'Something is Fissy... ',
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
              }
              else{
                setBusy(false);
                notifyListeners();
                Get.snackbar(
                  'Error',
                  "error",
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
              print('no update done..');
            }
          });

        }
        else{
          Get.snackbar(
            'Error',
            'Change Banner Photo',
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



      }
      else{

        Get.snackbar(
          'Error',
          'Change Group Photo',
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


        /*if(result != null){

          imagchnage = true;
          bannerchnage = false;

          setBusy(true);
          notifyListeners();
          AddGroup.updateOneGroup(gid,groupNameController.text, type.toString(), result!.path, bimg,imagchnage,bannerchnage).then((value) async {
            setBusy(false);

            if(value != null){
              Map v = value;

              int id = v['messageCode'];

              if(id > 0){
                setBusy(false);
                notifyListeners();

                Get.snackbar(
                  StringRes.hoorey,
                  v['message'].toString(),
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

                *//*GroupHeader gh = GroupHeader(id: id,name: groupNameController.text, image: _bytesImage, type: type, username: 'xyz', time: formattedDate, bimage: _bytesImageb);
              int i = await db.insertinGroup(gh);
              if(i > 0){
                GroupHeader? gh1 = await db.getSingal(id);
                if(gh1 != null){
                  Get.to(() => AddGroupMemberScreen(id: gh1.id,));
                }
              }else{
                Get.snackbar(
                  'Error',
                  'Something is Fissy... ',
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
              }*//*
              }
              else{
                Get.snackbar(
                  'Error',
                  v['message'].toString(),
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
              print('no update done..');
            }
          });
        }
        else if(bresult != null){
          imagchnage = false;
          bannerchnage = true;

          setBusy(true);
          notifyListeners();
          AddGroup.updateOneGroup(gid,groupNameController.text, type.toString(), img, bresult!.path,imagchnage,bannerchnage).then((value) async {
            setBusy(false);

            if(value != null){
              Map v = value;

              int id = v['messageCode'];

              if(id > 0){
                setBusy(false);
                notifyListeners();

                Get.snackbar(
                  StringRes.hoorey,
                  v['message'].toString(),
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

                *//*GroupHeader gh = GroupHeader(id: id,name: groupNameController.text, image: _bytesImage, type: type, username: 'xyz', time: formattedDate, bimage: _bytesImageb);
              int i = await db.insertinGroup(gh);
              if(i > 0){
                GroupHeader? gh1 = await db.getSingal(id);
                if(gh1 != null){
                  Get.to(() => AddGroupMemberScreen(id: gh1.id,));
                }
              }else{
                Get.snackbar(
                  'Error',
                  'Something is Fissy... ',
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
              }*//*
              }
              else{
                Get.snackbar(
                  'Error',
                  v['message'].toString(),
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
              print('no update done..');
            }
          });
        }
        else{

          imagchnage = false;
          bannerchnage = false;

          setBusy(true);
          notifyListeners();
          AddGroup.updateOneGroup(gid,groupNameController.text, type.toString(), img, bimg,imagchnage,bannerchnage).then((value) async {
            setBusy(false);

            if(value != null){
              Map v = value;

              int id = v['messageCode'];

              if(id > 0){
                setBusy(false);
                notifyListeners();

                Get.snackbar(
                  StringRes.hoorey,
                  v['message'].toString(),
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

                *//*GroupHeader gh = GroupHeader(id: id,name: groupNameController.text, image: _bytesImage, type: type, username: 'xyz', time: formattedDate, bimage: _bytesImageb);
              int i = await db.insertinGroup(gh);
              if(i > 0){
                GroupHeader? gh1 = await db.getSingal(id);
                if(gh1 != null){
                  Get.to(() => AddGroupMemberScreen(id: gh1.id,));
                }
              }else{
                Get.snackbar(
                  'Error',
                  'Something is Fissy... ',
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
              }*//*
              }
              else{
                Get.snackbar(
                  'Error',
                  v['message'].toString(),
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
              print('no update done..');
            }
          });
        }*/

      }

    }
    else{

      if(type == 0){
        Get.snackbar(
          'Error',
          'Select Group Type',
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
      }else{
        Get.snackbar(
          'Error',
          'Enter Group Name',
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

  bpickFile() async{

    try {

      List<PlatformFile> _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      ))!.files;

      if(_paths.isNotEmpty){
        bfile_img = File(_paths.single.path!);
        //bfile = await compressAndGetFile(File(bfile_img!.path));
        bresult = bfile_img;
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

  /*static Future<File?> compressAndGetFile(File file) async {
    Random random = Random();
    int randomNumber = random.nextInt(10000000);
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath =
        dir.absolute.path + "/" + randomNumber.toString() + ".jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 100,
      rotate: 0,
    );

    return result;
  }*/

  void _logException(String message) {}

}