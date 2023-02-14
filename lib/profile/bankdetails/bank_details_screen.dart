import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/bank.dart';
import 'package:personal_expenses/profile/bankdetails/addnewbank/add_new_bank_screen.dart';
import 'package:personal_expenses/profile/bankdetails/bank_details_screen_model.dart';
import 'package:personal_expenses/profile/bankdetails/updatebank/update_bank_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BankDetailsScreenModel>.reactive(
      viewModelBuilder: () => BankDetailsScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Stack(
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


                         GestureDetector(
                           onTap: (){
                             Get.to(() => const AddNewBankScreen());
                           },
                           child: Container(
                             width: Get.width*.125,
                             height: Get.width*.125,
                             margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                             child: const Icon(IconRes.add,color: ColorRes.headingColor,),//SvgPicture.asset('images/add.svg',fit: BoxFit.scaleDown),
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

                SizedBox(height: Get.height*.10,),


                //if condition start from here
                /*model.isBankAvailable == false ?
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text('No Banks Available',style: appTextStyle(textColor: ColorRes.textHintColor,fontWeight: FontWeight.w500,fontSize: 22.0),)
                        //SvgPicture.asset('images/female.svg'),
                    ],
                  ),
                )
                    :
                Column(
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          margin: EdgeInsets.only(left: Get.width*.05),
                          child: Text(StringRes.bankdetails,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500,fontSize: 22.0),)),
                    ),

                    SizedBox(height: Get.height*.04,),

                    Container(
                      width: Get.width*.90,
                      height: Get.height*.30,
                      decoration: BoxDecoration(
                        color: ColorRes.white,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                      ),
                      child: Stack(
                        children: [

                          Column(),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: Get.width,
                              height: Get.height*.08,
                              decoration: BoxDecoration(
                                gradient: gredient(),
                                borderRadius: BorderRadius.only(bottomRight:Radius.circular(Get.width*.05),bottomLeft: Radius.circular(Get.width*.05)),
                              ),
                              child: Center(child: Text(StringRes.addnewbank,style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                            ),
                          ),

                        ],
                      ),
                    )

                  ],
                ),*/

                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: Get.width*.05),
                      child: Text(StringRes.bankdetails,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500,fontSize: 22.0),)),
                ),

                SizedBox(height: Get.height*.04,),

                FutureBuilder(
                  future: DatabaseHelper.internal().banks(),
                  builder: (BuildContext context,AsyncSnapshot<List<BankTable>> snapshot){
                    if(snapshot.hasData){

                      int l = snapshot.data!.length;

                      if(l > 0){
                        return Container(
                          width: Get.width*.90,
                          height: Get.height*.30,
                          decoration: BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                          ),
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: model.pageController,
                                onPageChanged: model.change,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index){

                                  model.item = snapshot.data![model.loca];

                                  print('banks==========>${model.item}');

                                  return Column(
                                    children: [

                                      //bank row
                                      Container(
                                        margin: EdgeInsets.only(top: Get.width*.08,left: Get.width*.1),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset('images/bankicon.svg',width: Get.width*.05,),
                                            SizedBox(width: Get.width*.04,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(StringRes.bankname,style: appTextStyle(fontSize: 10.0,textColor: ColorRes.textHintColor),),
                                                SizedBox(height: Get.height*.001,),
                                                Text(model.item!.name!,style: appTextStyle(textColor: ColorRes.headingColor),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      //bank divider
                                      Container(
                                          margin: EdgeInsets.only(right: Get.width*.1,left: Get.width*.1),
                                        child: Divider(height: Get.height*.01,)),

                                      //card row
                                      Container(
                                        margin: EdgeInsets.only(top: Get.width*.03,left: Get.width*.1),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SvgPicture.asset('images/cardicon.svg',width: Get.width*.05,),

                                            SizedBox(width: Get.width*.04,),

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(StringRes.acno,style: appTextStyle(fontSize: 10.0,textColor: ColorRes.textHintColor),),
                                                SizedBox(height: Get.height*.001,),
                                                Text(model.item!.acno.toString(),style: appTextStyle(textColor: ColorRes.headingColor),),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                      //card divider
                                      Container(
                                          margin: EdgeInsets.only(right: Get.width*.1,left: Get.width*.1),
                                          child: Divider(height: Get.height*.01,)),

                                      //ifsc row
                                      Container(
                                        margin: EdgeInsets.only(top: Get.width*.03,left: Get.width*.1),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SvgPicture.asset('images/othericon.svg',width: Get.width*.05,),

                                            SizedBox(width: Get.width*.04,),

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(StringRes.ifsc,style: appTextStyle(fontSize: 10.0,textColor: ColorRes.textHintColor),),
                                                SizedBox(height: Get.height*.001,),
                                                Text(model.item!.ifsc!,style: appTextStyle(textColor: ColorRes.headingColor),),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  );


                                },
                              ),

                              /*Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: Get.width*.15,
                                  height: Get.width*.03,
                                  //color: ColorRes.textHintColor,
                                  margin: EdgeInsets.only(right: Get.width*.03,top: Get.width*.02),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context,int i){


                                      return Container(
                                        width: Get.width*.03,
                                        height: Get.width*.03,
                                        margin: EdgeInsets.only(right : Get.width*.01,left: Get.width*.01),
                                        decoration: BoxDecoration(
                                          color: i == model.loca ? ColorRes.headingColor : ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                          border: Border.all(color: i== model.loca ? Colors.transparent :ColorRes.headingColor),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),*/


                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: (){

                                    print('------->${model.item!.name}');
                                    print('------->${model.item!.acno}');
                                    print('------->${model.item!.ifsc}');
                                    print('------->${model.item!.branchname}');
                                    Get.to(() => UpdateScreen(id: model.item!.id));
                                  },
                                  child: Container(
                                    width: Get.width,
                                    height: Get.height*.08,
                                    decoration: BoxDecoration(
                                      gradient: gredient(),
                                      borderRadius: BorderRadius.only(bottomRight:Radius.circular(Get.width*.05),bottomLeft: Radius.circular(Get.width*.05)),
                                    ),
                                    child: Center(child: Text(StringRes.addnewbank,style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }else{
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('No Banks Available',style: appTextStyle(textColor: ColorRes.textHintColor,fontWeight: FontWeight.w500,fontSize: 22.0),)
                            //SvgPicture.asset('images/female.svg'),
                          ],
                        );
                      }


                    }else{
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('No Banks Available',style: appTextStyle(textColor: ColorRes.textHintColor,fontWeight: FontWeight.w500,fontSize: 22.0),)
                          //SvgPicture.asset('images/female.svg'),
                        ],
                      );

                    }
                  },
                ),

              ],
            ),


            //profile pic
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
                child: Image.asset('images/user.png',fit: BoxFit.cover,),
              ),
            ),

          ],
        ),
      );
    });
  }
}
