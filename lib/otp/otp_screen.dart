import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/otp/otp_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatelessWidget {

  String? id,rid,otp, un;

  OtpScreen({required this.id, required this.rid, required this.otp, required this.un});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpScreenModel>.reactive(
      onModelReady: (model){
        model.init(id,rid,otp,un);
      },
      viewModelBuilder: ()=> OtpScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text('OTP', style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 25.0,fontWeight: FontWeight.w400),),
            Text('verification', style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 25.0,fontWeight: FontWeight.w400),),
            Text('You will get OTP via SMS.', style: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 14.0),),

            SizedBox(height: Get.height*.03,),

            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  width: Get.width*.15,
                  height: Get.width*.15,
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                  ),
                  child: Center(
                    child: Container(
                      width: Get.width*.03,
                      height: Get.width*.07,
                      child: TextField(
                        controller: model.one,
                        focusNode: model.onef,
                        //textInputAction: TextInputAction.next,
                        onChanged: (value){
                          if(value.length > 0){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        maxLength: 1,
                        style: appTextStyle(textColor: ColorRes.filledText),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: Get.width*.15,
                  height: Get.width*.15,
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                  ),
                  child: Center(
                    child: Container(
                      width: Get.width*.03,
                      height: Get.width*.07,
                      child: TextField(
                        controller: model.two,
                        focusNode: model.twof,
                        //textInputAction: TextInputAction.next,
                        onChanged: (value){
                          if(value.length > 0){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        maxLength: 1,
                        style: appTextStyle(textColor: ColorRes.filledText),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: Get.width*.15,
                  height: Get.width*.15,
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                  ),
                  child: Center(
                    child: Container(
                      width: Get.width*.03,
                      height: Get.width*.07,
                      child: TextField(
                        controller: model.three,
                        focusNode: model.threef,
                        //textInputAction: TextInputAction.next,
                        onChanged: (value){
                          if(value.length > 0){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        maxLength: 1,
                        style: appTextStyle(textColor: ColorRes.filledText),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: Get.width*.15,
                  height: Get.width*.15,
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                  ),
                  child: Center(
                    child: Container(
                      width: Get.width*.03,
                      height: Get.width*.07,
                      child: TextField(
                        controller: model.four,
                        focusNode: model.fourf,
                        maxLength: 1,
                        //textInputAction: TextInputAction.next,
                        onChanged: (value){
                          if(value.length > 0){
                            model.unfocusall();
                          }
                        },
                        style: appTextStyle(textColor: ColorRes.filledText),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),*/

            OTPTextField(
              length: 4,
              width: Get.width*.9,
              fieldWidth: 80,
              style: appTextStyle(textColor: ColorRes.filledText),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                model.code = pin;

                print('---------$pin');
              },
            ),

            SizedBox(height: Get.height*.03,),

            GestureDetector(
              onTap: (){
                //Get.to(() => const SignUpScreen());

                model.check();
              },
              child: Container(
                margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*0.03),
                width: Get.width*.8,
                height: Get.height*0.07,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorRes.headingColor),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  gradient: gredient()
                ),
                child: Center(
                  child: Text(StringRes.verify,style: appTextStyle(fontSize: 20.0,textColor:  ColorRes.white),),
                ),
              ),
            ),

            SizedBox(height: Get.width*.03,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text('Didn\'t receive the OTP?',style: appTextStyle(textColor: ColorRes.textHintColor),),

                SizedBox(width: Get.width*.01,),

                GestureDetector(
                  onTap: (){
                    print('resend');
                    model.unfocusall();
                  },
                  child: Text('Resend again',style: appTextStyle(textColor: ColorRes.headingColor),),
                ),

              ],
            ),

          ],
        ),
      );
    });
  }
}
