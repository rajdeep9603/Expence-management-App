import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/catagorywithimage.dart';
import 'package:personal_expenses/database/model/group.dart';
import 'package:personal_expenses/group/addgroup/add_group_screen.dart';
import 'package:personal_expenses/group/group_screen_model.dart';
import 'package:personal_expenses/group/groupmember/add_group_member_screen.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import "package:collection/collection.dart";

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupScreenModel>.reactive(
      onModelReady: (model){
        model.init();
      },
      viewModelBuilder: () => GroupScreenModel(), builder: (context,model,child){
      return WillPopScope(
        onWillPop: ()async{
          Get.offAll(() => const HomeScreen());
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorRes.background,
          body: Column(
            children: [

              //appbar
              Container(
                width: Get.width,
                height: Get.height*.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(Get.width*.08),bottomLeft: Radius.circular(Get.width*.08)),
                  image: const DecorationImage(
                    image: AssetImage("images/appbar.png"),
                    fit: BoxFit.cover,
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
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        GestureDetector(
                          onTap: (){
                            if(model.searchController.text.isNotEmpty){

                              if(model.back == true){
                                Get.offAll(() => const HomeScreen());
                              }

                              model.back = true;

                              model.searchFocusNode.unfocus();
                              model.notifyListeners();
                            }else{
                              if(model.showsearchbar == true){
                                model.showsearchbar = false;
                                model.notifyListeners();
                              }else{
                                Get.offAll(() => const HomeScreen());
                              }
                            }
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

                        model.showsearchbar == true ? Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Container(
                              width: Get.width,
                              height: Get.width*.125,
                              margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.02,right: Get.width*.07),
                              padding: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  const Icon(IconRes.search,color: ColorRes.textHintColor,),

                                  Expanded(
                                    child: Container(
                                      height: Get.width*.125,
                                      margin: EdgeInsets.only(left: Get.width*.03),
                                      child: TextField(
                                        onChanged: (value){
                                          model.runFilter(value);
                                        },
                                        autofocus: true,
                                        controller: model.searchController,
                                        focusNode: model.searchFocusNode,
                                        style: appTextStyle(),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: StringRes.search,
                                          hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              decoration: const BoxDecoration(
                                color: ColorRes.white,
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                              ),
                            ),
                          ),
                        ):GestureDetector(
                          onTap: (){
                            model.showsearchbar = true;
                            model.notifyListeners();
                          },
                          child: Container(
                            width: Get.width*.125,
                            height: Get.width*.125,
                            margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                            child: const Icon(IconRes.search,color: ColorRes.headingColor,),
                            decoration: const BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.all(Radius.circular(100.0)),
                            ),
                          ),
                        ),



                      ],
                    ),

                  ],
                ),
              ),

              SizedBox(height: Get.height*.05,),

              GestureDetector(
                onTap: (){
                  Get.to(() => const AddGroupScreen());
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

                      SvgPicture.asset('images/creategroupicon.svg',width: Get.width*.05,height: Get.width*.05,),

                      SizedBox(width: Get.width*.02,),

                      Text(StringRes.createNewGroup,style: appTextStyle(textColor: ColorRes.white),),

                    ],
                  ),
                ),
              ),

              model.isBusy ?
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [

                        Align(alignment: Alignment.center,child: CircularProgressIndicator(),),
                      ],
                    ),
                  )
                  :
              Expanded(
                child:
                model.find.isEmpty && model.isSearch == false && model.g.data != null
                    ?
                /*FutureBuilder(
                  future: DatabaseHelper.internal().allgroups(),
                  builder: (BuildContext context,AsyncSnapshot<List<GroupHeader>> snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data!.isNotEmpty){
                        print(snapshot.data);

                        model.items = [];
                        snapshot.data!.forEach((element) {
                          model.items!.add(element);
                        }
                        );

                        List<Map> data = [];
                        model.items!.forEach((element) {
                          data.add(element.toMap());
                        });

                        var newMap = groupBy(data, (Map obj) => obj['entryby']);
                        model.listkeys = newMap.keys.toList();
                        model.listvalue = newMap.values.toList();

                        var newlist = [];
                        model.listvalue.forEach((element) {
                          element.forEach((el) {
                            newlist.add(el);
                          });
                        });

                        return Container(
                          width: Get.width*.85,
                          //height: Get.height*.1,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context,int index){
                              return Container(
                                //width: Get.width*.85,
                                height: Get.height*.1,
                                margin: EdgeInsets.only(bottom: Get.width*.02),
                                decoration: BoxDecoration(
                                    color: ColorRes.white,
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(() => AddGroupMemberScreen(name: snapshot.data![index].name,id: snapshot.data![index].id,image: snapshot.data![index].image,bimage: snapshot.data![index].bimage,));
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ListTile(
                                      leading: Container(
                                          width: Get.width*.15,
                                          height: Get.height,
                                          //margin: EdgeInsets.only(left: Get.width*.05),
                                          decoration: BoxDecoration(
                                            color: ColorRes.headingColor,
                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                          ),
                                          child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),child: Image.memory(snapshot.data![index].image!,fit: BoxFit.cover,))
                                      ),
                                      title: Text(snapshot.data![index].name!.toUpperCase(),style: appTextStyle(fontSize: 22.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                                      trailing: Container(
                                        width: Get.width*.1,
                                        height: Get.width*.1,
                                        decoration: BoxDecoration(
                                          gradient: gredient(),
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                                        ),
                                        child: SvgPicture.asset('images/groupicon.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }else{
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Center(child: Text(StringRes.noTransaction,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                          ),
                        );
                      }
                    }else{

                      print('------->${snapshot.data}');


                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(child: Text(StringRes.noData,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                        ),
                      );
                    }
                  },
                )*/
                Container(
                  width: Get.width*.85,
                  child: ListView.builder(
                    itemCount: model.g.data!.gdList!.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        height: Get.height*.1,
                        margin: EdgeInsets.only(bottom: Get.width*.02),
                        decoration: BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(() => AddGroupMemberScreen(id: model.g.data!.gdList![index].id));
                            //Get.to(() => AddGroupMemberScreen(name: snapshot.data![index].name,id: snapshot.data![index].id,image: snapshot.data![index].image,bimage: snapshot.data![index].bimage,));
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              leading: Container(
                                  width: Get.width*.15,
                                  height: Get.height,
                                  decoration: BoxDecoration(
                                    color: ColorRes.headingColor,
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                  ),
                                  child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),child: Image.network(model.g.data!.gdList![index].image!,fit: BoxFit.cover,))
                              ),
                              title: Text(model.g.data!.gdList![index].name!.toUpperCase(),style: appTextStyle(fontSize: 22.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                              trailing: Container(
                                width: Get.width*.1,
                                height: Get.width*.1,
                                decoration: BoxDecoration(
                                    gradient: gredient(),
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                                ),
                                child: SvgPicture.asset('images/groupicon.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    :
                model.find.isNotEmpty
                    ?
                Container(
                  width: Get.width*.85,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.find.length,
                      itemBuilder: (context,i){
                        return Container(

                          height: Get.height*.1,
                          margin: EdgeInsets.only(bottom: Get.width*.02),
                          decoration: BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                          ),
                          child: GestureDetector(
                            onTap: (){
                              //Get.to(() => AddGroupMemberScreen(name: model.find[i]['name'],id: snapshot.data![index].id,image: snapshot.data![index].image,bimage: snapshot.data![index].bimage,));
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                leading: Container(
                                    width: Get.width*.15,
                                    height: Get.height,
                                    //margin: EdgeInsets.only(left: Get.width*.05),
                                    decoration: BoxDecoration(
                                      color: ColorRes.headingColor,
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                    ),
                                    child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),child: Image.network(model.find[i].image,fit: BoxFit.cover,))
                                ),
                                title: Text(model.find[i].name.toUpperCase(),style: appTextStyle(fontSize: 22.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                                trailing: Container(
                                  width: Get.width*.1,
                                  height: Get.width*.1,
                                  decoration: BoxDecoration(
                                      gradient: gredient(),
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                                  ),
                                  child: SvgPicture.asset('images/groupicon.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                )
                    :
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Center(child: Text(StringRes.noData,style: appTextStyle(textColor: ColorRes.textHintColor),)),
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
