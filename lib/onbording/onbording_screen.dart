import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/onbording/onbording_screen_model.dart';
import 'package:personal_expenses/profile/profile_home_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class OnBodingScreen extends StatelessWidget {
  const OnBodingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBodingScreenModel>.reactive(viewModelBuilder: () => OnBodingScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
          children: [

            Expanded(
              flex: 3,
              child: PageView(
                controller: model.controller,
                onPageChanged: (i){
                  model.index = i;
                  model.notifyListeners();
                },
                children: [

                  //1st page
                  Column(
                    children: [

                      Image.asset('images/splash1.png',width: Get.width*.6,height: Get.height*.55,),

                      Text(StringRes.welcome,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 22.0,fontWeight: FontWeight.bold),),

                      //SizedBox(height: Get.height*.01,),
                      Container(
                        margin: EdgeInsets.only(top: Get.height*0.01, right: Get.height*0.02, left: Get.height*0.02),
                        child: Text(StringRes.splash1,style: appTextStyle(textColor: ColorRes.textHintColor),textAlign: TextAlign.center,)),

                    ],
                  ),

                  //2nd page
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //mall
                      Container(
                        width: Get.width*.65,
                        height: Get.height*.10,
                        margin: EdgeInsets.all(Get.height*.01),
                        decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.015)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: Get.height*.015,bottom: Get.height*.01,top: Get.height*.02),
                              child: Text(StringRes.card1title,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.bold),)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(left: Get.height*.015),
                                  child: Text(StringRes.card1text,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                Container(
                                    margin: EdgeInsets.only(right: Get.height*.015),
                                    child: Text(StringRes.rs1,style: appTextStyle(textColor: ColorRes.headingColor),)),

                              ],
                            ),

                          ],
                        ),
                      ),

                      //hotel
                      Container(
                        width: Get.width*.65,
                        height: Get.height*.10,
                        margin: EdgeInsets.all(Get.height*.01),
                        decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.015)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                                margin: EdgeInsets.only(left: Get.height*.015,bottom: Get.height*.01,top: Get.height*.02),
                                child: Text(StringRes.card2title,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.bold),)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                    margin: EdgeInsets.only(left: Get.height*.015),
                                    child: Text(StringRes.card2text,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                Container(
                                    margin: EdgeInsets.only(right: Get.height*.015),
                                    child: Text(StringRes.rs2,style: appTextStyle(textColor: ColorRes.headingColor),)),

                              ],
                            ),

                          ],
                        ),
                      ),

                      //tour
                      Container(
                        width: Get.width*.65,
                        height: Get.height*.10,
                        margin: EdgeInsets.all(Get.height*.01),
                        decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.015)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                                margin: EdgeInsets.only(left: Get.height*.015,bottom: Get.height*.01,top: Get.height*.02),
                                child: Text(StringRes.card3title,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.bold),)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                    margin: EdgeInsets.only(left: Get.height*.015),
                                    child: Text(StringRes.card3text,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                Container(
                                    margin: EdgeInsets.only(right: Get.height*.015),
                                    child: Text(StringRes.rs3,style: appTextStyle(textColor: ColorRes.headingColor),)),

                              ],
                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: Get.height*.05,),

                      Text(StringRes.welcome2,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 22.0,fontWeight: FontWeight.bold),),

                      //SizedBox(height: Get.height*.01,),
                      Container(
                          margin: EdgeInsets.only(top: Get.height*0.01, right: Get.height*0.02, left: Get.height*0.02),
                          child: Text(StringRes.splash2,style: appTextStyle(textColor: ColorRes.textHintColor),textAlign: TextAlign.center,)),

                    ],
                  ),

                  //3rd page
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SvgPicture.asset('images/splaah2.svg',),

                      SizedBox(height: Get.height*.05,),
                      Text(StringRes.welcome3,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 22.0,fontWeight: FontWeight.bold),),

                      Container(
                          margin: EdgeInsets.only(top: Get.height*0.01, right: Get.height*0.02, left: Get.height*0.02),
                          child: Text(StringRes.splash3,style: appTextStyle(textColor: ColorRes.textHintColor),textAlign: TextAlign.center,)),

                    ],
                  ),


                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                children: [

                  //next button
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: (){
                        if(model.index<2){
                          model.index++;
                          model.controller.animateToPage(model.index, duration: const Duration(milliseconds: 400), curve: Curves.linear);
                          model.notifyListeners();
                        }else{
                          Get.to(() => const HomeScreen());
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*.08),
                        width: Get.width/2,
                        height: Get.height*0.07,
                        decoration: BoxDecoration(
                          gradient: gredient(),
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Center(
                          child: Text(StringRes.next,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: Get.height*.10,),

                  //dots & skip button
                  Container(
                    margin: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05),
                    child: Row(
                      children: [

                        Container(
                          height: Get.width*.02,
                          //width: Get.width*.03,
                          width: model.index == 0 ? Get.width*.06 : Get.width*.02,
                          margin: EdgeInsets.all(Get.width*.005),
                          decoration: BoxDecoration(
                            color: model.index == 0 ? ColorRes.headingColor : ColorRes.textHintColor,
                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                          ),
                        ),


                        Container(
                          height: Get.width*.02,
                          //width: Get.width*.03,
                          width: model.index == 1 ? Get.width*.06 : Get.width*.02,
                          margin: EdgeInsets.all(Get.width*.005),
                          decoration: BoxDecoration(
                            color: model.index == 1 ? ColorRes.headingColor : ColorRes.textHintColor,
                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                          ),
                        ),



                        Container(
                          height: Get.width*.02,
                          //width: Get.width*.03,
                          width: model.index == 2 ? Get.width*.06 : Get.width*.02,
                          margin: EdgeInsets.all(Get.width*.005),
                          decoration: BoxDecoration(
                            color: model.index == 2 ? ColorRes.headingColor : ColorRes.textHintColor,
                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      );
    });
  }

}
