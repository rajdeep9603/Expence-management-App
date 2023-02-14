import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/balance/settelup/settelup_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:stacked/stacked.dart';

class SettelupScreen extends StatelessWidget {
  const SettelupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettelupScreenModel>.reactive(viewModelBuilder: () => SettelupScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      width: Get.width*.125,
                      height: Get.width*.125,
                      margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.07),
                      child: const Icon(IconRes.close,color: ColorRes.headingColor,),
                      decoration: const BoxDecoration(
                        color: ColorRes.white,
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                    ),
                  ),
                ),


                Row(
                  children: [

                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: (){
                          model.birthDay(context);
                        },
                        child: Container(
                          width: Get.width*.125,
                          height: Get.width*.125,
                          margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.02),
                          child: SvgPicture.asset('images/calender.svg',color: ColorRes.headingColor,fit: BoxFit.scaleDown,),
                          decoration: const BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: (){
                          //Get.back();
                        },
                        child: Container(
                          width: Get.width*.125,
                          height: Get.width*.125,
                          margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                          child: const Icon(IconRes.right,color: ColorRes.headingColor,),
                          decoration: const BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            )

          ],
        ),
      );
    });
  }
}
