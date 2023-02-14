import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/loan/calculator/loan_calculator_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class LoanCalculator extends StatelessWidget {
  const LoanCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoanCalculatorModel>.reactive(viewModelBuilder: ()=> LoanCalculatorModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: SingleChildScrollView(
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    width: Get.width*.125,
                    height: Get.width*.125,
                    margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.07,bottom: Get.width*.03),
                    child: const Icon(IconRes.back,color: ColorRes.headingColor,),
                    decoration: const BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),

              Container(
                width: Get.width*.85,
                height: Get.height*.40,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                ),
                child: Column(
                  children: [

                    SizedBox(height: Get.height*.02,),
                    Text('Calculate',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 24.0,fontWeight: FontWeight.w500),),

                    SizedBox(height: Get.height*.04,),
                    Container(
                      width: Get.width*.75,
                      height: Get.height*.07,
                      padding: EdgeInsets.only(left: Get.width*0.05),
                      decoration: BoxDecoration(
                        color: ColorRes.background,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                      ),
                      child: TextField(
                        focusNode: model.af,
                        maxLength: 8,
                        inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        style: appTextStyle(textColor: ColorRes.filledText),
                        controller: model.amount,
                        onTap: (){},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Amount',
                          counterText: '',
                          hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                        ),
                      ),
                    ),

                    SizedBox(height: Get.height*.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Container(
                          width: Get.width*.35,
                          height: Get.height*.07,
                          padding: EdgeInsets.only(left: Get.width*0.05),
                          decoration: BoxDecoration(
                            color: ColorRes.background,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                          ),
                          child: TextField(
                            focusNode: model.inf,
                            inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            style: appTextStyle(textColor: ColorRes.filledText),
                            controller: model.interest,
                            onTap: (){},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Interest',
                              hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                            ),
                          ),
                        ),

                        Container(
                          width: Get.width*.35,
                          height: Get.height*.07,
                          padding: EdgeInsets.only(left: Get.width*0.05),
                          decoration: BoxDecoration(
                            color: ColorRes.background,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                          ),
                          child: TextField(
                            focusNode: model.df,
                            inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            style: appTextStyle(textColor: ColorRes.filledText),
                            controller: model.duration,
                            onTap: (){},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Years',
                              hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: Get.height*.04,),
                    GestureDetector(
                      onTap: (){
                        //Get.back();
                        //model.submit();
                        model.check();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*.08),
                        width: Get.width*.5,
                        height: Get.height*0.07,
                        decoration: BoxDecoration(
                          gradient: gredient(),
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Center(
                          child: Text('Calculate',style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              //SizedBox(height: Get.width*.01,),

              /*model.emilist.isNotEmpty
                  ?
              Container(
                width: Get.width*.85,
                height: Get.height,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    *//*mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,*//*
                    children: [

                      Container(
                        width: Get.width*.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Container(
                              width: Get.width*.20,
                                alignment: Alignment.center,
                              child: Text('EMI',maxLines: 1,style: appTextStyle(fontSize: 14.0),)),
                            Container(
                              width: Get.width*.20,
                              alignment: Alignment.center,
                              child: Text('Interest',maxLines: 1,style: appTextStyle(fontSize: 14.0),)),
                            Container(
                              width: Get.width*.20,
                              child: Text('Repayment',maxLines: 1,style: appTextStyle(fontSize: 14.0),)),
                            Container(
                              width: Get.width*.20,
                              child: Text('Outstanding',maxLines: 1,style: appTextStyle(fontSize: 14.0),)),

                          ],
                        ),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: model.emilist.length,
                        itemBuilder: (BuildContext context, int index){

                          return Container(
                            width: Get.width*.80,
                            height: Get.height*.04,
                            color: ColorRes.white,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Text(model.emilist[index]['emi'],style: appTextStyle(fontSize: 12.0),),
                                Text(model.emilist[index]['interest'],style: appTextStyle(fontSize: 12.0),),
                                Text(model.emilist[index]['repayment'],style: appTextStyle(fontSize: 12.0),),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(model.emilist[index]['outstanding'],style: appTextStyle(fontSize: 12.0),)),

                              ],
                            ),
                          );


                        },
                      ),
                    ],
                  ),
                )
                *//*ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: model.emilist.length,
                    itemBuilder: (BuildContext context, int index){

                      return Container(
                        width: Get.width*.75,
                        height: Get.height*.04,
                        color: ColorRes.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Text(model.emilist[index]['emi'],style: appTextStyle(fontSize: 12.0),),
                            Text(model.emilist[index]['interest'],style: appTextStyle(fontSize: 12.0),),
                            Text(model.emilist[index]['repayment'],style: appTextStyle(fontSize: 12.0),),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(model.emilist[index]['outstanding'],style: appTextStyle(fontSize: 12.0),)),

                          ],
                        ),
                      );


                    },
                  )*//*,
              )
                  :
              Container(),*/


              model.emilist.isNotEmpty
                  ?
                  Container(
                    margin: EdgeInsets.only(left: Get.width*.07,right: Get.width*.07,),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: model.emilist.length,
                      itemBuilder: (BuildContext context, int index){

                        return Card(
                          child: Container(
                            height: Get.height*.05,
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                            ),
                            child: Column(
                              children: [

                                SizedBox(height: Get.height*.01,),

                                Text('Month ${index+1}',style: appTextStyle(textColor: ColorRes.headingColor),),

                                SizedBox(height: Get.height*.03,),

                                Row(
                                  children: [

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                            margin: EdgeInsets.only(left: Get.width*.02),
                                            child: Text('EMI : ${model.emilist[index]['emi']}',maxLines: 1,style: appTextStyle(fontSize: 11.0),)),
                                        Container(
                                            margin: EdgeInsets.only(left: Get.width*.02),
                                            child: Text('Outstanding : ${model.emilist[index]['outstanding']}',maxLines: 1,style: appTextStyle(fontSize: 11.0),)),
                                        Container(
                                            margin: EdgeInsets.only(left: Get.width*.02),
                                            child: Text('Interest : ${model.emilist[index]['interest']}',maxLines: 1,style: appTextStyle(fontSize: 11.0),)),
                                        Container(
                                            margin: EdgeInsets.only(left: Get.width*.02),
                                            child: Text('Repayment : ${model.emilist[index]['repayment']}',maxLines: 1,style: appTextStyle(fontSize: 11.0),)),

                                      ],
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        );

                      },),
                  )
                  :
              Container(),

              SizedBox(height: Get.width*.03,),

            ],
          ),
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