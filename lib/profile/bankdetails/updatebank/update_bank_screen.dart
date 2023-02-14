import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/profile/bankdetails/updatebank/update_bank_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class UpdateScreen extends StatelessWidget {

  int? id;

  UpdateScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateScreenModel>.reactive(
      onModelReady: (model){
        model.init(id!);
      },
      viewModelBuilder: ()=>UpdateScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [

                  Container(
                    width: Get.width,
                    height: Get.height*.22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(Get.width*.08),bottomLeft: Radius.circular(Get.width*.08)),
                      image: const DecorationImage(
                        image: AssetImage("images/appbar.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 25.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            width: Get.width*.125,
                            height: Get.width*.125,
                            margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.07),
                            child: const Icon(IconRes.back,color: ColorRes.headingColor,),
                            decoration: const BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.all(Radius.circular(100.0)),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: Get.height*.12,),

                  //update bank title
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: Get.width*.05),
                        child: Text(StringRes.updatebankdetails,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500,fontSize: 22.0),)),
                  ),

                  SizedBox(height: Get.height*.03,),

                  //form
                  //BankName
                  Container(
                    width: Get.width*0.9,
                    padding: EdgeInsets.only(left: Get.width*0.05),
                    margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorRes.white
                    ),
                    child:  TextField(
                      focusNode: model.bankNameFocusNode,
                      onTap: (){},
                      style: appTextStyle(textColor: ColorRes.filledText),
                      controller: model.bankNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: StringRes.bankname,
                        hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*0.03,),


                  //A/c No.
                  Container(
                    width: Get.width*0.9,
                    padding: EdgeInsets.only(left: Get.width*0.05),
                    margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorRes.white
                    ),
                    child:  TextField(
                      keyboardType: TextInputType.number,
                      focusNode: model.acNoFocusNode,
                      onTap: (){},
                      style: appTextStyle(textColor: ColorRes.filledText),
                      controller: model.acNoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: StringRes.acno,
                        hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*0.03,),


                  //ifsc
                  Container(
                    width: Get.width*.9,
                    padding: EdgeInsets.only(left: Get.width*0.05),
                    margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorRes.white
                    ),
                    child:  TextField(
                      //obscureText: model.showText,
                      focusNode: model.ifscFocusNode,
                      onTap: (){},
                      style: appTextStyle(textColor: ColorRes.filledText),
                      controller: model.ifscController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: StringRes.ifsc,
                        hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*0.03,),


                  //branchName
                  Container(
                    width: Get.width*.9,
                    padding: EdgeInsets.only(left: Get.width*0.05),
                    margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorRes.white
                    ),
                    child:  TextField(
                      focusNode: model.branchNameFocusNode,
                      onTap: (){},
                      style: appTextStyle(textColor: ColorRes.filledText),
                      controller: model.branchNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: StringRes.branchname,
                        hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                      ),
                    ),
                  ),


                  SizedBox(height: Get.height*0.08,),

                  //button
                  GestureDetector(
                    onTap: (){
                      model.updateInfo();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*.08),
                      width: Get.width*.5,
                      height: Get.height*0.07,
                      decoration: BoxDecoration(
                        gradient: gredient(),
                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                        child: Text(StringRes.update,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                      ),
                    ),
                  ),

                ],
              ),

              Positioned(
                left: Get.width*.35,
                top: Get.height*.15,
                child: Container(
                  width: Get.width*.30,
                  height: Get.width*.30,
                  decoration: BoxDecoration(
                    color: ColorRes.textHintColor,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                  ),
                  child: Image.asset('images/user.png',fit: BoxFit.cover,),
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
