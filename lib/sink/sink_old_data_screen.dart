import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/sink/sink_old_data_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class SinkDataScreen extends StatelessWidget {
  const SinkDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SinkDataScreenModel>.reactive(
      onModelReady: (model){
        model.init();
      },
      viewModelBuilder: () => SinkDataScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: model.isBusy ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )

          ],
        ):Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  //alignment: Alignment.centerLeft,
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

                Row(
                  children: [

                    TextButton(
                      onPressed: (){
                        model.newdata();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: Get.height*.06),
                          child: Text('Sync',style: appTextStyle(),)),
                    ),

                    TextButton(
                      onPressed: (){
                        model.alldata();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                        child: Text('Sync All',style: appTextStyle(),)),
                    ),

                  ],
                ),
              ],
            ),


            /*Expanded(
              child:
              model.find.isEmpty && model.isSearch == false
                  ?
              Container(
                width: Get.width*.85,
                child: ListView.builder(
                  itemCount: model.sd.data!.ewpList!.length,
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

                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            leading: Container(
                                width: Get.width*.1,
                                height: Get.width*.1,
                                decoration: BoxDecoration(
                                  color: ColorRes.headingColor,
                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                ),
                                child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),child: Image.asset('images/bills.png',))
                            ),
                            title: Text('Group',style: appTextStyle(fontSize: 22.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                            subtitle: Text('group expense',style: appTextStyle(textColor: ColorRes.headingColor),),
                            trailing: Container(
                              child: Text(model.sd.data!.ewpList![index].amount.toString(),style: appTextStyle(fontSize: 20.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
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
            ),*/

            Expanded(
              child: Container(
                width: Get.width*.85,
                child: ListView.builder(
                  itemCount: model.sd.data!.ewpList!.length,
                  itemBuilder: (BuildContext context, int index){

                    if(model.sd.data!.ewpList!.length > 0){
                      return Container(
                        height: Get.height*.1,
                        margin: EdgeInsets.only(bottom: Get.width*.02),
                        decoration: BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                        ),
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              leading: Container(
                                  width: Get.width*.1,
                                  height: Get.width*.1,
                                  decoration: BoxDecoration(
                                    color: ColorRes.headingColor,
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                  ),
                                  child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),child: Image.asset('images/bills.png',))
                              ),
                              title: Text('Group',style: appTextStyle(fontSize: 22.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                              subtitle: Text('group expense',style: appTextStyle(textColor: ColorRes.headingColor),),
                              trailing: Container(
                                child: Text(model.sd.data!.ewpList![index].amount.toString(),style: appTextStyle(fontSize: 20.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                              ),
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Align(
                        alignment: Alignment.center,
                        child: Text('No Expense Available',style: appTextStyle(),),
                      );
                    }

                  },
                ),
              ),
            ),

            model.sd.data!.ewpList!.length > 0 ?GestureDetector(
              onTap: (){
                //Get.to(() => const AddGroupScreen());
                model.addto();
              },
              child: Container(
                width: Get.width*.85,
                height: Get.height*.06,
                margin: EdgeInsets.only(bottom: Get.width*.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                  gradient: gredient(),
                ),
                child: Center(child: Text('Add to expense',style: appTextStyle(textColor: ColorRes.white),)),
              ),
            ):Container(),

          ],
        ),
      );
    });
  }
}
