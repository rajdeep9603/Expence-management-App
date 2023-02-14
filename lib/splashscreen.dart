import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/splashscreenmodel.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenModel>.reactive(
      onModelReady: (model){
        model.init();
      },
      viewModelBuilder: () => SplashScreenModel(), builder: (context,model,child){
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Center(
            child: Image.asset('images/applogo.png',width: Get.width*.4,height: Get.height*.2,),
          ),
        );
    });
  }
}
