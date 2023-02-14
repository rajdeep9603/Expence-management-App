import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/login/login_screen.dart';
import 'package:personal_expenses/login/login_screen_model.dart';
import 'package:personal_expenses/onbording/onbording_screen.dart';
import 'package:personal_expenses/signup/signup_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpScreenModel>.reactive(
      onModelReady: (model){
        model.init();
      },
      viewModelBuilder: () => SignUpScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: model.isBusy ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [

            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),

          ],
        )
            :
        ListView(
          children: [

            Image.asset('images/signup.png',height: Get.width*0.6,),

            //SizedBox(height: Get.height*0.01,),

            Align(
                alignment: Alignment.center,
                child: Text(StringRes.signUp,style: appTextStyle(fontSize: 28.0,textColor: ColorRes.headingColor),)),


            SizedBox(height: Get.height*0.03,),
            //FullName
            Container(
              width: Get.width*0.8,
              padding: EdgeInsets.only(left: Get.width*0.05),
              margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ColorRes.white
              ),
              child:  TextField(
                focusNode: model.nameFocusNode,
                onTap: (){},
                style: appTextStyle(textColor: ColorRes.filledText),
                controller: model.nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: StringRes.fullName,
                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.03,),



            //Mobile
            Container(
              width: Get.width*0.8,
              padding: EdgeInsets.only(left: Get.width*0.05),
              margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ColorRes.white
              ),
              child:  TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                focusNode: model.mobileFocusNode,
                onTap: (){},
                style: appTextStyle(textColor: ColorRes.filledText),
                controller: model.mobileController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  hintText: StringRes.mobile,
                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.03,),



            //Password
            Container(
              padding: EdgeInsets.only(left: Get.width*0.05),
              margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ColorRes.white
              ),
              child:  TextField(
                obscureText: model.showText,
                focusNode: model.passWordFocusNode,
                onTap: (){},
                style: appTextStyle(textColor: ColorRes.filledText),
                controller: model.passWordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: StringRes.passWord,
                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                  suffixIcon: GestureDetector(

                    onTap: (){
                      if(model.showText == true){
                        model.showText = false;
                        model.notifyListeners();
                      }else{
                        model.showText = true;
                        model.notifyListeners();
                      }
                    },
                    child: Icon(
                      model.showText == true ? IconRes.hide : IconRes.show,
                      size: Get.width*.06,
                      color: ColorRes.headingColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.03,),



            //ConfirmPassword
            Container(
              padding: EdgeInsets.only(left: Get.width*0.05),
              margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ColorRes.white
              ),
              child:  TextField(
                obscureText: model.cshowText,
                focusNode: model.confirmPassWordFocusNode,
                onTap: (){},
                style: appTextStyle(textColor: ColorRes.filledText),
                controller: model.confirmPassWordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: StringRes.cPassWord,
                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      if(model.cshowText == true){
                        model.cshowText = false;
                        model.notifyListeners();
                      }else{
                        model.cshowText = true;
                        model.notifyListeners();
                      }
                    },
                    child: Icon(
                      model.cshowText == true ? IconRes.hide : IconRes.show,
                      size: Get.width*.06,
                      color: ColorRes.headingColor,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: Get.height*0.08,),

            //button
            InkWell(
              onTap: (){
                model.next();

              },
              child: Container(
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*.08),
                height: Get.height*0.07,
                decoration: BoxDecoration(
                  gradient: gredient(),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Center(
                  child: Text(StringRes.signUp,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                ),
              ),
            ),


            SizedBox(height: Get.height*.03,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(StringRes.member,style: appTextStyle(textColor: ColorRes.textHintColor),),

                InkWell(
                  onTap: (){
                    Get.offAll(() => const LoginScreen());
                  },
                  child: Text(StringRes.login,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.bold),),
                ),

              ],
            ),

          ],
        ),
      );
    });
  }
}
