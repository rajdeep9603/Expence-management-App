import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/profile/bankdetails/bank_details_screen.dart';
import 'package:personal_expenses/profile/profile_home_screen_model.dart';
import 'package:personal_expenses/profile/profilepage/profile_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileHomeScreenModel>.reactive(
      onModelReady: (model){
        model.init();
      },
      viewModelBuilder: () => ProfileHomeScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Stack(
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

                SizedBox(height: Get.height*.09,),

                Text(model.name != null ? model.name! :StringRes.profileUserName,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 25.0,fontWeight: FontWeight.w500),),

                SizedBox(height: Get.height*.05,),

                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: Get.width*.05),
                    child: Text(StringRes.general,style: appTextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                  )
                ),

                SizedBox(height: Get.height*.03,),

                //profile
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Get.to(() => const ProfileScreen());
                      print('hello');
                    },
                    child: Container(
                      width: Get.width,
                      margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringRes.profile,style: appTextStyle(textColor: ColorRes.textHintColor),),
                          Icon(IconRes.inside,color: ColorRes.textHintColor,size: Get.width*.05,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.015,),
                Container(
                  margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                  height: Get.height*.0005,
                  color: ColorRes.textHintColor,
                ),
                SizedBox(height: Get.height*.01,),


                //bank details
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Get.to(() => const BankDetailsScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringRes.bank,style: appTextStyle(textColor: ColorRes.textHintColor),),
                          Icon(IconRes.inside,color: ColorRes.textHintColor,size: Get.width*.05,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.015,),
                Container(
                  margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                  height: Get.height*.0005,
                  color: ColorRes.textHintColor,
                ),
                SizedBox(height: Get.height*.01,),


                //groups
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Get.to(() => const GroupScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringRes.groups,style: appTextStyle(textColor: ColorRes.textHintColor),),
                          Icon(IconRes.inside,color: ColorRes.textHintColor,size: Get.width*.05,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.015,),
                Container(
                  margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                  height: Get.height*.0005,
                  color: ColorRes.textHintColor,
                ),
                SizedBox(height: Get.height*.01,),



                //send feedback
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){},
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringRes.feedback,style: appTextStyle(textColor: ColorRes.textHintColor),),
                          Icon(IconRes.inside,color: ColorRes.textHintColor,size: Get.width*.05,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.015,),
                Container(
                  margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                  height: Get.height*.0005,
                  color: ColorRes.textHintColor,
                ),
                SizedBox(height: Get.height*.01,),



                //help
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){},
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringRes.help,style: appTextStyle(textColor: ColorRes.textHintColor),),
                          Icon(IconRes.inside,color: ColorRes.textHintColor,size: Get.width*.05,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.015,),
                Container(
                  margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                  height: Get.height*.0005,
                  color: ColorRes.textHintColor,
                ),
                SizedBox(height: Get.height*.01,),


                //rate us
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){},
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringRes.rateus,style: appTextStyle(textColor: ColorRes.textHintColor),),
                          Icon(IconRes.inside,color: ColorRes.textHintColor,size: Get.width*.05,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.065,),


                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){

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
                        child: Text(StringRes.logout,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                      ),
                    ),
                  ),
                ),


              ],
            ),


            Positioned(
              left: Get.width*.35,
              top: Get.height*.15,
              child: GestureDetector(
                onTap: (){
                  Get.to(() => const ProfileScreen());
                },
                child: Container(
                  width: Get.width*.30,
                  height: Get.width*.30,
                  decoration: BoxDecoration(
                    color: ColorRes.textHintColor,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                  ),
                  child: model.result != null ? ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)), child: Image.memory(model.result!,fit: BoxFit.cover,),):Image.asset('images/user.png',fit: BoxFit.cover,),
                ),
              ),
            ),

          ],
        ),
      );
    });
  }
}
