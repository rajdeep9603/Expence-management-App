import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/splitx/splitx_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class SplitXScreen extends StatelessWidget {

  int? gid, eid;
  double? amount;
  List<Map>? contacts;

  SplitXScreen({required this.gid, required this.eid, required this.amount, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplitXScreenModel>.reactive(
      onModelReady: (model){
        model.init(gid,eid,amount,contacts);
      },
      viewModelBuilder: () => SplitXScreenModel(), builder: (context,model,child){
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
        ): Column(
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
                        child: Text(StringRes.adjustment,style: appTextStyle(fontSize: 22.0,fontWeight: FontWeight.w600,textColor: ColorRes.headingColor),)),


                  ],
                ),

                GestureDetector(
                  onTap: (){
                    model.next();
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

            //graphs
            Container(
              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08,top: Get.width*.05,bottom: Get.width*.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //1
                  GestureDetector(
                    onTap: (){
                      model.split = 1;
                      model.notifyListeners();
                    },
                    child: Container(
                      width: Get.width*.18,
                      height: Get.width*.18,
                      decoration: BoxDecoration(
                        color: model.split == 1 ? ColorRes.headingColor : ColorRes.white ,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: Offset(1.0, 3.0),
                            blurRadius: 11.0,
                            spreadRadius: -5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SvgPicture.asset('images/baricon.svg',color: model.split == 1 ? ColorRes.white : ColorRes.headingColor,),
                          SizedBox(height: Get.width*.01,),
                          Text(StringRes.byEqually,style: appTextStyle(fontSize: 8.0,textColor: model.split == 1 ? ColorRes.white : ColorRes.headingColor),),

                        ],
                      ),
                    ),
                  ),

                  //2
                  GestureDetector(
                    onTap: (){
                      model.split = 2;
                      model.notifyListeners();
                    },
                    child: Container(
                      width: Get.width*.18,
                      height: Get.width*.18,
                      decoration: BoxDecoration(
                        color: model.split == 2 ? ColorRes.headingColor : ColorRes.white ,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: Offset(1.0, 3.0),
                            blurRadius: 11.0,
                            spreadRadius: -5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SvgPicture.asset('images/baricon1.svg',color: model.split == 2 ? ColorRes.white : ColorRes.headingColor,),
                          SizedBox(height: Get.width*.01,),
                          Text(StringRes.byUnequally,style: appTextStyle(fontSize: 8.0,textColor: model.split == 2 ? ColorRes.white : ColorRes.headingColor),),

                        ],
                      ),
                    ),
                  ),

                  //3
                  GestureDetector(
                    onTap: (){
                      model.split = 3;
                      model.notifyListeners();
                    },
                    child: Container(
                      width: Get.width*.18,
                      height: Get.width*.18,
                      decoration: BoxDecoration(
                        color: model.split == 3 ? ColorRes.headingColor : ColorRes.white ,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: Offset(1.0, 3.0),
                            blurRadius: 11.0,
                            spreadRadius: -5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SvgPicture.asset('images/piecharticon.svg',color: model.split == 3 ? ColorRes.white : ColorRes.headingColor,),
                          SizedBox(height: Get.width*.01,),
                          Text(StringRes.byPercentages,style: appTextStyle(fontSize: 8.0,textColor: model.split == 3 ? ColorRes.white : ColorRes.headingColor),),

                        ],
                      ),
                    ),
                  ),

                  //4
                  GestureDetector(
                    onTap: (){
                      model.split = 4;
                      model.notifyListeners();
                    },
                    child: Container(
                      width: Get.width*.18,
                      height: Get.width*.18,
                      decoration: BoxDecoration(
                        color: model.split == 4 ? ColorRes.headingColor : ColorRes.white ,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: Offset(1.0, 3.0),
                            blurRadius: 11.0,
                            spreadRadius: -5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SvgPicture.asset('images/adjusticon.svg',color: model.split == 4 ? ColorRes.white : ColorRes.headingColor,),
                          SizedBox(height: Get.width*.01,),
                          Text(StringRes.byAdjustment,style: appTextStyle(fontSize: 8.0,textColor: model.split == 4 ? ColorRes.white : ColorRes.headingColor),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08,bottom: Get.width*.02),
              child: Text(model.split == 1 ? StringRes.splitEqually : model.split == 2 ? StringRes.splitExact : model.split == 3 ? StringRes.splitPer : StringRes.splitAdjust ,style: appTextStyle(fontWeight: FontWeight.w600,fontSize: 20.0),textAlign: TextAlign.center,)),

            Container(
              margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
              child: Text(model.split == 1 ? StringRes.splitEquallydes : model.split == 2 ? StringRes.splitExactdec : model.split == 3 ? StringRes.splitPerdec : StringRes.splitAdjustdec,style: appTextStyle(),textAlign: TextAlign.center,)),

            SizedBox(height: Get.height*.015,),

            Container(
              width: Get.width*.9,
              child:  model.split == 1 ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(StringRes.rssymbol+'${model.amount}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 14.0),),
                        Text('(${contacts!.length.toString()} member)',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),)

                      ],
                    ),
                  ),

                 Row(
                    children: [

                      Text('Select all',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 14.0),),

                      SizedBox(width: Get.width*.03,),

                      GestureDetector(
                        onTap: (){
                          if(model.allselected == true){
                            model.allselected = false;
                            for(int i =0; i< model.check.length ; i++){
                              model.check[i] = false;
                              model.notifyListeners();
                            }
                            model.selected.clear();
                            print('hoorey ----------- ${model.selected}');
                            model.notifyListeners();
                          }else{
                            model.allselected = true;
                            for(int i = 0; i < contacts!.length ; i++){
                              if(model.check[i] == false){
                                Map v = {
                                  "ContactId" : contacts![i]['id'],
                                  "Amount" : 0,
                                };
                                model.selected.add(v);
                                model.check[i] = true;
                                model.notifyListeners();
                              }
                            }

                            print('hoorey ----------- ${model.selected}');

                            model.notifyListeners();
                          }
                        },
                        child: Container(
                          width: Get.width*.05,
                          height: Get.width*.05,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorRes.headingColor),
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.065)),
                            color: model.allselected == true ? ColorRes.headingColor : null,
                          ),
                          child: model.allselected == true ? Icon(IconRes.right,color: ColorRes.white,size: Get.width*.04,) : Icon(IconRes.right,color: ColorRes.headingColor,size: Get.width*.04,),
                        ),
                      ),

                      SizedBox(width: Get.width*.02,),

                    ],
                  ) ,

                ],
              ) : model.split == 2 ?
              Row(
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(StringRes.rssymbol+'${model.secondspend} '+'of  '+StringRes.rssymbol+'${model.amount}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 14.0),),
                        Text(StringRes.rssymbol+'${model.secondremaining} left',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),)

                      ],
                    ),
                  ),

                ],
              ) : model.split == 3 ?
              Row(
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('${model.thirdspend}% of 100.0%',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 14.0),),
                        Text('${model.thirdremaining}% left',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),)

                      ],
                    ),
                  ),

                ],
              ):Container(),
            ),

            //contacts
            Expanded(
              child: Container(
                width: Get.width*.9,
                child: ListView.builder(
                  itemCount: contacts!.length,
                  itemBuilder: (BuildContext context, int index){

                    if(model.split == 1){

                      if(model.check.isEmpty){
                        contacts!.forEach((element) {
                          model.check.add(false);
                        });
                      }

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
                                if(model.allselected == true){
                                  model.allselected = false;
                                  model.notifyListeners();
                                }
                                model.check[index] = false;
                                model.selected.forEach((element) {
                                  if(element['ContactId'] == contacts![index]['id']){
                                    toremove.add(element);
                                  }
                                });
                                model.selected.removeWhere((element) => toremove.contains(element));
                                model.notifyListeners();
                              }else{
                                if(contacts!.length == (model.selected.length + 1)){
                                  model.allselected = true;
                                }
                                model.check[index] = true;
                                Map v = {
                                  "ContactId" : contacts![index]['id'],
                                  "Amount" : 0,
                                };
                                model.selected.add(v);
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
                              child: Center(child: Text(contacts![index]['name'][0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                            ),
                            title: Text(contacts![index]['name'].toString(),style: appTextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
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
                    }
                    else if(model.split == 2){

                      if(model.controllers.isEmpty && model.focusnodes.isEmpty){
                        contacts!.forEach((element) {
                          model.controllers.add(TextEditingController());
                          model.focusnodes.add(FocusNode());
                        });


                      }
                      int ml = amount!.toStringAsFixed(0).length;

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

                            },
                            leading: Container(
                              width: Get.width*.14,
                              height: Get.height,
                              //margin: EdgeInsets.only(left: Get.width*.05),
                              decoration: BoxDecoration(
                                color: ColorRes.headingColor,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                              ),
                              child: Center(child: Text(contacts![index]['name'][0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                            ),
                            title: Text(contacts![index]['name'].toString(),maxLines: 1,style: appTextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                            trailing: Container(
                              width: Get.width*.15,
                              height: Get.width*.1,
                              child: TextField(
                                controller: model.controllers[index],
                                focusNode: model.focusnodes[index],
                                maxLength: ml,
                                style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 16.0),
                                inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  hintText: '\u{20B9} 0.00',
                                  counterText: '',
                                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );

                    }
                    else if(model.split == 3){

                      if(model.controllers3.isEmpty && model.focusnodes3.isEmpty){
                        contacts!.forEach((element) {
                          model.controllers3.add(TextEditingController());
                          model.focusnodes3.add(FocusNode());
                        });
                      }

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

                            },
                            leading: Container(
                              width: Get.width*.14,
                              height: Get.height,
                              //margin: EdgeInsets.only(left: Get.width*.05),
                              decoration: BoxDecoration(
                                color: ColorRes.headingColor,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                              ),
                              child: Center(child: Text(contacts![index]['name'][0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                            ),
                            title: Text(contacts![index]['name'].toString(),maxLines: 1,style: appTextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                            trailing: Container(
                              width: Get.width*.15,
                              height: Get.width*.1,
                              child: TextField(
                                controller: model.controllers3[index],
                                focusNode: model.focusnodes3[index],
                                maxLength: 4,
                                style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 16.0),
                                inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  hintText: '0.00%',
                                  counterText: '',
                                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    else{

                      if(model.controllers4.isEmpty && model.focusnodes4.isEmpty){
                        contacts!.forEach((element) {
                          model.controllers4.add(TextEditingController());
                          model.focusnodes4.add(FocusNode());
                        });
                      }
                      int ml = amount!.toStringAsFixed(0).length;

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

                            },
                            leading: Container(
                              width: Get.width*.14,
                              height: Get.height,
                              //margin: EdgeInsets.only(left: Get.width*.05),
                              decoration: BoxDecoration(
                                color: ColorRes.headingColor,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                              ),
                              child: Center(child: Text(contacts![index]['name'][0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                            ),
                            title: Text(contacts![index]['name'].toString(),maxLines: 1,style: appTextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                            trailing: Container(
                              width: Get.width*.15,
                              height: Get.width*.1,
                              child: TextField(
                                controller: model.controllers4[index],
                                focusNode: model.focusnodes4[index],
                                maxLength: ml,
                                style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 16.0),
                                inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  hintText: '\u{20B9} 0.00',
                                  counterText: '',
                                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                  },
                ),
              ),
            ),

          ],
        ),
      );
    });
  }
}


class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}