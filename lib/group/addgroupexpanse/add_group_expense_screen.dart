import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/category/category_screen.dart';
import 'package:personal_expenses/group/addgroupexpanse/add_group_expense_screen_model.dart';
import 'package:personal_expenses/group/addgroupexpanse/whopaid/who_paid_screen.dart';
import 'package:personal_expenses/splitx/splitx_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class AddGroupExpensesScreen extends StatelessWidget {

  int? id;
  String? gname;

  AddGroupExpensesScreen({required this.id,required this.gname});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddGroupExpensesScreenModel>.reactive(
      onModelReady: (model){
        model.init(gname!);
      },
      viewModelBuilder: ()=>AddGroupExpensesScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: model.isBusy
            ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [

            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),

          ],
        )
            :
        SingleChildScrollView(
          child: Column(
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
                          child: Text(StringRes.addExpense,style: appTextStyle(fontSize: 22.0,fontWeight: FontWeight.w400,textColor: ColorRes.headingColor),)),


                    ],
                  ),

                  GestureDetector(
                  onTap: (){
                    model.addE(id);
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

              ],),

              SizedBox(height: Get.height*0.03,),

              //category
              Container(
                width: Get.width*0.9,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
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
              SizedBox(height: Get.height*0.02,),


              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: Get.width*.08),
                  child: Text(StringRes.enterDiscription,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),)),
              ),

              SizedBox(height: Get.height*0.02,),

              //discription
              Container(
                width: Get.width*0.9,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child:  TextField(
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  focusNode: model.descriptionFocusNode,
                  onTap: (){},
                  style: appTextStyle(textColor: ColorRes.filledText),
                  controller: model.descriptionContoller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: StringRes.writeHere,
                    hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.03,),

              //date
              Container(
                width: Get.width*.9,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child: TextField(
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
                    suffixIcon: Icon(IconRes.calender,color: ColorRes.filledText,size: Get.width*.05,),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.02,),

              //enter amount
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.only(left: Get.width*.08),
                    child: Text(StringRes.enterAmount,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),)),
              ),

              SizedBox(height: Get.height*0.02,),

              //amount displaybox
              SizedBox(height: Get.height*.01,),
              Container(
                width: Get.width*.9,
                height: Get.height*.07,
                padding: EdgeInsets.only(left: Get.width*0.05),
                //margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
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

              SizedBox(height: Get.height*0.03,),
              //paid by you line
              Container(
                margin: EdgeInsets.only(left: Get.width*.08,right: Get.width*.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text('Paid by',style: appTextStyle(),),

                    SizedBox(width: Get.width*.01,),

                    GestureDetector(
                      onTap: (){
                        model.nextwho(id);
                      },
                      child: Container(
                        width: Get.width*.2,
                        height: Get.height*.04,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorRes.headingColor,),
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                        ),
                        child: Center(child: Text('You',style: appTextStyle(),),),
                      ),
                    ),
                    /*SizedBox(width: Get.width*.01,),
                    Text('and',style: appTextStyle(),),
                    SizedBox(width: Get.width*.01,),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => const SplitXScreen());
                      },
                      child: Container(
                        width: Get.width*.2,
                        height: Get.height*.04,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorRes.headingColor,),
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                        ),
                        child: Center(child: Text(StringRes.splitx,style: appTextStyle(),),),
                      ),
                    ),
*/
                  ],
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