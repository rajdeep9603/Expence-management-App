import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/group/groupsetting/editgroup/edit_group_screen.dart';
import 'package:personal_expenses/group/groupsetting/group_setting_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class GroupSettingScreen extends StatelessWidget {

  int? gid;

  GroupSettingScreen({required this.gid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupSettingScreenModel>.reactive(
      onModelReady: (model){
        model.init(gid!);
      },
      viewModelBuilder: () => GroupSettingScreenModel(), builder: (context,model,child){
      return WillPopScope(
        onWillPop: ()async{
          Get.back();
          return true;
        },
        child: Scaffold(
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
              :Column(
            children: [


              //appbar
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
                    child: const Icon(IconRes.back,color: ColorRes.headingColor,),
                    decoration: const BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),

              //photo and edit
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  Container(
                    width: Get.width*.25,
                    height: Get.width*.25,
                    margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.07),
                    decoration: BoxDecoration(
                      color: ColorRes.headingColor,
                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                      image: DecorationImage(
                        image: NetworkImage(model.g.data!.gdList!.first.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  SizedBox(width: Get.width*.05,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: Get.height*.05,),

                      Text(model.g.data!.gdList!.first.name!.toUpperCase(),style: appTextStyle(fontWeight: FontWeight.w400,textColor: ColorRes.headingColor),),

                      SizedBox(height: Get.height*.01,),

                      Text(model.typename!,style: appTextStyle(fontSize: 11.0,textColor: ColorRes.textHintColor),),

                    ],
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => EditGroupScreen(g: model.g,));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: Get.width*.1,
                            height: Get.width*.1,
                            margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.04)),
                            ),
                            child: SvgPicture.asset('images/edit.svg',color: ColorRes.headingColor,fit: BoxFit.scaleDown,),
                          ),
                        ],
                      ),
                    ),
                  ),



                ],
              ),

              SizedBox(height: Get.height*.05,),

              //group member
              Container(
                height: Get.height*.07,
                child: Row(
                  children: [

                    GestureDetector(
                      onTap: (){
                        model.fetchContacts();
                        print('add member');
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: Get.width*.05,right: Get.width*.02),
                          width: Get.width*.14,
                          height: Get.height*.07,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: ColorRes.headingColor,
                            strokeWidth: 1,
                            radius: Radius.circular(Get.width*.02),
                            child: const Center(
                              child: Icon(IconRes.add,color: ColorRes.headingColor,),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.g.data!.ecList!.length,
                        itemBuilder: (BuildContext context, int index){

                          return Container(
                            margin: EdgeInsets.only(left: Get.width*.01,right: Get.width*.02),
                            width: Get.width*.14,
                            height: Get.height*.07,
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.width*.07,
                                    height: Get.width*.07,
                                    decoration: BoxDecoration(
                                      color: ColorRes.headingColor,
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.07))
                                    ),
                                    child: Center(
                                      child: Text(
                                        model.g.data!.ecList![index].name![0].toUpperCase(),
                                        style: appTextStyle(textColor: ColorRes.white,fontWeight: FontWeight.w500,fontSize: 17.0),
                                      )
                                    )
                                  ),
                                  SizedBox(height: Get.width*.01,),

                                  Container(
                                    //margin: EdgeInsets.only(left: Get.width*.01,right: Get.width*.01),
                                    child: Text(
                                      model.g.data!.ecList![index].name.toString(),
                                      maxLines: 1,
                                      style: appTextStyle(fontSize: 8.0),
                                    )
                                  ),

                                ],
                              ),
                            ),
                          );

                        })
                    ),


                  ],
                ),
              ),

              Expanded(child: Container()),

              /*GestureDetector(
                onTap: (){
                  print('leave group');
                },
                child: Container(
                  width: Get.width*.85,
                  height: Get.height*.075,
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                  ),
                  child: Row(
                    children: [

                      Container(
                        width: Get.width*.1,
                        height: Get.height*.05,
                        margin: EdgeInsets.only(left: Get.width*.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                          gradient: gredient(),
                        ),
                        child: SvgPicture.asset('images/leaveicon.svg',fit: BoxFit.scaleDown,),
                      ),

                      SizedBox(width: Get.width*.05,),

                      Text('Leave Group',style: appTextStyle(textColor: ColorRes.headingColor),),

                    ],
                  ),
                ),
              ),

              SizedBox(height: Get.height*.015,),*/

              GestureDetector(
                onTap: (){
                  model.delete();
                  print('Delete group');
                },
                child: Container(
                  width: Get.width*.85,
                  height: Get.height*.075,
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                  ),
                  child: Row(
                    children: [

                      Container(
                        width: Get.width*.1,
                        height: Get.height*.05,
                        margin: EdgeInsets.only(left: Get.width*.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                          gradient: gredient(),
                        ),
                        child: SvgPicture.asset('images/deleteicon.svg',fit: BoxFit.scaleDown,),
                      ),

                      SizedBox(width: Get.width*.05,),

                      Text('Delete Group',style: appTextStyle(textColor: ColorRes.headingColor),),

                    ],
                  ),
                ),
              ),

              SizedBox(height: Get.height*.05,),

            ],
          ),
        ),
      );
    });
  }
}
