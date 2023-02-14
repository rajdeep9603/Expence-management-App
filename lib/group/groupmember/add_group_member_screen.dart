import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/balance/balance_screen.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/contact.dart';
import 'package:personal_expenses/database/model/expense.dart';
import 'package:personal_expenses/group/addgroupexpanse/add_group_expense_screen.dart';
import 'package:personal_expenses/group/addgroupexpanse/whopaid/who_paid_screen.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/group/groupmember/add_group_member_screen_model.dart';
import 'package:personal_expenses/group/groupsetting/group_setting_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/otp/otp_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import "package:collection/collection.dart";

class AddGroupMemberScreen extends StatelessWidget {

  int? id;


  AddGroupMemberScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddGroupMemberScreenModel>.reactive(
      onModelReady: (model){
        model.init(id!);
      },
      viewModelBuilder: ()=>AddGroupMemberScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: model.isBusy ? Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,children: [ Align(alignment: Alignment.center, child: CircularProgressIndicator(),)],):Stack(
          children: [

            Column(
              children: [

                //appbar
                Container(
                  width: Get.width,
                  height: Get.height*.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(Get.width*.08),bottomLeft: Radius.circular(Get.width*.08)),
                    image: model.result != null ? DecorationImage(
                      image: FileImage(model.result!),
                      fit: BoxFit.cover,
                    ) : model.g.data!.gdList!.first.banner != null ? DecorationImage(image: NetworkImage(model.g.data!.gdList!.first.banner!),fit: BoxFit.cover):const DecorationImage(image: AssetImage("images/coverimg.jpg"),fit: BoxFit.cover),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        offset: Offset(1.0, 1.0),
                        blurRadius: 25.0,
                        spreadRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          GestureDetector(
                            onTap: (){
                             Get.offAll(() => const GroupScreen());
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

                          GestureDetector(
                            onTap: (){

                              Get.to(() => GroupSettingScreen( gid: id,));


                            },
                            child: Container(
                              width: Get.width*.125,
                              height: Get.width*.125,
                              margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                              child: SvgPicture.asset('images/settingicon.svg',color: ColorRes.headingColor,fit: BoxFit.scaleDown,),
                              decoration: const BoxDecoration(
                                color: ColorRes.white,
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                              ),
                            ),
                          ),

                        ],
                      ),

                      /*Positioned(
                        right: model.result != null ? Get.width*.0001:Get.width*.0001,  //  or condition get.width*.001
                        bottom: model.result != null ? Get.width*.0001:Get.width*.0001, //  or condition get.width*.006
                        child: GestureDetector(
                          onTap: (){
                            model.pickFile();
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: Get.width*.1,
                              height: Get.width*.08,
                              decoration: BoxDecoration(
                                color: ColorRes.white,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(Get.width*.065),topLeft: Radius.circular(Get.width*.02)),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(Get.width*.015),
                                child: SvgPicture.asset(
                                  'images/edit.svg',fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),*/

                    ],


                  ),
                ),

                //SizedBox(height: Get.height*.06,),

                /*Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: Get.width*.12),
                    child: Text(model.g.data!.gdList!.first.name != null ? model.g.data!.gdList!.first.name!.toUpperCase() :'Ravi',style: appTextStyle(fontSize: 20.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),)
                  )
                ),*/

                SizedBox(height: Get.height*.13,),

                //add new member button
                Container(
                  height: Get.height*.06,
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
                            height: Get.height*.06,
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


                     /* model.selectedcontact.isNotEmpty?
                      Expanded(
                        child: FutureBuilder(
                          future: DatabaseHelper.internal().contacts(),
                          builder: (BuildContext context,AsyncSnapshot<List<ContactTable>> snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data!.length > 0){

                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext context, int index){

                                      return Container(
                                        margin: EdgeInsets.only(left: Get.width*.01,right: Get.width*.02),
                                        width: Get.width*.14,
                                        height: Get.height*.06,
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
                                                  child: Center(child: Text(snapshot.data![index].contactname![0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontWeight: FontWeight.w500,fontSize: 20.0),))),

                                              SizedBox(height: Get.width*.01,),

                                              Container(
                                                //margin: EdgeInsets.only(left: Get.width*.01,right: Get.width*.01),
                                                  child: Text(snapshot.data![index].contactname.toString(),maxLines: 1,style: appTextStyle(fontSize: 8.0),)),

                                            ],
                                          ),
                                        ),
                                      );

                                    });

                              }else{
                                return Container();
                              }
                            }else{
                              return Container();
                            }
                          },
                        ),
                      ):Container(),*/

                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.g.data!.ecList!.length,
                          itemBuilder: (BuildContext context, int index){

                            return Container(
                              margin: EdgeInsets.only(left: Get.width*.01,right: Get.width*.02),
                              width: Get.width*.14,
                              height: Get.height*.06,
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

                      /*Expanded(
                        child: FutureBuilder(
                          future: DatabaseHelper.internal().contacts(),
                          builder: (BuildContext context,AsyncSnapshot<List<ContactTable>> snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data!.length > 0){

                                List d = [];

                                snapshot.data!.forEach((element) {
                                  if(element.gid == id){
                                    d.add(element);
                                  }
                                });



                              }else{
                                return Container();
                              }
                            }else{
                              return Container();
                            }
                          },
                        ),
                      ),*/

                    ],
                  ),
                ),


                //expenses
                /*Expanded(
                  child: FutureBuilder(
                    future: DatabaseHelper.internal().expenses(),
                    builder: (BuildContext context,AsyncSnapshot<List<ExpenseTable>> snapshot){
                      if(snapshot.hasData){

                        if(snapshot.data!.length > 0){

                          List<Map> data = [];
                          snapshot.data!.forEach((element) {
                            data.add(element.toMap());
                          });

                          var newMap = groupBy(data, (Map obj) => obj['date']);
                          var _listkeys = newMap.keys.toList();
                          var _listvalue = newMap.values.toList();

                          _listkeys.sort((a, b){
                            return DateTime.parse(b).compareTo(DateTime.parse(a));
                          });

                          return  ListView.builder(
                            itemCount: newMap.values.length,
                            itemBuilder: (context,index){
                              var newlist = [];
                              _listvalue.forEach((element) {
                                element.forEach((el) {
                                  if(el['date'] == _listkeys[index]){

                                    if(el['gid'] == id){
                                      newlist.add(el);
                                    }


                                  }
                                });
                              });

                              if(newlist.length > 0){
                                DateTime d = DateTime.parse(newlist.first['date']);
                                final now = DateTime.now();
                                final now1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                final now2 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 1));
                                String d2 = DateFormat.d().format(d);
                                String d3 = DateFormat.MMM().format(d);


                                return Column(
                                  children: [

                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(margin: EdgeInsets.only(left: Get.width*.05,bottom: Get.width*.01),child: Text(newlist.first['date'] == now1?'Today':newlist.first['date']== now2? 'Yesterday':'$d2 $d3',style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),))),

                                    Container(
                                      width: Get.width*.9,
                                      //height: Get.height*.1,
                                      padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                                      margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                                      decoration: BoxDecoration(
                                        color: ColorRes.white,
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                      ),
                                      child: Center(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: newlist.length,
                                          itemBuilder: (context, int i){
                                            if(newlist.length >1){
                                              if((i+1) == newlist.length){
                                                return Column(
                                                  children: [

                                                    SizedBox(height: Get.width*.03,),

                                                    Row(
                                                      children: [

                                                        Container(
                                                          width: Get.width*.1,
                                                          height: Get.height*.05,
                                                          margin: EdgeInsets.only(left: Get.width*.05),
                                                          decoration: BoxDecoration(
                                                            color: ColorRes.headingColor,
                                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                          ),
                                                          child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                                        ),

                                                        SizedBox(width: Get.width*.05,),

                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                              Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          margin: EdgeInsets.only(right: Get.width*.05),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text('\u{20B9} ${newlist[i]['price'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: newlist[i]['type'] == StringRes.expense ? Colors.red :Colors.green,fontWeight: FontWeight.w500),),

                                                              SizedBox(height: Get.height*.005,),
                                                              Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }else{
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [

                                                        Container(
                                                          width: Get.width*.1,
                                                          height: Get.height*.05,
                                                          margin: EdgeInsets.only(left: Get.width*.05),
                                                          decoration: BoxDecoration(
                                                            color: ColorRes.headingColor,
                                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                          ),
                                                          child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                                        ),

                                                        SizedBox(width: Get.width*.05,),

                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                              Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          margin: EdgeInsets.only(right: Get.width*.05),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text('\u{20B9} ${newlist[i]['price'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: newlist[i]['type'] == StringRes.expense ? Colors.red :Colors.green,fontWeight: FontWeight.w500),),

                                                              SizedBox(height: Get.height*.005,),
                                                              Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                    SizedBox(height: Get.width*.03,),
                                                    Divider(height: Get.width*.01,),
                                                  ],
                                                );
                                              }
                                            }else{
                                              return Row(
                                                children: [

                                                  Container(
                                                    width: Get.width*.1,
                                                    height: Get.height*.05,
                                                    margin: EdgeInsets.only(left: Get.width*.05),
                                                    decoration: BoxDecoration(
                                                      color: ColorRes.headingColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                    ),
                                                    child: Image.memory(newlist[i]['image'],fit: BoxFit.scaleDown,),
                                                  ),

                                                  SizedBox(width: Get.width*.05,),

                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                        Text(newlist[i]['dis'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.only(right: Get.width*.05),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text('\u{20B9} ${newlist[i]['price'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: newlist[i]['type'] == StringRes.expense ? Colors.red :Colors.green,fontWeight: FontWeight.w500),),

                                                        SizedBox(height: Get.height*.005,),
                                                        Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                      ],
                                                    ),
                                                  ),


                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),


                                  ],
                                );
                              }
                              else{
                                return Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Center(child: Text('No Transaction Found.',style: appTextStyle(textColor: ColorRes.textHintColor),)),
                                  ),
                                );
                              }


                            },
                          );


                        }else{
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Center(child: Text('No Transaction Found.',style: appTextStyle(textColor: ColorRes.textHintColor),)),
                            ),
                          );
                        }

                      }else{
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Center(child: Text('No Data Available.',style: appTextStyle(textColor: ColorRes.textHintColor),)),
                          ),
                        );
                      }
                    },
                  ),
                ),*/

                SizedBox(height: Get.height*.005,),

                //expenses
                /*Expanded(
                  child: ListView.builder(
                    itemCount: model.e.data!.eeList!.length,
                    itemBuilder: (BuildContext context, int i){

                      String c = model.e.data!.eeList![i].category!;

                      DateTime d = model.e.data!.eeList![i].date!;
                      final now = DateTime.now();
                      final now1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      final now2 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 1));
                      String d2 = DateFormat.d().format(d);
                      String d3 = DateFormat.MMM().format(d);


                      *//*List<Map> data = [];
                      model.e.data!.eeList!.forEach((element) {
                        data.add(element.toJson());
                      });

                      print('---------------data----------------------$data');

                      var newMap = groupBy(data, (Map obj) => obj['date']);
                      var _listkeys = newMap.keys.toList();
                      var _listvalue = newMap.values.toList();*//*

                      return SwipeActionCell(
                        key: ObjectKey(model.e.data!.eeList![i]),
                        backgroundColor: Colors.transparent,
                        firstActionWillCoverAllSpaceOnDeleting: true,
                        selectedForegroundColor: ColorRes.headingColor,
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                            onTap: (CompletionHandler handler) async {
                              await handler(false);

                            },
                            widthSpace: Get.width*.15,
                            color: Colors.transparent,
                            content: Container(
                              width: Get.width*.13,
                              height: Get.height*.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                gradient: gredient()
                              ),
                              child: SvgPicture.asset('images/balance.svg',fit: BoxFit.scaleDown,),
                            ),
                          ),
                          SwipeAction(
                            onTap: (CompletionHandler handler) async {
                              await handler(false);

                            },
                            widthSpace: Get.width*.15,
                            color: Colors.transparent,
                            content: Container(
                              width: Get.width*.13,
                              height: Get.height*.06,
                              padding: EdgeInsets.all(Get.width*.035),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                  gradient: gredient()
                              ),
                              child: Image.asset('images/splitxicon.png',color: ColorRes.white,),
                            ),
                          ),
                        ],
                        child: Container(
                          //width: Get.width*.9,
                          height: Get.height*.1,
                          //padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                          margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                          decoration: BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                          ),
                          child: Column(
                            children: [

                              SizedBox(height: Get.width * .03,),

                              Row(
                                children: [
                                  Container(
                                    width: Get.width * .1,
                                    height: Get.height * .05,
                                    margin: EdgeInsets.only(left: Get.width * .05),
                                    decoration: BoxDecoration(
                                      color: ColorRes.headingColor,
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width * .02)),
                                    ),
                                    child: Image.asset(c == StringRes.travel ? 'images/travelicon.png': c == StringRes.internet ? 'images/interneticon.png' : 'images/${c.toLowerCase()}.png', fit: BoxFit.scaleDown,),),
                                  SizedBox(width: Get.width * .05,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(model.e.data!.eeList![i].title.toString(), style: appTextStyle(fontSize: 21.0, textColor: ColorRes.headingColor, fontWeight: FontWeight.w500),),
                                        Text(model.e.data!.eeList![i].description.toString(), style: appTextStyle(fontSize: 12.0, textColor: ColorRes.textHintColor),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: Get.width * .05),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('\u{20B9} ${model.e.data!.eeList![i].amount!.toStringAsFixed(1)} /-', style: appTextStyle(fontSize: 21.0, textColor: Colors.red, fontWeight: FontWeight.w500),                                       ),
                                        SizedBox(
                                          height: Get.height * .005,
                                        ),
                                        Text('$d2 $d3', style: appTextStyle(fontSize: 14.0, textColor: ColorRes.textHintColor),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ),*/


                Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int i){

                        //String c = model.edisplay[i].category!;

                        List<Map> data = [];
                        model.edisplay.forEach((element) {
                          data.add(element.toJson());
                        });

                        var newlist = [];
                        var newMap = groupBy(data, (Map obj) => obj['date']);
                        var _listkeys = newMap.keys.toList();
                        var _listvalue = newMap.values.toList();

                        _listkeys.sort((a, b){
                          return DateTime.parse(b).compareTo(DateTime.parse(a));
                        });

                        print('---keys --------${_listkeys}');
                        print('---value --------${_listvalue}');
                        print('---map --------$newMap');

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: newMap.values.length,
                          itemBuilder: (context,index){
                            var newlist = [];
                            _listvalue.forEach((element) {
                              element.forEach((el) {
                                if(el['date'] == _listkeys[index]){
                                  newlist.add(el);
                                }
                              });
                            });

                            print('----inside-------------$newlist');

                            if(newlist.length > 0){
                              DateTime d = DateTime.parse(newlist.first['date']);
                              final now = DateTime.now();
                              final now1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                              final now2 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 1));
                              String d2 = DateFormat.d().format(d);
                              String d3 = DateFormat.MMM().format(d);


                              return Column(
                                children: [

                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(margin: EdgeInsets.only(left: Get.width*.05,bottom: Get.width*.01),child: Text(newlist.first['date'] == now1?'Today':newlist.first['date']== now2? 'Yesterday':'$d2 $d3',style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),))),

                                  Container(
                                    width: Get.width*.9,
                                    //height: Get.height*.1,
                                    padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                                    margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                                    decoration: BoxDecoration(
                                      color: ColorRes.white,
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                    ),
                                    child: Center(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: newlist.length,
                                        itemBuilder: (context, int i){

                                          String c = newlist[i]['category'];

                                          if(newlist.length >1){
                                            if((i+1) == newlist.length){
                                              return SwipeActionCell(
                                                key: ObjectKey(model.edisplay[i]),
                                                backgroundColor: Colors.transparent,
                                                firstActionWillCoverAllSpaceOnDeleting: true,
                                                selectedForegroundColor: ColorRes.headingColor,
                                                trailingActions: <SwipeAction>[
                                                  /*SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      Get.to(() => BalanceScreen(gid: id,eid: newlist[i]['id'], amount: newlist[i]['amount'],));

                                                    },
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                          gradient: gredient()
                                                      ),
                                                      child: SvgPicture.asset('images/balance.svg',fit: BoxFit.scaleDown,),
                                                    ),
                                                  ),*/
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      //Get.to(()=>WhoPaidScreen(gid: id, eid: newlist[i]['id'], amount: newlist[i]['amount']));
                                                      if(newlist[i]['isSettled'] == false){
                                                        model.whopaiddone(newlist[i]['id'],newlist[i]['amount']);
                                                      }else{
                                                        Get.snackbar(
                                                          StringRes.hoorey,
                                                          'Settlement is already done.',
                                                          snackPosition: SnackPosition.TOP,
                                                          backgroundColor: Colors.green,
                                                          borderRadius: 20,
                                                          margin: EdgeInsets.all(Get.width/20),
                                                          colorText: Colors.white,
                                                          duration: const Duration(seconds: 4),
                                                          isDismissible: true,
                                                          dismissDirection: DismissDirection.horizontal,
                                                          forwardAnimationCurve: Curves.easeOutBack,
                                                        );
                                                      }


                                                    },
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      padding: EdgeInsets.all(Get.width*.035),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                          gradient: gredient()
                                                      ),
                                                      child: Image.asset('images/splitxicon.png',color: ColorRes.white,),
                                                    ),
                                                  ),
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      //Get.to(() => BalanceScreen(gid: id,eid: newlist[i]['id'], amount: newlist[i]['amount'],));

                                                      model.delete(newlist[i]['id']);

                                                    },
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                          gradient: gredient()
                                                      ),
                                                      child: SvgPicture.asset('images/deleteicon.svg',fit: BoxFit.scaleDown,),
                                                    ),
                                                  ),
                                                ],
                                                child: Column(
                                                  children: [

                                                    SizedBox(height: Get.width*.03,),

                                                    Row(
                                                      children: [

                                                        Container(
                                                          width: Get.width*.1,
                                                          height: Get.height*.05,
                                                          margin: EdgeInsets.only(left: Get.width*.05),
                                                          decoration: BoxDecoration(
                                                            color: ColorRes.headingColor,
                                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                          ),
                                                          child: Image.asset(c==StringRes.travel?'images/travelicon.png':c==StringRes.internet?'images/interneticon.png':'images/${c.toLowerCase()}.png',fit: BoxFit.scaleDown,),
                                                        ),

                                                        SizedBox(width: Get.width*.05,),

                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                              Text(newlist[i]['description'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          margin: EdgeInsets.only(right: Get.width*.05),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text('\u{20B9} ${newlist[i]['amount'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor:  Colors.red ,fontWeight: FontWeight.w500),),

                                                              SizedBox(height: Get.height*.005,),
                                                              Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                            else{
                                              return SwipeActionCell(
                                                key: ObjectKey(model.edisplay[i]),
                                                backgroundColor: Colors.transparent,
                                                firstActionWillCoverAllSpaceOnDeleting: true,
                                                selectedForegroundColor: ColorRes.headingColor,
                                                trailingActions: <SwipeAction>[
                                                  /*SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      Get.to(() => BalanceScreen(gid: id,eid: newlist[i]['id'], amount: newlist[i]['amount'],));
                                                    },
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                          gradient: gredient()
                                                      ),
                                                      child: SvgPicture.asset('images/balance.svg',fit: BoxFit.scaleDown,),
                                                    ),
                                                  ),*/
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      if(newlist[i]['isSettled'] == false){
                                                        model.whopaiddone(newlist[i]['id'],newlist[i]['amount']);
                                                      }else{
                                                        Get.snackbar(
                                                          StringRes.hoorey,
                                                          'Settlement is already done.',
                                                          snackPosition: SnackPosition.TOP,
                                                          backgroundColor: Colors.green,
                                                          borderRadius: 20,
                                                          margin: EdgeInsets.all(Get.width/20),
                                                          colorText: Colors.white,
                                                          duration: const Duration(seconds: 4),
                                                          isDismissible: true,
                                                          dismissDirection: DismissDirection.horizontal,
                                                          forwardAnimationCurve: Curves.easeOutBack,
                                                        );
                                                      }
                                                      //model.whopaiddone(newlist[i]['id'],newlist[i]['amount']);

                                                    },
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      padding: EdgeInsets.all(Get.width*.035),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                          gradient: gredient()
                                                      ),
                                                      child: Image.asset('images/splitxicon.png',color: ColorRes.white,),
                                                    ),
                                                  ),
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      //Get.to(() => BalanceScreen(gid: id,eid: newlist[i]['id'], amount: newlist[i]['amount'],));
                                                      model.delete(newlist[i]['id']);
                                                    },
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                          gradient: gredient()
                                                      ),
                                                      child: SvgPicture.asset('images/deleteicon.svg',fit: BoxFit.scaleDown,),
                                                    ),
                                                  ),
                                                ],
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [

                                                        Container(
                                                          width: Get.width*.1,
                                                          height: Get.height*.05,
                                                          margin: EdgeInsets.only(left: Get.width*.05),
                                                          decoration: BoxDecoration(
                                                            color: ColorRes.headingColor,
                                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                          ),
                                                          child: Image.asset(c==StringRes.travel?'images/travelicon.png':c==StringRes.internet?'images/interneticon.png':'images/${c.toLowerCase()}.png',fit: BoxFit.scaleDown,),
                                                        ),

                                                        SizedBox(width: Get.width*.05,),

                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                              Text(newlist[i]['description'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          margin: EdgeInsets.only(right: Get.width*.05),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text('\u{20B9} ${newlist[i]['amount'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: Colors.red ,fontWeight: FontWeight.w500),),

                                                              SizedBox(height: Get.height*.005,),
                                                              Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                    SizedBox(height: Get.width*.03,),
                                                    Divider(height: Get.width*.01,),
                                                  ],
                                                ),
                                              );
                                            }
                                          }else{
                                            return SwipeActionCell(
                                              key: ObjectKey(model.edisplay[i]),
                                              backgroundColor: Colors.transparent,
                                              firstActionWillCoverAllSpaceOnDeleting: true,
                                              selectedForegroundColor: ColorRes.headingColor,
                                              trailingActions: <SwipeAction>[
                                                /*SwipeAction(
                                                  onTap: (CompletionHandler handler) async {
                                                    await handler(false);

                                                    Get.to(() => BalanceScreen(gid: id,eid: newlist[i]['id'], amount: newlist[i]['amount'],));

                                                  },
                                                  widthSpace: Get.width*.15,
                                                  color: Colors.transparent,
                                                  content: Container(
                                                    width: Get.width*.13,
                                                    height: Get.height*.06,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        gradient: gredient()
                                                    ),
                                                    child: SvgPicture.asset('images/balance.svg',fit: BoxFit.scaleDown,),
                                                  ),
                                                ),*/
                                                SwipeAction(
                                                  onTap: (CompletionHandler handler) async {
                                                    await handler(false);

                                                    if(newlist[i]['isSettled'] == false){
                                                      model.whopaiddone(newlist[i]['id'],newlist[i]['amount']);
                                                    }else{
                                                      Get.snackbar(
                                                        StringRes.hoorey,
                                                        'Settlement is already done.',
                                                        snackPosition: SnackPosition.TOP,
                                                        backgroundColor: Colors.green,
                                                        borderRadius: 20,
                                                        margin: EdgeInsets.all(Get.width/20),
                                                        colorText: Colors.white,
                                                        duration: const Duration(seconds: 4),
                                                        isDismissible: true,
                                                        dismissDirection: DismissDirection.horizontal,
                                                        forwardAnimationCurve: Curves.easeOutBack,
                                                      );
                                                    }
                                                    //model.whopaiddone(newlist[i]['id'],newlist[i]['amount']);


                                                  },
                                                  widthSpace: Get.width*.15,
                                                  color: Colors.transparent,
                                                  content: Container(
                                                    width: Get.width*.13,
                                                    height: Get.height*.06,
                                                    padding: EdgeInsets.all(Get.width*.035),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        gradient: gredient()
                                                    ),
                                                    child: Image.asset('images/splitxicon.png',color: ColorRes.white,),
                                                  ),
                                                ),
                                                SwipeAction(
                                                  onTap: (CompletionHandler handler) async {
                                                    await handler(false);

                                                    //Get.to(() => BalanceScreen(gid: id,eid: newlist[i]['id'], amount: newlist[i]['amount'],));
                                                    model.delete(newlist[i]['id']);
                                                  },
                                                  widthSpace: Get.width*.15,
                                                  color: Colors.transparent,
                                                  content: Container(
                                                    width: Get.width*.13,
                                                    height: Get.height*.06,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        gradient: gredient()
                                                    ),
                                                    child: SvgPicture.asset('images/deleteicon.svg',fit: BoxFit.scaleDown,),
                                                  ),
                                                ),
                                              ],
                                              child: Row(
                                                children: [

                                                  Container(
                                                    width: Get.width*.1,
                                                    height: Get.height*.05,
                                                    margin: EdgeInsets.only(left: Get.width*.05),
                                                    decoration: BoxDecoration(
                                                      color: ColorRes.headingColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                    ),
                                                    child: Image.asset(c==StringRes.travel?'images/travelicon.png':c==StringRes.internet?'images/interneticon.png':'images/${c.toLowerCase()}.png',fit: BoxFit.scaleDown,),
                                                  ),

                                                  SizedBox(width: Get.width*.05,),

                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                        Text(newlist[i]['description'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.only(right: Get.width*.05),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text('\u{20B9} ${newlist[i]['amount'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: Colors.red,fontWeight: FontWeight.w500),),

                                                        SizedBox(height: Get.height*.005,),
                                                        Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                      ],
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),


                                ],
                              );
                            }
                            else{
                              return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Center(child: Text('No Transaction Found.',style: appTextStyle(textColor: ColorRes.textHintColor),)),
                                ),
                              );
                            }

                          },
                        );

                        /*for(int i=0;i<_listvalue.length; i++){
                          for(int j=0;j<_listvalue[i].length;j++){
                            if(_listvalue[i][j]['date'] == _listkeys[i]){
                              newlist.add(_listvalue[i][j]);
                            }
                          }
                        }

                        print('--------inside--------$newlist');

                        DateTime d = model.edisplay[i].date!;
                        final now = DateTime.now();
                        final now1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final now2 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 1));
                        String d2 = DateFormat.d().format(d);
                        String d3 = DateFormat.MMM().format(d);*/


                        /*return SwipeActionCell(
                          key: ObjectKey(model.edisplay[i]),
                          backgroundColor: Colors.transparent,
                          firstActionWillCoverAllSpaceOnDeleting: true,
                          selectedForegroundColor: ColorRes.headingColor,
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                              onTap: (CompletionHandler handler) async {
                                await handler(false);

                              },
                              widthSpace: Get.width*.15,
                              color: Colors.transparent,
                              content: Container(
                                width: Get.width*.13,
                                height: Get.height*.06,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                    gradient: gredient()
                                ),
                                child: SvgPicture.asset('images/balance.svg',fit: BoxFit.scaleDown,),
                              ),
                            ),
                            SwipeAction(
                              onTap: (CompletionHandler handler) async {
                                await handler(false);

                              },
                              widthSpace: Get.width*.15,
                              color: Colors.transparent,
                              content: Container(
                                width: Get.width*.13,
                                height: Get.height*.06,
                                padding: EdgeInsets.all(Get.width*.035),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                    gradient: gredient()
                                ),
                                child: Image.asset('images/splitxicon.png',color: ColorRes.white,),
                              ),
                            ),
                          ],
                          child: Container(
                            //width: Get.width*.9,
                            height: Get.height*.1,
                            //padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                            margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                            ),
                            child: Column(
                              children: [

                                SizedBox(height: Get.width * .03,),

                                Row(
                                  children: [
                                    Container(
                                      width: Get.width * .1,
                                      height: Get.height * .05,
                                      margin: EdgeInsets.only(left: Get.width * .05),
                                      decoration: BoxDecoration(
                                        color: ColorRes.headingColor,
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width * .02)),
                                      ),
                                      child: Image.asset(c == StringRes.travel ? 'images/travelicon.png': c == StringRes.internet ? 'images/interneticon.png' : 'images/${c.toLowerCase()}.png', fit: BoxFit.scaleDown,),),
                                    SizedBox(width: Get.width * .05,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(model.edisplay[i].title.toString(), style: appTextStyle(fontSize: 21.0, textColor: ColorRes.headingColor, fontWeight: FontWeight.w500),),
                                          Text(model.edisplay[i].description.toString(), style: appTextStyle(fontSize: 12.0, textColor: ColorRes.textHintColor),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: Get.width * .05),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('\u{20B9} ${model.edisplay[i].amount!.toStringAsFixed(1)} /-', style: appTextStyle(fontSize: 21.0, textColor: Colors.red, fontWeight: FontWeight.w500),                                       ),
                                          SizedBox(
                                            height: Get.height * .005,
                                          ),
                                          Text('$d2 $d3', style: appTextStyle(fontSize: 14.0, textColor: ColorRes.textHintColor),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );*/
                      }),
                ),

                //SizedBox(height: Get.height*.05,),
              ],
            ),


           //floation menu
           /* Positioned(
              bottom: Get.width*.22,
              right: Get.width*.05,
              child: model.showFloatingmenu == false ? Container(color: Colors.transparent,) :Container(
                width: Get.width*.5,
                height: Get.width*.45,
                padding: EdgeInsets.only(top: Get.width*.02,bottom: Get.width*.02),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.05),topRight: Radius.circular(Get.width*.05),bottomLeft: Radius.circular(Get.width*.05)),
                    color: ColorRes.white
                ),
                child: Column(
                  children: [

                    GestureDetector(
                      onTap: (){
                        model.showFloatingmenu = false;
                        model.notifyListeners();

                        print(id);
                        print(uid);
                        print(randomid);

                        Get.to(() => AddGroupExpensesScreen(id: id,));
                      },
                      child: Row(
                        children: [

                          Container(
                            width: Get.width*.1,
                            height: Get.height*.05,
                            margin: EdgeInsets.only(left: Get.width*.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.01)),
                              gradient: gredient(),
                            ),
                            child: Center(
                              child: SvgPicture.asset('images/addexpenseicon.svg'),
                            ),
                          ),

                          SizedBox(width: Get.width*.03,),
                          Text(StringRes.addExpense,style: appTextStyle(textColor: ColorRes.headingColor),),

                        ],
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05,top: Get.width*.015),
                        child: Divider(height: Get.height*.01,)),


                    GestureDetector(
                      onTap: (){
                        print('hello 2');
                        model.showFloatingmenu = false;
                        model.notifyListeners();
                      },
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: Get.width*.1,
                            height: Get.height*.05,
                            margin: EdgeInsets.only(left: Get.width*.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.01)),
                              gradient: gredient(),
                            ),
                            child: Center(
                              child: SvgPicture.asset('images/balance.svg'),
                            ),
                          ),

                          SizedBox(width: Get.width*.03,),
                          Text(StringRes.balance,style: appTextStyle(textColor: ColorRes.headingColor),),

                        ],
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05,top: Get.width*.015),
                        child: Divider(height: Get.height*.01,)),

                    GestureDetector(
                      onTap: (){
                        print('hello 3');
                        model.showFloatingmenu = false;
                        model.notifyListeners();
                      },
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: Get.width*.1,
                            height: Get.height*.05,
                            margin: EdgeInsets.only(left: Get.width*.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.01)),
                              gradient: gredient(),
                            ),
                            child: Center(
                              child: Image.asset('images/splitxicon.png',color: ColorRes.white,width: Get.width*.05,height: Get.width*.05,),
                            ),
                          ),

                          SizedBox(width: Get.width*.03,),
                          Text(StringRes.splitx,style: appTextStyle(textColor: ColorRes.headingColor),),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),*/


            Positioned(
              top: Get.width*.48,
              left: Get.width*.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width*.25,
                    height: Get.width*.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                      child:model.g.data!.gdList!.first.image != null ? Image.network(model.g.data!.gdList!.first.image!,fit: BoxFit.cover,):Image.asset('images/groupimg.jpg',fit: BoxFit.cover,),
                    ),
                  ),

                  SizedBox(height: Get.height*.02,),

                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          //margin: EdgeInsets.only(left: Get.width*.12),
                          child: Text(model.g.data!.gdList!.first.name != null ? model.g.data!.gdList!.first.name!.toUpperCase() :'Ravi',style: appTextStyle(fontSize: 20.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),)
                      )
                  ),
                ],
              ),
            ),


          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorRes.white,
          onPressed: (){
            Get.to(() => AddGroupExpensesScreen(id: id,gname: model.gname,));
            /*model.showFloatingmenu =! model.showFloatingmenu;
            model.notifyListeners();*/
          },
          child: const Icon(IconRes.add,color: ColorRes.headingColor,)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat
      );
    });
  }
}
