import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/send.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/send/addsend/add_new_send_screen.dart';
import 'package:personal_expenses/send/send_screen_model.dart';
import 'package:personal_expenses/send/updatesend/update_send_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendScreenModel>.reactive(viewModelBuilder: () => SendScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
          children: [

            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GestureDetector(
                  onTap: (){
                    Get.offAll(() => const HomeScreen());
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

                    Get.to(() => const AddNewSendScreen());
                  },
                  child: Container(
                    width: Get.width*.125,
                    height: Get.width*.125,
                    margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                    child: const Icon(IconRes.add,color: ColorRes.headingColor,),
                    decoration: const BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),



              ],
            ),


            Expanded(
              child: FutureBuilder(
                future: DatabaseHelper.internal().sends(),
                builder: (BuildContext context, AsyncSnapshot<List<SendTable>> snapshot){
                  if(snapshot.hasData){

                    int l = snapshot.data!.length;

                    print(snapshot.data);
                    print(l);

                    if(l > 0){

                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index){

                            String firstDate = snapshot.data![index].startDate!;
                            DateTime dateTime1 = DateTime.parse(firstDate);

                            String lastDate = snapshot.data![index].endDate!;
                            DateTime dateTime2 = DateTime.parse(lastDate);

                            print(firstDate+'-------------'+lastDate);

                            int diff = dateTime2.difference(dateTime1).inDays;

                            return Container(
                              width: Get.width*.90,
                              height: Get.height*.38,
                              margin: EdgeInsets.only(left: Get.width*.03, right: Get.width*.03,bottom: Get.width*.02),
                              decoration: BoxDecoration(
                                color: ColorRes.white,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                              ),
                              child: Column(
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(right: Get.width*.02,top: Get.width*.02),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [

                                        GestureDetector(
                                          onTap: (){
                                            model.deleteItem(snapshot.data![index].id);
                                          },
                                          child: Container(
                                            width: Get.width*.08,
                                            height: Get.height*.04,
                                            decoration: BoxDecoration(
                                              color: ColorRes.headingColor,
                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset('images/deleteicon.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: Get.width*.02,),

                                        GestureDetector(
                                          onTap: (){

                                            Get.to(() => UpdateSendScreen(id: snapshot.data![index].id!));

                                          },
                                          child: Container(
                                            width: Get.width*.08,
                                            height: Get.height*.04,
                                            decoration: BoxDecoration(
                                              color: ColorRes.headingColor,
                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset('images/edit.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(StringRes.loanAmount,style: appTextStyle(fontSize: 10.0,textColor: ColorRes.textHintColor),)),

                                        SizedBox(height: Get.width*.01,),

                                        Text('\u{20B9} ${snapshot.data![index].samount!.toStringAsFixed(2)}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

                                        Divider(height: Get.height*.01,),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08,top: Get.width*.03),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(StringRes.giverName,style: appTextStyle(fontSize: 10.0,textColor: ColorRes.textHintColor),)),

                                        SizedBox(height: Get.width*.01,),

                                        Text(snapshot.data![index].borrowerName!,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

                                        Divider(height: Get.height*.01,),

                                      ],
                                    ),
                                  ),


                                  Container(
                                    margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08,top: Get.width*.03),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(StringRes.loaninterest,style: appTextStyle(fontSize: 10.0,textColor: ColorRes.textHintColor),)),
                                        SizedBox(height: Get.width*.01,),
                                        Text('${snapshot.data![index].sinterest!.toStringAsFixed(2)}%',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),
                                        Divider(height: Get.height*.01,),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08,top: Get.width*.03),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(StringRes.timeDuration,style: appTextStyle(fontSize: 10.0,textColor: ColorRes.textHintColor),)),
                                        SizedBox(height: Get.width*.01,),
                                        Text('$diff days',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      );

                    }else{
                      return Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Center(
                              child: Text(
                                'No Data Available',
                                style: appTextStyle(
                                  fontSize: 25.0,
                                  textColor: ColorRes.textHintColor,
                                ),
                              ),
                            ),
                          )
                      );
                    }

                  }else{
                    return Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(
                            child: Text(
                              'No Data Available',
                              style: appTextStyle(
                                fontSize: 25.0,
                                textColor: ColorRes.textHintColor,
                              ),
                            ),
                          ),
                        )
                    );
                  }
                },
              ),
            ),

          ],
        ),
      );
    });
  }
}
