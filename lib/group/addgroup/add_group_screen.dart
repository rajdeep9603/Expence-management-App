import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/group/addgroup/add_group_screen_model.dart';
import 'package:personal_expenses/group/groupmember/add_group_member_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class AddGroupScreen extends StatelessWidget {
  const AddGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddGroupScreenModel>.reactive(viewModelBuilder: () => AddGroupScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: model.isBusy
            ?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()),
                ],
            )
            :
        SingleChildScrollView(
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

              SizedBox(height: Get.height*.02,),

              Container(
                width: Get.width*.90,
                height: Get.height*.45,
                padding: EdgeInsets.all(Get.width*.02),
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                ),
                child: Column(
                  children: [

                    SizedBox(height: Get.height*.01,),

                    //photo & group name
                    Row(
                      children: [

                        Stack(
                          children: [

                            Container(
                              width: Get.width*.25,
                              height: Get.height*.12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                image: model.result != null ? DecorationImage(
                                  image: FileImage(model.result!),
                                  fit: BoxFit.cover,
                                ) : const DecorationImage(image: AssetImage("images/groupimg.jpg"),fit: BoxFit.cover),
                              ),
                            ),
                            
                            Positioned(
                              top: Get.width*.19,left: Get.width*.19,
                              width: Get.width*.06,
                              height: Get.width*.06,
                              child: GestureDetector(
                                onTap: (){
                                  model.pickFile();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(Get.width*.01),
                                    decoration: BoxDecoration(
                                      color: ColorRes.headingColor,
                                      borderRadius: BorderRadius.only(bottomRight :Radius.circular(Get.width*.05),topLeft: Radius.circular(Get.width*.02)),
                                    ),
                                    child: SvgPicture.asset('images/edit.svg',color: ColorRes.white,)),
                              ),
                            ),
                            
                          ],
                        ),


                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(StringRes.groupName,style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),

                                TextField(
                                  focusNode: model.groupNameFocusNode,
                                  controller: model.groupNameController,
                                  decoration: const InputDecoration(
                                    
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: Get.height*.015,),

                    //type
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: Get.width*.05,top: Get.width*.02),
                        child: Text(StringRes.type,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 17.0,fontWeight: FontWeight.w500),))),

                    SizedBox(height: Get.height*.01,),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [

                          //trip
                          GestureDetector(
                            onTap: (){
                              model.type = 1;
                              model.unfocusall();
                              model.notifyListeners();
                            },
                            child: Container(
                              width: Get.width*.22,
                              height: Get.height*.04,
                              decoration: BoxDecoration(
                                color: model.type == 1 ? null : ColorRes.background,
                                gradient: model.type == 1 ? gredient() : null,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  SvgPicture.asset('images/tripicon.svg',color: model.type == 1 ? ColorRes.white : ColorRes.headingColor,width: Get.width*.03,height: Get.width*.03,),

                                  SizedBox(width: Get.width*.01,),

                                  Text(StringRes.trip,style: appTextStyle(textColor: model.type == 1 ? ColorRes.white : ColorRes.headingColor,fontSize: 14.0),),

                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: Get.width*.03,),

                          //home
                          GestureDetector(
                            onTap: (){
                              model.type = 2;
                              model.unfocusall();
                              model.notifyListeners();
                            },
                            child: Container(
                              width: Get.width*.22,
                              height: Get.height*.04,
                              decoration: BoxDecoration(
                                color: model.type == 2 ? ColorRes.headingColor : ColorRes.background,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  SvgPicture.asset('images/homeicon.svg',color: model.type == 2 ? ColorRes.white : ColorRes.headingColor,width: Get.width*.03,height: Get.width*.03,),

                                  SizedBox(width: Get.width*.01,),

                                  Text(StringRes.home,style: appTextStyle(textColor: model.type == 2 ? ColorRes.white : ColorRes.headingColor,fontSize: 14.0),),

                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: Get.width*.03,),

                          //couple
                          GestureDetector(
                            onTap: (){
                              model.type = 3;
                              model.unfocusall();
                              model.notifyListeners();
                            },
                            child: Container(
                              width: Get.width*.22,
                              height: Get.height*.04,
                              decoration: BoxDecoration(
                                color: model.type == 3 ? ColorRes.headingColor : ColorRes.background,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  SvgPicture.asset('images/hearticon.svg',color: model.type == 3 ? ColorRes.white : ColorRes.headingColor,width: Get.width*.03,height: Get.width*.03,),

                                  SizedBox(width: Get.width*.01,),

                                  Text(StringRes.couple,style: appTextStyle(textColor: model.type == 3 ? ColorRes.white : ColorRes.headingColor,fontSize: 14.0),),

                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: Get.width*.03,),

                          //other
                          GestureDetector(
                            onTap: (){
                              model.type = 4;
                              model.unfocusall();
                              model.notifyListeners();
                            },
                            child: Container(
                              width: Get.width*.22,
                              height: Get.height*.04,
                              decoration: BoxDecoration(
                                color: model.type == 4 ? ColorRes.headingColor : ColorRes.background,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  SvgPicture.asset('images/othericon.svg',color: model.type == 4 ? ColorRes.white : ColorRes.headingColor,width: Get.width*.03,height: Get.width*.03,),

                                  SizedBox(width: Get.width*.01,),

                                  Text(StringRes.other,style: appTextStyle(textColor: model.type == 4 ? ColorRes.white : ColorRes.headingColor,fontSize: 14.0),),

                                ],
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),

                    SizedBox(height: Get.height*.02,),


                    GestureDetector(
                      onTap: (){
                        model.bpickFile();
                        print('add member');
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.02),
                          width: Get.width,
                          height: Get.height*.06,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: ColorRes.headingColor,
                            strokeWidth: 1,
                            radius: Radius.circular(Get.width*.02),
                            child: Center(
                              child: Align(alignment: Alignment.center,child: Text(model.bresult != null ? 'Photo selected successfully' : 'Select your cover photo',style: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 14.0),)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: Get.height*.01,),

                    //group member
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: Get.width*.05,top: Get.width*.02),
                            child: Text(StringRes.groupMember,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 17.0,fontWeight: FontWeight.w500),))),


                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: Get.width*.05,top: Get.width*.02,right: Get.width*.02),
                            child: Text(StringRes.groupDis,style: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 10.0),))),

                  ],
                ),
              ),

              SizedBox(height: Get.height*.02,),

              GestureDetector(
                onTap: (){
                  model.unfocusall();
                  model.notifyListeners();

                  model.next();
                },
                child: Container(
                  width: Get.width*.85,
                  height: Get.height*.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                    gradient: gredient(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(StringRes.createGroup,style: appTextStyle(textColor: ColorRes.white),),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
