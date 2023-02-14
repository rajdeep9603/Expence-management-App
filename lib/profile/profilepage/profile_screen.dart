import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/bank.dart';
import 'package:personal_expenses/database/model/profile.dart';
import 'package:personal_expenses/profile/profilepage/profile_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileScreenModel>.reactive(
      viewModelBuilder: () => ProfileScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: DatabaseHelper.internal().profiles(),
            builder: (BuildContext context,AsyncSnapshot<List<ProfileTable>> snapshot){
              if(snapshot.hasData){

                int l = snapshot.data!.length;

                if(l>0){

                  if(model.nameController.text.isEmpty){
                    model.nameController = TextEditingController(text: snapshot.data!.first.uname);
                  }

                  if(model.mailController.text.isEmpty){
                    model.mailController = TextEditingController(text: snapshot.data!.first.mail);
                  }

                  if(model.numberController.text.isEmpty){
                    model.numberController = TextEditingController(text: snapshot.data!.first.mobile.toString());
                  }

                  if(model.addController.text.isEmpty){
                    model.addController = TextEditingController(text: snapshot.data!.first.address);
                  }

                  if(model.birthController.text.isEmpty){
                    model.birthController = TextEditingController(text: snapshot.data!.first.birthdate);
                  }

                  if(model.result == null){
                    model.onlineimg = snapshot.data!.first.uimage;
                  }


                  print(model.nameController.text);
                  print(model.mailController.text);
                  print(model.numberController.text);
                  print(model.addController.text);

                  if(model.male == false && model.female == false){
                    if(snapshot.data!.first.gender == 1){
                      model.male = true;
                    }else{
                      model.female = false;
                    }
                  }



                  return Stack(
                    children: [
                      Column(
                        children: [

                          //appbar
                          Container(
                            width: Get.width,
                            height: Get.height*.22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(Get.width*.06),bottomLeft: Radius.circular(Get.width*.06)),
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

                          Align(
                              alignment: Alignment.center,
                              child: Text(snapshot.data!.first.uname != null ? snapshot.data!.first.uname! :StringRes.profileUserName,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 25.0,fontWeight: FontWeight.w500),)),

                          SizedBox(height: Get.height*.05,),


                          Column(
                            children: [
                              //name
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  style: appTextStyle(),
                                  controller: model.nameController,
                                  focusNode: model.nameFocusnode,
                                  decoration: InputDecoration(
                                    hintText: StringRes.name,
                                    labelText: StringRes.name,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),


                              //mail
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  style: appTextStyle(),
                                  controller: model.mailController,
                                  focusNode: model.mailFocusnode,
                                  decoration: InputDecoration(
                                    hintText: StringRes.mail,
                                    labelText: StringRes.mail,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),


                              //mobile
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  controller: model.numberController,
                                  focusNode: model.numberFocusnode,
                                  maxLength: 10,
                                  style: appTextStyle(textColor: ColorRes.filledText,fontWeight: FontWeight.w500),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: StringRes.mobile,
                                    counterText: "",
                                    labelText: StringRes.mobile,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),


                              //address
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  controller: model.addController,
                                  focusNode: model.addFocusnode,
                                  style: appTextStyle(),
                                  decoration: InputDecoration(
                                    hintText: StringRes.address,
                                    labelText: StringRes.address,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),

                              //date of birth
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  onTap: (){
                                    model.birthController.clear();
                                    model.birthFocusnode.unfocus();
                                    model.birthDayAlready(context,snapshot.data!.first.birthdate);
                                  },
                                  controller: model.birthController,
                                  focusNode: model.birthFocusnode,
                                  style: appTextStyle(),
                                  decoration: InputDecoration(
                                    hintText: StringRes.dob,
                                    labelText: StringRes.dob,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),

                              SizedBox(height: Get.height*.03,),

                              //male or female
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  //male
                                  GestureDetector(
                                    onTap: (){
                                      if(model.male == false){
                                        model.male = true;
                                        model.female = false;
                                        model.notifyListeners();
                                      }else{
                                        model.male = false;
                                        model.notifyListeners();
                                      }
                                    },
                                    child: Container(
                                      width: Get.width*.22,
                                      height: Get.height*.10,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ColorRes.headingColor),
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                                        color: model.male == false ? null :ColorRes.headingColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          SvgPicture.asset('images/male.svg',color: model.male == false ? ColorRes.headingColor : ColorRes.white,width: Get.width*.05,),

                                          SizedBox(height: Get.width*.03,),

                                          Text(StringRes.male,style: appTextStyle(textColor: model.male == false ? ColorRes.headingColor : ColorRes.white),),
                                        ],
                                      ),
                                    ),
                                  ),


                                  //female
                                  GestureDetector(
                                    onTap: (){
                                      if(model.female == false){
                                        model.female = true;
                                        model.male = false;
                                        model.notifyListeners();
                                      }else{
                                        model.female = false;
                                        model.notifyListeners();
                                      }
                                    },
                                    child: Container(
                                      width: Get.width*.22,
                                      height: Get.height*.10,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ColorRes.headingColor),
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                                        color: model.female == false ? null :ColorRes.headingColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          SvgPicture.asset('images/female.svg',color: model.female == false ? ColorRes.headingColor : ColorRes.white,width: Get.width*.05,),

                                          SizedBox(height: Get.width*.03,),

                                          Text(StringRes.female,style: appTextStyle(textColor: model.female == false ? ColorRes.headingColor : ColorRes.white),),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),

                              SizedBox(height: Get.height*.05,),

                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: (){
                                    model.submitUpdate(snapshot.data!.first.uid);
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
                                      child: Text(StringRes.save,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: Get.height*.02,),
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
                          child: GestureDetector(
                            onTap: (){
                              model.pickFile();
                            },
                            child: Stack(
                              children: [

                                model.result != null ?
                                ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                    child: Image.file(model.result!,width: Get.width*.3,height: Get.height*.3,fit: BoxFit.fitWidth,))
                                    :
                                model.onlineimg != null ?
                                ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                    child: Image.memory(model.onlineimg!,width: Get.width*.3,height: Get.height*.3,fit: BoxFit.fitWidth,))
                                    :
                                Image.asset('images/user.png',fit: BoxFit.cover,),
                                GestureDetector(
                                  onTap: (){
                                    model.pickFile();
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: Get.width*.055,
                                      height: Get.width*.055,
                                      decoration: BoxDecoration(
                                        color: ColorRes.white,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(Get.width*.05),bottomLeft: Radius.circular(Get.width*.01),
                                        ),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(Get.width*.015),
                                        child: SvgPicture.asset(
                                          'images/edit.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }else{
                  return Stack(
                    children: [
                      Column(
                        children: [

                          //appbar
                          Container(
                            width: Get.width,
                            height: Get.height*.22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(Get.width*.06),bottomLeft: Radius.circular(Get.width*.06)),
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

                          Align(
                              alignment: Alignment.center,
                              child: Text(StringRes.profileUserName,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 25.0,fontWeight: FontWeight.w500),)),

                          SizedBox(height: Get.height*.05,),


                          Column(
                            children: [
                              //name
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  style: appTextStyle(),
                                  controller: model.nameController,
                                  focusNode: model.nameFocusnode,
                                  decoration: InputDecoration(
                                    hintText: StringRes.name,
                                    labelText: StringRes.name,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),


                              //mail
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  style: appTextStyle(),
                                  controller: model.mailController,
                                  focusNode: model.mailFocusnode,
                                  decoration: InputDecoration(
                                    hintText: StringRes.mail,
                                    labelText: StringRes.mail,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),


                              //mobile
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  controller: model.numberController,
                                  focusNode: model.numberFocusnode,
                                  maxLength: 10,
                                  style: appTextStyle(textColor: ColorRes.filledText,fontWeight: FontWeight.w500),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: StringRes.mobile,
                                    counterText: "",
                                    labelText: StringRes.mobile,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),


                              //address
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  controller: model.addController,
                                  focusNode: model.addFocusnode,
                                  style: appTextStyle(),
                                  decoration: InputDecoration(
                                    hintText: StringRes.address,
                                    labelText: StringRes.address,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),


                              //date of birth
                              Container(
                                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                child: TextField(
                                  onTap: (){
                                    model.birthController.clear();
                                    model.birthFocusnode.unfocus();
                                    model.birthDay(context);
                                  },
                                  controller: model.birthController,
                                  focusNode: model.birthFocusnode,
                                  style: appTextStyle(),
                                  decoration: InputDecoration(
                                    hintText: StringRes.dob,
                                    labelText: StringRes.dob,
                                    labelStyle: appTextStyle(),
                                    hintStyle: appTextStyle(),
                                  ),
                                ),
                              ),

                              SizedBox(height: Get.height*.03,),

                              //male or female
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  //male
                                  GestureDetector(
                                    onTap: (){
                                      if(model.male == false){
                                        model.male = true;
                                        model.female = false;
                                        model.notifyListeners();
                                      }else{
                                        model.male = false;
                                        model.notifyListeners();
                                      }
                                    },
                                    child: Container(
                                      width: Get.width*.22,
                                      height: Get.height*.10,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ColorRes.headingColor),
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                                        color: model.male == false ? null :ColorRes.headingColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          SvgPicture.asset('images/male.svg',color: model.male == false ? ColorRes.headingColor : ColorRes.white,width: Get.width*.05,),

                                          SizedBox(height: Get.width*.03,),

                                          Text(StringRes.male,style: appTextStyle(textColor: model.male == false ? ColorRes.headingColor : ColorRes.white),),
                                        ],
                                      ),
                                    ),
                                  ),


                                  //female
                                  GestureDetector(
                                    onTap: (){
                                      if(model.female == false){
                                        model.female = true;
                                        model.male = false;
                                        model.notifyListeners();
                                      }else{
                                        model.female = false;
                                        model.notifyListeners();
                                      }
                                    },
                                    child: Container(
                                      width: Get.width*.22,
                                      height: Get.height*.10,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ColorRes.headingColor),
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                                        color: model.female == false ? null :ColorRes.headingColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          SvgPicture.asset('images/female.svg',color: model.female == false ? ColorRes.headingColor : ColorRes.white,width: Get.width*.05,),

                                          SizedBox(height: Get.width*.03,),

                                          Text(StringRes.female,style: appTextStyle(textColor: model.female == false ? ColorRes.headingColor : ColorRes.white),),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),


                              SizedBox(height: Get.height*.05,),


                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: (){
                                    model.submit();
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
                                      child: Text(StringRes.save,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),


                          SizedBox(height: Get.height*.02,),

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
                          child: GestureDetector(
                            onTap: (){
                              model.pickFile();
                            },
                            child: Stack(
                              children: [

                                model.result != null ?
                                ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                    child: Image.file(model.result!,width: Get.width*.3,height: Get.height*.3,fit: BoxFit.fitWidth,))
                                    :
                                model.onlineimg != null ?
                                ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                    child: Image.memory(model.onlineimg!,width: Get.width*.3,height: Get.height*.3,fit: BoxFit.fitWidth,))
                                    :
                                Image.asset('images/user.png',fit: BoxFit.cover,),

                                GestureDetector(
                                  onTap: (){
                                    model.pickFile();
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: Get.width*.055,
                                      height: Get.width*.055,
                                      decoration: BoxDecoration(
                                        color: ColorRes.white,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(Get.width*.05),bottomLeft: Radius.circular(Get.width*.01),
                                        ),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(Get.width*.015),
                                        child: SvgPicture.asset(
                                          'images/edit.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  );
                }
              }else{
                return Stack(
                  children: [
                    Column(
                      children: [

                        //appbar
                        Container(
                          width: Get.width,
                          height: Get.height*.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(Get.width*.06),bottomLeft: Radius.circular(Get.width*.06)),
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

                        Align(
                            alignment: Alignment.center,
                            child: Text(StringRes.profileUserName,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 25.0,fontWeight: FontWeight.w500),)),

                        SizedBox(height: Get.height*.05,),


                        Column(
                          children: [
                            //name
                            Container(
                              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                              child: TextField(
                                style: appTextStyle(),
                                controller: model.nameController,
                                focusNode: model.nameFocusnode,
                                decoration: InputDecoration(
                                  hintText: StringRes.name,
                                  labelText: StringRes.name,
                                  labelStyle: appTextStyle(),
                                  hintStyle: appTextStyle(),
                                ),
                              ),
                            ),


                            //mail
                            Container(
                              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                              child: TextField(
                                style: appTextStyle(),
                                controller: model.mailController,
                                focusNode: model.mailFocusnode,
                                decoration: InputDecoration(
                                  hintText: StringRes.mail,
                                  labelText: StringRes.mail,
                                  labelStyle: appTextStyle(),
                                  hintStyle: appTextStyle(),
                                ),
                              ),
                            ),


                            //mobile
                            Container(
                              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                              child: TextField(
                                controller: model.numberController,
                                focusNode: model.numberFocusnode,
                                maxLength: 10,
                                style: appTextStyle(textColor: ColorRes.filledText,fontWeight: FontWeight.w500),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: StringRes.mobile,
                                  counterText: "",
                                  labelText: StringRes.mobile,
                                  labelStyle: appTextStyle(),
                                  hintStyle: appTextStyle(),
                                ),
                              ),
                            ),


                            //address
                            Container(
                              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                              child: TextField(
                                controller: model.addController,
                                focusNode: model.addFocusnode,
                                style: appTextStyle(),
                                decoration: InputDecoration(
                                  hintText: StringRes.address,
                                  labelText: StringRes.address,
                                  labelStyle: appTextStyle(),
                                  hintStyle: appTextStyle(),
                                ),
                              ),
                            ),


                            //date of birth
                            Container(
                              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                              child: TextField(
                                onTap: (){
                                  model.birthController.clear();
                                  model.birthFocusnode.unfocus();
                                  model.birthDay(context);
                                },
                                controller: model.birthController,
                                focusNode: model.birthFocusnode,
                                style: appTextStyle(),
                                decoration: InputDecoration(
                                  hintText: StringRes.dob,
                                  labelText: StringRes.dob,
                                  labelStyle: appTextStyle(),
                                  hintStyle: appTextStyle(),
                                ),
                              ),
                            ),

                            SizedBox(height: Get.height*.03,),

                            //male or female
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                //male
                                GestureDetector(
                                  onTap: (){
                                    if(model.male == false){
                                      model.male = true;
                                      model.female = false;
                                      model.notifyListeners();
                                    }else{
                                      model.male = false;
                                      model.notifyListeners();
                                    }
                                  },
                                  child: Container(
                                    width: Get.width*.22,
                                    height: Get.height*.10,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: ColorRes.headingColor),
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                                      color: model.male == false ? null :ColorRes.headingColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        SvgPicture.asset('images/male.svg',color: model.male == false ? ColorRes.headingColor : ColorRes.white,width: Get.width*.05,),

                                        SizedBox(height: Get.width*.03,),

                                        Text(StringRes.male,style: appTextStyle(textColor: model.male == false ? ColorRes.headingColor : ColorRes.white),),
                                      ],
                                    ),
                                  ),
                                ),


                                //female
                                GestureDetector(
                                  onTap: (){
                                    if(model.female == false){
                                      model.female = true;
                                      model.male = false;
                                      model.notifyListeners();
                                    }else{
                                      model.female = false;
                                      model.notifyListeners();
                                    }
                                  },
                                  child: Container(
                                    width: Get.width*.22,
                                    height: Get.height*.10,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: ColorRes.headingColor),
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                                      color: model.female == false ? null :ColorRes.headingColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        SvgPicture.asset('images/female.svg',color: model.female == false ? ColorRes.headingColor : ColorRes.white,width: Get.width*.05,),

                                        SizedBox(height: Get.width*.03,),

                                        Text(StringRes.female,style: appTextStyle(textColor: model.female == false ? ColorRes.headingColor : ColorRes.white),),
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),


                            SizedBox(height: Get.height*.05,),


                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: (){
                                  model.submit();
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
                                    child: Text(StringRes.save,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),


                        SizedBox(height: Get.height*.02,),

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
                        child: GestureDetector(
                          onTap: (){
                            model.pickFile();
                          },
                          child: Stack(
                            children: [

                              model.result != null ?
                              ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                  child: Image.file(model.result!,width: Get.width*.3,height: Get.height*.3,fit: BoxFit.fitWidth,))
                                  :
                              model.onlineimg != null ?
                              ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                  child: Image.memory(model.onlineimg!,width: Get.width*.3,height: Get.height*.3,fit: BoxFit.fitWidth,))
                                  :
                              Image.asset('images/user.png',fit: BoxFit.cover,),

                              GestureDetector(
                                onTap: (){
                                  model.pickFile();
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: Get.width*.055,
                                    height: Get.width*.055,
                                    decoration: BoxDecoration(
                                      color: ColorRes.white,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(Get.width*.05),bottomLeft: Radius.circular(Get.width*.01),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(Get.width*.015),
                                      child: SvgPicture.asset(
                                        'images/edit.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                );
              }
            },
          ),
        ),
      );
    });
  }
}
