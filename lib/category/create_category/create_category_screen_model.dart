import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/cupertino.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/catagorywithimage.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:stacked/stacked.dart';

class CreateCategoryScreenModel extends BaseViewModel{

  TextEditingController titleController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  var db = DatabaseHelper();

  File? file;
  File? file_img;
  File? result;

  submit()async{

    if(result != null && titleController.text.isNotEmpty){

      List<int> imageBytes = result!.readAsBytesSync();

      String  base64Image = base64Encode(imageBytes);

      Uint8List _bytesImage = Base64Decoder().convert(base64Image);

      CatagoryWithImageTable ct = CatagoryWithImageTable(image: _bytesImage,title: titleController.text);

      int id = await db.insertCatagoryWithImage(ct);

      if(id != null && id > 0){

        Get.offAll(() => const HomeScreen());

        Get.snackbar(
          'Hoorey',
          'Save Successfully',
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
        'Fill All Data.',
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