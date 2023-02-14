import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/send/addsend/add_new_send_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class AddNewSendScreen extends StatelessWidget {
  const AddNewSendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewSendScreenModel>.reactive(viewModelBuilder: ()=>AddNewSendScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: SingleChildScrollView(
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



              //select amount
              SizedBox(height: Get.height*.01,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                      child: Text(StringRes.selectamount,style: appTextStyle(textColor: ColorRes.textHintColor),))),

              //amount displaybox
              SizedBox(height: Get.height*.01,),
              /*Container(
                width: Get.width*.9,
                height: Get.height*.07,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                ),
                margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                child: Center(child: Text('\u{20B9} ${model.amount.toStringAsFixed(2)}',style: appTextStyle(fontSize: 22.0,textColor: ColorRes.filledText),)),
              ),*/

              Container(
                width: Get.width*.9,
                height: Get.height*.07,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                ),
                child: Center(
                  child: Container(
                    width: Get.width*.3,
                    height: Get.height*.07,
                    child: TextField(
                      focusNode: model.amountFocusNode,
                      maxLength: 5,
                      inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: appTextStyle(textColor: ColorRes.filledText,fontSize: 22.0),
                      controller: model.amountController,
                      onTap: (){},
                      onChanged: (vale){
                        if(double.parse(vale) < 10000.0){
                          model.amount = double.parse(vale);
                          model.notifyListeners();
                        }else{
                          model.amount = 10000.0;
                          model.notifyListeners();
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        prefix: Text('\u{20B9} ',style: appTextStyle(fontSize: 22.0,textColor: ColorRes.filledText),),
                      ),
                    ),
                  ),
                ),
              ),

              //slider
              Slider(
                value: model.amount,
                max: 10000.0,
                min: 0.0,
                label: '${model.amount}',
                onChanged: (value){
                  model.amount = value;
                  model.amountController.text = model.amount.toStringAsFixed(2);
                  model.notifyListeners();
                },
              ),

              //borrower name
              SizedBox(height: Get.height*.01,),
              Container(
                width: Get.width*.9,
                height: Get.height*.07,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                ),
                child: TextField(
                  focusNode: model.nameFocusNode,
                  style: appTextStyle(textColor: ColorRes.filledText),
                  controller: model.nameController,
                  onTap: (){},
                  onChanged: (vale){
                    if(double.parse(vale) < 10000.0){
                      model.amount = double.parse(vale);
                      model.notifyListeners();
                    }else{
                      model.amount = 10000.0;
                      model.notifyListeners();
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: StringRes.borrowerName,
                    hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                  ),
                ),
              ),



              //time duration
              SizedBox(height: Get.height*.02,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                      child: Text(StringRes.loanInterest,style: appTextStyle(textColor: ColorRes.textHintColor),))),

              SizedBox(height: Get.height*.01,),

              //loan interes

              //amountInterest displaybox
              SizedBox(height: Get.height*.01,),
              Container(
                width: Get.width*.9,
                height: Get.height*.07,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                ),
                child: Center(
                  child: Container(
                    width: Get.width*.2,
                    height: Get.height*.07,
                    child: TextField(
                      focusNode: model.intrestFocusNode,
                      maxLength: 5,
                      inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: appTextStyle(textColor: ColorRes.filledText,fontSize: 22.0),
                      controller: model.intrestController,
                      onTap: (){},
                      onChanged: (vale){
                        if(double.parse(vale) < 100.0){
                          model.amountInterest = double.parse(vale);
                          model.notifyListeners();
                        }else{
                          model.amountInterest = 100.0;
                          model.notifyListeners();
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        //prefix: Text('${model.amountInterest.toStringAsFixed(2)} %',style: appTextStyle(fontSize: 22.0,textColor: ColorRes.filledText),),
                        //hintText: '0.00%'
                        //prefix: Text('\u{20B9} ',style: appTextStyle(fontSize: 22.0,textColor: ColorRes.filledText),),
                      ),
                    ),
                  ),
                ),
              ),

              Slider(
                value: model.amountInterest,
                max: 100.0,
                min: 0.0,
                label: '${model.amountInterest}',
                onChanged: (value){
                  model.amountInterest = value;
                  model.intrestController.text = model.amountInterest.toStringAsFixed(2);
                  model.notifyListeners();
                },
              ),

              SizedBox(height: Get.height*.01,),

              //date
              Row(
                children: [

                  //startdate
                  Expanded(
                      child: Container(
                        height: Get.height*.07,
                        padding: EdgeInsets.only(left: Get.width*0.05),
                        margin: EdgeInsets.only(left: Get.width*.05,bottom: Get.width*.05),
                        decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                        ),
                        child: TextField(
                          focusNode: model.startDateFocusNode,
                          style: appTextStyle(textColor: ColorRes.filledText,fontSize: 12.0),
                          controller: model.startDateController,
                          onTap: (){
                            model.startDateController.clear();
                            model.startDateFocusNode.unfocus();
                            model.notifyListeners();
                            model.startDay(context);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: StringRes.date,
                            hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                            suffixIcon: Icon(IconRes.calender,size: 15.0,),
                          ),
                        ),
                      )
                  ),


                  Container(
                      margin: EdgeInsets.only(bottom: Get.width*.05,right: Get.width*.02,left: Get.width*.02),
                      child: Text('to',style: appTextStyle(textColor: ColorRes.textHintColor),)),

                  //enddate
                  Expanded(
                      child: Container(
                        height: Get.height*.07,
                        padding: EdgeInsets.only(left: Get.width*0.05),
                        margin: EdgeInsets.only(right: Get.width*.05,bottom: Get.width*.05),
                        decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                        ),
                        child: TextField(
                          focusNode: model.endDateFocusNode,
                          style: appTextStyle(textColor: ColorRes.filledText,fontSize: 12.0),
                          controller: model.endDateController,
                          onTap: (){
                            model.endDateController.clear();
                            model.endDateFocusNode.unfocus();
                            model.notifyListeners();

                            if(model.startDate != null){
                              model.endDay(context);
                            }else{
                              Get.snackbar(
                                StringRes.error,
                                StringRes.errormsg,
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: ColorRes.headingColor,
                                borderRadius: 20,
                                margin: EdgeInsets.all(Get.width/20),
                                colorText: ColorRes.white,
                                duration: const Duration(seconds: 4),
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                forwardAnimationCurve: Curves.easeOutBack,
                              );
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: StringRes.date,
                            hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                            suffixIcon: Icon(IconRes.calender,size: 15.0,),
                          ),
                        ),
                      )
                  ),

                ],
              ),

              SizedBox(height: Get.height*.03,),

              //button
              GestureDetector(
                onTap: (){

                  model.submit();

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
                    child: Text(StringRes.save,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
                  ),
                ),
              ),

              SizedBox(height: Get.height*.02,),

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