import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/category/category_screen.dart';
import 'package:personal_expenses/expense/updateexpense/update_expense_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class UpdateExpenseScreen extends StatelessWidget {
  Map? newList;

  UpdateExpenseScreen({required this.newList});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateExpenseScreenModel>.reactive(
      onModelReady: (model){
        model.init(newList);
      },
      viewModelBuilder: () => UpdateExpenseScreenModel(), builder: (Context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: SingleChildScrollView(
          child: Column(
            children: [

              Row(children: [

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
                    child: Text(StringRes.addExpense,style: appTextStyle(fontSize: 22.0,fontWeight: FontWeight.w400,textColor: ColorRes.headingColor),)),

              ],),


              SizedBox(height: Get.height*.04,),


              Container(
                width: Get.width*0.9,
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                padding: EdgeInsets.only(left: Get.width*0.05),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child:  TextField(
                  focusNode: model.categoryFocusNode,
                  onTap: (){
                    model.categoryFocusNode.unfocus();
                    model.categoryContoller.clear();
                    Get.to(() => CategoryScreen())!.then((value){
                      if(value != null){
                        model.categoryContoller.text = value[0]['name'];
                        model.result = value[1]['photo'];
                      }
                    });
                  },
                  style: appTextStyle(textColor: ColorRes.filledText),
                  controller: model.categoryContoller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: StringRes.category,
                      hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                      suffixIcon: const Icon(IconRes.down)
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.03,),


              //title
              Container(
                width: Get.width*0.9,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child:  TextField(
                  keyboardType: TextInputType.text,
                  focusNode: model.titleFocusNode,
                  onTap: (){},
                  style: appTextStyle(textColor: ColorRes.filledText),
                  controller: model.titleContoller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: StringRes.title,
                    hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.03,),


              //discription
              Container(
                width: Get.width*.9,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child:  TextField(
                  //obscureText: model.showText,
                  focusNode: model.discriptionFocusNode,
                  onTap: (){},
                  style: appTextStyle(textColor: ColorRes.filledText),
                  controller: model.discriptionContoller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: StringRes.discription,
                    hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.03,),


              //amount
              Container(
                width: Get.width*.9,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child:  TextField(
                  //inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                  focusNode: model.amountFocusNode,
                  onTap: (){},
                  style: appTextStyle(textColor: ColorRes.filledText),
                  controller: model.amountContoller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: StringRes.amount,
                    hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.03,),

              //date of birth
              Container(
                width: Get.width*.9,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child:  TextField(
                  focusNode: model.dateFocusNode,
                  onTap: (){
                    model.dateContoller.clear();
                    model.dateFocusNode.unfocus();
                    model.birthDay(context);
                  },
                  style: appTextStyle(textColor: ColorRes.filledText),
                  controller: model.dateContoller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: StringRes.date,
                    hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                    suffixIcon: const Icon(IconRes.calender,color: ColorRes.textHintColor,),
                  ),
                ),
              ),

              SizedBox(height: Get.height*0.08,),

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