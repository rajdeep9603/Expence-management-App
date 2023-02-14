import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/group.dart';
import 'package:personal_expenses/group/groupmember/add_group_member_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:stacked/stacked.dart';

class AddGroupScreenModel extends BaseViewModel{

  int type = 0;
  File? file;
  File? file_img;
  File? result;
  var db = DatabaseHelper();
  File? bfile;
  File? bfile_img;
  File? bresult;
  DateTime _date = DateTime.now();
  TextEditingController groupNameController = TextEditingController();

  FocusNode groupNameFocusNode = FocusNode();

  unfocusall(){

    groupNameFocusNode.unfocus();
  }

  next() async{

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(_date);

    if(groupNameController.text.isNotEmpty && type > 0){
      //Get.to(() => AddGroupMemberScreen(name: groupNameController.text,type: type,));

      if(result != null){

        List<int> imageBytes = result!.readAsBytesSync();
        String  base64Image = base64Encode(imageBytes);
        Uint8List _bytesImage = Base64Decoder().convert(base64Image);

        if(bresult != null){
          List<int> imageBytes = bresult!.readAsBytesSync();
          String  base64Image = base64Encode(imageBytes);
          Uint8List _bytesImageb = Base64Decoder().convert(base64Image);

          setBusy(true);
          notifyListeners();
          AddGroup.addOneGroup(groupNameController.text, type.toString(), uid, 0, result!.path, bresult!.path).then((value) async {
            setBusy(false);

            Map v = value!;

            int id = v['data']['id'];

            if(id > 0){
              setBusy(false);
              notifyListeners();
              GroupHeader gh = GroupHeader(id: id,name: groupNameController.text, image: _bytesImage, type: type, username: username, time: formattedDate, bimage: _bytesImageb);
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
              }
            }else{
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


          });

        }else{
          /*final byteData = await rootBundle.load('images/coverimg.jpg');

          var buffer = byteData.buffer;
          var m = base64.encode(Uint8List.view(buffer));
          Uint8List _bytesImageb = Base64Decoder().convert(m);

          GroupHeader gh = GroupHeader(id: 0,name: groupNameController.text, image: _bytesImage, type: type, username: 'xyz', time: formattedDate, bimage: _bytesImageb);

          int i = await db.insertinGroup(gh);

          if(i > 0){

            GroupHeader? gh1 = await db.getSingal(i);

            if(gh1 != null){
              Get.to(() => AddGroupMemberScreen(image: gh1.image, id: gh1.id, bimage: gh1.bimage,name: gh1.name,));
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
          }*/

          Get.snackbar(
            'Error',
            'Select Group Banner Photo',
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

        Get.snackbar(
          'Error',
          'Select Group Photo',
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

      }/*else{
        final byteData = await rootBundle.load('images/groupimg.jpg');

        var buffer = byteData.buffer;
        var m = base64.encode(Uint8List.view(buffer));
        Uint8List _bytesImage = Base64Decoder().convert(m);

        if(bresult != null){
          List<int> imageBytes = bresult!.readAsBytesSync();
          String  base64Image = base64Encode(imageBytes);
          Uint8List _bytesImageb = Base64Decoder().convert(base64Image);

          GroupHeader gh = GroupHeader(name: groupNameController.text, image: _bytesImage, type: type, username: 'xyz', time: formattedDate, bimage: _bytesImageb);

          int i = await db.insertinGroup(gh);

          if(i > 0){

            GroupHeader gh1 = (await db.getSingal(i))!;

            if(gh1 != null){
              Get.to(() => AddGroupMemberScreen(image: gh1.image, id: gh1.id, bimage: gh1.bimage,name: gh1.name,));
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

        }else{
          final byteData = await rootBundle.load('images/coverimg.jpg');

          var buffer = byteData.buffer;
          var m = base64.encode(Uint8List.view(buffer));
          Uint8List _bytesImageb = Base64Decoder().convert(m);

          GroupHeader gh = GroupHeader(name: groupNameController.text, image: _bytesImage, type: type, username: 'xyz', time: formattedDate, bimage: _bytesImageb);

          int i = await db.insertinGroup(gh);

          if(i > 0){

            GroupHeader gh1 = (await db.getSingal(i))!;

            if(gh1 != null){
              Get.to(() => AddGroupMemberScreen(image: gh1.image, id: gh1.id, bimage: gh1.bimage,name: gh1.name,));
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
      }*/

    }else{

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