import 'dart:async';

import 'package:get/get.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/onbording/onbording_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplashScreenModel extends BaseViewModel{


  init() {

    Timer(const Duration(seconds: 5),
            (){
          load();
        }
    );



  }


  load() async {

    final prefs = await SharedPreferences.getInstance();

    if(prefs.getString('first') == "true" ){

      Get.to(() => const HomeScreen());

    }else{
      Get.to(() => const OnBodingScreen());
    }

  }
}
