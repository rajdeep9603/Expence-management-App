import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/login/login_screen_model.dart';
import 'package:personal_expenses/signup/signup_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenModel>.reactive(
      onModelReady: (model){
        model.init();
      },
      viewModelBuilder: () => LoginScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: model.isBusy ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )

          ],
        )
            :
        ListView(
          children: [

            Image.asset('images/login.png',width: Get.width*0.40, height: Get.height*0.35,),

            SizedBox(height: Get.height*0.01,),

            Align(
              alignment: Alignment.center,
              child: Text(StringRes.login,style: appTextStyle(fontSize: 28.0,textColor: ColorRes.headingColor),)),


            SizedBox(height: Get.height*0.04,),


            //UserName
            Container(
              width: Get.width*0.8,
              padding: EdgeInsets.only(left: Get.width*0.05),
              margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: ColorRes.white
              ),
              child:  TextField(
                focusNode: model.userNameFocusNode,
                keyboardType: TextInputType.number,
                maxLength: 10,
                onTap: (){},
                style: appTextStyle(textColor: ColorRes.filledText),
                controller: model.userNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: StringRes.userName,
                  counterText: '',
                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),

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
                  suffixIcon: IconButton(
                    onPressed: (){
                      if(model.showText == true){
                        model.showText = false;
                        model.notifyListeners();
                      }else{
                        model.showText = true;
                        model.notifyListeners();
                      }
                    },
                    icon: Icon(
                      model.showText == true ? IconRes.hide : IconRes.show,
                      color: ColorRes.headingColor,
                    ),
                  ),
                ),
              ),
            ),


            //SizedBox(height: Get.height*0.02,),

            //ForgetPassword
            Container(
              margin: EdgeInsets.only(right: Get.width*.07),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){},
                child: Text(StringRes.forgetPass,style: appTextStyle(textColor: ColorRes.headingColor),))),


            SizedBox(height: Get.height*0.06,),

            //Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      model.next();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*.03),
                      height: Get.height*0.07,
                      decoration: BoxDecoration(
                        gradient: gredient(),
                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                        child: Text(StringRes.login,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(() => const SignUpScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*0.08),
                      height: Get.height*0.07,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorRes.headingColor),
                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                        child: Text(StringRes.signUp,style: appTextStyle(fontSize: 20.0,textColor:  ColorRes.headingColor),),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      );
    });
  }
}
