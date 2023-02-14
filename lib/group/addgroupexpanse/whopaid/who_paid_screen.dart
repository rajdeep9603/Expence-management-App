import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/contact.dart';
import 'package:personal_expenses/group/addgroupexpanse/whopaid/multiperson/multi_person_screen.dart';
import 'package:personal_expenses/group/addgroupexpanse/whopaid/who_paid_screen_model.dart';
import 'package:personal_expenses/splitx/splitx_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class WhoPaidScreen extends StatelessWidget {

  int? gid,eid;
  String? gn;
  double? amount;

  WhoPaidScreen({required this.gid,required this.eid , required this.amount, required this.gn});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WhoPaidScreenModel>.reactive(
      onModelReady: (model){
        model.init(gid,eid,amount,gn);
      },
      viewModelBuilder: () => WhoPaidScreenModel(), builder: (context,model,child){
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
          )
        ],) : Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
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


                    Container(
                        margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.04),
                        child: Text(StringRes.whoPaid,style: appTextStyle(fontSize: 22.0,fontWeight: FontWeight.w400,textColor: ColorRes.headingColor),)),


                  ],
                ),

                GestureDetector(
                  onTap: (){
                    if(model.selected.length > 0){
                      model.next(gid);
                    }
                  },
                  child: Container(
                    width: Get.width*.125,
                    height: Get.width*.125,
                    margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                    child: const Icon(IconRes.right,color: ColorRes.headingColor,),
                    decoration: const BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(height: Get.height*.03),

            /*GestureDetector(
              onTap: (){

                Get.to(() => MultiPersonScreen(amount: amount, eid: eid, gid: gid,));
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: Get.width*.13,
                  height: Get.height*.06,
                  margin: EdgeInsets.only(left: Get.width*.08),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                    gradient: gredient(),
                  ),
                  child: Center(
                    child: SvgPicture.asset('images/multipersonicon.svg',color: ColorRes.white,fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),*/

           /* Expanded(
              child: FutureBuilder(
                future: DatabaseHelper.internal().contacts(),
                builder: (BuildContext context, AsyncSnapshot<List<ContactTable>> snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data!.length > 0){

                      List d = [];

                      List<Map> data = [];
                      snapshot.data!.forEach((element) {
                        data.add(element.toMap());
                      });

                      print(data);

                      data.forEach((element) {
                        if(element['gid'] == gid){
                          d.add(element);
                          model.check.add(false);
                        }
                      });

                      print(d);

                      if(d.isNotEmpty){

                        return Container(
                          width: Get.width*.9,
                          child: ListView.builder(
                            itemCount: d.length,
                            itemBuilder: (context, int index){

                              return Container(
                                height: Get.height*.1,
                                margin: EdgeInsets.only(bottom: Get.width*.02),
                                decoration: BoxDecoration(
                                    color: ColorRes.white,
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                    onTap: (){

                                      var toremove = [];

                                      if(model.check[index] == true){
                                        model.check[index] = false;
                                        model.selected.forEach((element) {
                                          if(element == d[index]['id']){
                                            toremove.add(element);
                                          }
                                        });
                                        model.selected.removeWhere((element) => toremove.contains(element));
                                        model.notifyListeners();
                                      }else{
                                        model.check[index] = true;
                                        model.selected.add(d[index]['id']);
                                        model.notifyListeners();
                                      }
                                    },
                                    leading: Container(
                                        width: Get.width*.14,
                                        height: Get.height,
                                        //margin: EdgeInsets.only(left: Get.width*.05),
                                        decoration: BoxDecoration(
                                          color: ColorRes.headingColor,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                        ),
                                        child: Center(child: Text(d[index]['name'][0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                                    ),
                                    title: Text(d[index]['name'].toString(),style: appTextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                                    trailing: Container(
                                      width: Get.width*.065,
                                      height: Get.width*.065,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ColorRes.headingColor),
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.065)),
                                        color: model.check[index] == true ? ColorRes.headingColor : null,
                                      ),
                                      child: model.check[index] == true ? Icon(IconRes.right,color: ColorRes.white,) : Icon(IconRes.right,color: ColorRes.headingColor,),
                                    ),
                                  ),
                                ),
                              );

                            },
                          ),
                        );

                      }else{
                        return const Align(
                          alignment: Alignment.center,
                          child: Text('No Contact Selected'),
                        );
                      }

                    }else{
                      return const Align(
                        alignment: Alignment.center,
                        child: Text('No Contact Selected'),
                      );
                    }
                  }else{
                    return const Align(
                      alignment: Alignment.center,
                      child: Text('No Contact Selected'),
                    );
                  }
                },
              ),
            ),*/

            Expanded(
              child: model.isBusy ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [

                      Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                  :
              Container(
                width: Get.width*.9,
                child: ListView.builder(
                  itemCount: model.g.data!.ecList!.length,
                  itemBuilder: (BuildContext context, int index){

                    model.g.data!.ecList!.forEach((element) {
                      model.check.add(false);
                    });

                    return Container(
                      height: Get.height*.1,
                      margin: EdgeInsets.only(bottom: Get.width*.02),
                      decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          onTap: (){

                            var toremove = [];
                            var toremove2 = [];

                            if(model.check[index] == true){
                              model.check[index] = false;
                              model.selected.forEach((element) {
                                if(element['id'] == model.g.data!.ecList![index].id){
                                  toremove.add(element);
                                }
                              });

                              model.selected2.forEach((element) {
                                if(element['id'] == model.g.data!.ecList![index].id){
                                  toremove2.add(element);
                                }
                              });
                              model.selected.removeWhere((element) => toremove.contains(element));
                              model.selected2.removeWhere((element) => toremove2.contains(element));
                              model.notifyListeners();
                            }else{
                              model.check[index] = true;

                              Map v = {
                                "ContactId" : model.g.data!.ecList![index].id,
                                "Amount" : 0.0,
                              };

                              Map v2 = {
                                "id" : model.g.data!.ecList![index].id,
                                "name": model.g.data!.ecList![index].name,
                                "number": model.g.data!.ecList![index].mobileNo,
                              };

                              //model.selected.add(model.g.data!.ecList![index].id);
                              model.selected.add(v);
                              model.selected2.add(v2);
                              model.notifyListeners();
                            }

                            print('---------${model.selected}');
                          },
                          leading: Container(
                            width: Get.width*.14,
                            height: Get.height,
                            //margin: EdgeInsets.only(left: Get.width*.05),
                            decoration: BoxDecoration(
                              color: ColorRes.headingColor,
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                            ),
                            child: Center(child: Text(model.g.data!.ecList![index].name![0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                          ),
                          title: Text(model.g.data!.ecList![index].name.toString(),style: appTextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                          trailing: Container(
                            width: Get.width*.065,
                            height: Get.width*.065,
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorRes.headingColor),
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.065)),
                              color: model.check[index] == true ? ColorRes.headingColor : null,
                            ),
                            child: model.check[index] == true ? Icon(IconRes.right,color: ColorRes.white,) : Icon(IconRes.right,color: ColorRes.headingColor,),
                          ),
                        ),
                      ),
                    );

                  },
                ),
              ),
            ),

            SizedBox(height: Get.height*.02,),

          ],
        ),
      );
    });
  }
}
