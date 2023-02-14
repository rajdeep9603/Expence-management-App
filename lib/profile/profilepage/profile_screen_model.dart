import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/profile.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:stacked/stacked.dart';

class ProfileScreenModel extends BaseViewModel{

  TextEditingController nameController = TextEditingController(text: username);
  TextEditingController mailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  FocusNode nameFocusnode = FocusNode();
  FocusNode mailFocusnode = FocusNode();
  FocusNode numberFocusnode = FocusNode();
  FocusNode addFocusnode = FocusNode();
  FocusNode birthFocusnode = FocusNode();

  bool male = false;
  bool female = false;
  Uint8List? onlineimg;
  int gen = 0;

  File? file;
  File? file_img;
  File? result;

  DateTime selectedDate = DateTime.now();
  DateTime lastDate = DateTime.now();
  var selectedDate1 = DateFormat('dd-MM-yyyy');
  var db = DatabaseHelper();

  submitUpdate(int? uid){
    unfocusall();

    if(male == false && female == false){

      Get.snackbar(
        'Error',
        'Please Select Gender.',
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
      if(result != null){
        if(nameController.text.isNotEmpty && mailController.text.isNotEmpty && numberController.text.isNotEmpty && addController.text.isNotEmpty && birthController.text.isNotEmpty){

          List<int> imageBytes = result!.readAsBytesSync();

          String  base64Image = base64Encode(imageBytes);


          Uint8List _bytesImage = Base64Decoder().convert(base64Image);

          updateProfile(uid,_bytesImage);
        }else{
          Get.snackbar(
            'Error',
            'Fill All Data.',
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

        if(onlineimg != null){

          if(nameController.text.isNotEmpty && mailController.text.isNotEmpty && numberController.text.isNotEmpty && addController.text.isNotEmpty && birthController.text.isNotEmpty){
            updateProfile(uid,onlineimg);
          }else{
            Get.snackbar(
              'Error',
              'Fill All Data.',
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
          Get.snackbar(
            'Error',
            'Please Select Image. ',
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
      }
    }

  }

  submit(){
    unfocusall();

    if(male == false && female == false){

      Get.snackbar(
        'Error',
        'Please Select Gender.',
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
      if(result != null){
        if(nameController.text.isNotEmpty && mailController.text.isNotEmpty && numberController.text.isNotEmpty && addController.text.isNotEmpty && birthController.text.isNotEmpty){
          insert();
        }else{
          Get.snackbar(
            'Error',
            'Fill All Data.',
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
        Get.snackbar(
          'Error',
          'Please Select Image. ',
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

  insert() async {
    if(male == false){
      gen = 2;
    }else{
      gen = 1;
    }

    List<int> imageBytes = result!.readAsBytesSync();

    String  base64Image = base64Encode(imageBytes);

    Uint8List _bytesImage = Base64Decoder().convert(base64Image);

    ProfileTable pt = ProfileTable(uname: nameController.text, uimage: _bytesImage, birthdate: birthController.text, mobile: int.parse(numberController.text), address: addController.text, mail: mailController.text, gender: gen);

    int id = await db.insertProfile(pt);

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

  }

  updateProfile(int? uid,Uint8List? img) async{
    if(male == false){
      gen = 2;
    }else{
      gen = 1;
    }

    ProfileTable pt = ProfileTable(uid: uid,uname: nameController.text, uimage: img, birthdate: birthController.text, mobile: int.parse(numberController.text), address: addController.text, mail: mailController.text, gender: gen);

    int r = await db.updateUserProfile(pt);

    print('---------------------------> $r');

    if(r != null && r > 0){

      Get.offAll(() => const HomeScreen());

      Get.snackbar(
        'Hoorey',
        'Update Successfully',
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

  }

  birthDay(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if(picked != null){
      birthController.text = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate = DateTime.parse(birthController.text);
      notifyListeners();
    }else{
      birthController.text = StringRes.dob;
    }

  }

  birthDayAlready(BuildContext context, String? bi) async{

    selectedDate = DateTime.parse(bi!);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if(picked != null){
      birthController.text = DateFormat('yyyy-MM-dd').format(picked);
      selectedDate = DateTime.parse(birthController.text);
      notifyListeners();
    }else{
      birthController.text = bi;
      selectedDate = DateTime.parse(birthController.text);
      notifyListeners();
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

  unfocusall(){
    nameFocusnode.unfocus();
    mailFocusnode.unfocus();
    numberFocusnode.unfocus();
    addFocusnode.unfocus();
    birthFocusnode.unfocus();
  }

  void _logException(String message) {}

}