import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/loan.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/loan/calculator/loan_calculator.dart';
import 'package:personal_expenses/loan/loan_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoanScreenModel>.reactive(viewModelBuilder: () => LoanScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Stack(
          children: [

            Column(
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

                          //back button
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


                          Row(
                            children: [
                              //loancalculator
                              GestureDetector(
                                onTap: (){
                                  Get.to(() => const LoanCalculator());
                                },
                                child: Container(
                                  width: Get.width*.125,
                                  height: Get.width*.125,
                                  margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.02),
                                  child:  const Icon(IconRes.c,color: ColorRes.headingColor,),
                                  decoration: const BoxDecoration(
                                    color: ColorRes.white,
                                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                  ),
                                ),
                              ),

                              //add new loan
                              GestureDetector(
                                onTap: (){
                                  //bottomsheet
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return BottomSheet(
                                        onClosing: () {},
                                        backgroundColor: ColorRes.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                        ),
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context, setState){

                                              return SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.all(Get.width*.05),
                                                  child: SingleChildScrollView(
                                                    child: Padding(
                                                      padding: MediaQuery.of(context).viewInsets,
                                                      child: Column(
                                                        children: [

                                                          //close button
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: GestureDetector(
                                                              onTap: (){
                                                                model.amount = 0.0;
                                                                model.startDateController.clear();
                                                                model.amountController.clear();
                                                                model.endDateController.clear();
                                                                model.loanController.clear();
                                                                model.nameController.clear();
                                                                model.startDate = null;
                                                                model.selectedDate = DateTime.now();
                                                                setState((){});
                                                                model.notifyListeners();
                                                                Get.back();
                                                              },
                                                              child: const Icon(IconRes.close),
                                                            ),
                                                          ),

                                                          //add loan
                                                          SizedBox(height: Get.height*.01,),
                                                          Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text(StringRes.addLoan,style: appTextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),

                                                          //select amount
                                                          SizedBox(height: Get.height*.01,),
                                                          Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text(StringRes.selectamount,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                          //amount displaybox
                                                          SizedBox(height: Get.height*.01,),
                                                          Container(
                                                            width: Get.width*.9,
                                                            height: Get.height*.07,
                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                            //margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                                                            decoration: BoxDecoration(
                                                              color: ColorRes.background,
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
                                                                      setState((){});
                                                                    }else{
                                                                      model.amount = 10000.0;
                                                                      model.notifyListeners();
                                                                      setState((){});
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
                                                              setState((){});
                                                            },
                                                          ),

                                                          //giver name
                                                          SizedBox(height: Get.height*.01,),
                                                          Container(
                                                            width: Get.width*.9,
                                                            height: Get.height*.07,
                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                            decoration: BoxDecoration(
                                                              color: ColorRes.background,
                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                            ),
                                                            child: TextField(
                                                              focusNode: model.nameFocusNode,
                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                              controller: model.nameController,
                                                              onTap: (){},
                                                              decoration: InputDecoration(
                                                                border: InputBorder.none,
                                                                hintText: StringRes.giverName,
                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                              ),
                                                            ),
                                                          ),

                                                          //loan interest
                                                          SizedBox(height: Get.height*.03,),
                                                          Container(
                                                            width: Get.width*.9,
                                                            height: Get.height*.07,
                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                            decoration: BoxDecoration(
                                                              color: ColorRes.background,
                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                            ),
                                                            child: TextField(
                                                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                              focusNode: model.loanFocusNode,
                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                              controller: model.loanController,
                                                              onTap: (){},
                                                              decoration: InputDecoration(
                                                                border: InputBorder.none,
                                                                hintText: StringRes.loaninterest,
                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                              ),
                                                            ),
                                                          ),

                                                          //time duration
                                                          SizedBox(height: Get.height*.02,),
                                                          Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text(StringRes.time,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                          SizedBox(height: Get.height*.01,),

                                                          //date
                                                          Row(
                                                            children: [

                                                              //startdate
                                                              Expanded(
                                                                  child: Container(
                                                                    height: Get.height*.07,
                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                    decoration: BoxDecoration(
                                                                      color: ColorRes.background,
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
                                                                  margin: EdgeInsets.all(Get.width*.02),
                                                                  child: Text('to',style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                              //enddate
                                                              Expanded(
                                                                  child: Container(
                                                                    height: Get.height*.07,
                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                    decoration: BoxDecoration(
                                                                      color: ColorRes.background,
                                                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                    ),
                                                                    child: TextField(
                                                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                                                                      focusNode: model.endDateFocusNode,
                                                                      //maxLength: 2,
                                                                      keyboardType: TextInputType.number,
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
                                                                        //counterText: '',
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
                                                              Get.back();
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
                                                  ),

                                                ),
                                              );

                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                  model.notifyListeners();

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

                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(height: Get.height*.075,),

                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: Get.width*.05),
                    child: Text(StringRes.loaninfo,style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w600,fontSize: 22.0),))),

                //body
                model.index == 1 ?
                  Expanded(
                  child: FutureBuilder(
                      future: DatabaseHelper.internal().loans(),
                      builder: (BuildContext context,AsyncSnapshot<List<LoanTable>> snapshot){
                        if(snapshot.hasData){

                          model.items = [];

                          snapshot.data!.forEach((element) {
                            if(element.type == StringRes.home){
                              model.items!.add(element);
                            }
                          });

                          if(model.items!.length > 0){
                            return ListView.builder(
                                itemCount: model.items!.length,
                                itemBuilder: (BuildContext context, int index){
                                  
                                  model.item = model.items![index];
                                  print(model.item);
                                  String firstDate = model.item!.starttime!;
                                  DateTime dateTime1 = DateTime.parse(firstDate);
                                  String lastDate = model.item!.endtime!;
                                  DateTime dateTime2 = DateTime.parse(lastDate);
                                  print(firstDate+'-------------'+lastDate);
                                  int diff = dateTime2.difference(dateTime1).inDays;

                                  return Container(
                                    width: Get.width*.90,
                                    height: Get.height*.38,
                                    margin: EdgeInsets.only(left: Get.width*.03, right: Get.width*.03,bottom: Get.width*.02),
                                    padding: EdgeInsets.only(bottom: Get.width*.02),
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
                                                  model.deleteItem(model.item!.id);
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

                                                  /*if(model.amount != null){
                                                    model.amount = model.item!.amount!;
                                                  }

                                                  if(model.amountController.text.isEmpty){
                                                    model.amountController = TextEditingController(text: model.item!.amount!.toStringAsFixed(2));
                                                  }

                                                  if(model.nameController.text.isEmpty){
                                                    model.nameController = TextEditingController(text: model.item!.giverName);
                                                  }

                                                  if(model.loanController.text.isEmpty){
                                                    model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  }

                                                  if(model.startDateController.text.isEmpty){
                                                    model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  }

                                                  if(model.endDateController.text.isEmpty){
                                                    model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  }*/

                                                  model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  model.startDate = DateTime.parse(model.item!.starttime!);
                                                  model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  model.nameController = TextEditingController(text: model.item!.giverName);
                                                  model.amountController = TextEditingController(text: model.item!.amount!.toStringAsFixed(2));
                                                  model.amount = model.item!.amount!;


                                                  model.notifyListeners();

                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    backgroundColor: Colors.transparent,
                                                    builder: (BuildContext context) {
                                                      return BottomSheet(
                                                        onClosing: () {},
                                                        backgroundColor: ColorRes.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                                        ),
                                                        builder: (BuildContext context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext context, setState){

                                                              return SingleChildScrollView(
                                                                child: Container(
                                                                  padding: EdgeInsets.all(Get.width*.05),
                                                                  child: SingleChildScrollView(
                                                                    child: Padding(
                                                                      padding: MediaQuery.of(context).viewInsets,
                                                                      child: Column(
                                                                        children: [

                                                                          //close button
                                                                          Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: GestureDetector(
                                                                              onTap: (){
                                                                                model.amount = 0.0;
                                                                                model.startDateController.clear();
                                                                                model.amountController.clear();
                                                                                model.endDateController.clear();
                                                                                model.loanController.clear();
                                                                                model.nameController.clear();
                                                                                model.startDate = null;
                                                                                model.selectedDate = DateTime.now();
                                                                                setState((){});
                                                                                model.notifyListeners();
                                                                                Get.back();
                                                                              },
                                                                              child: const Icon(IconRes.close),
                                                                            ),
                                                                          ),

                                                                          //add loan
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.addLoan,style: appTextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),

                                                                          //select amount
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.selectamount,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          //amount displaybox
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            //margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
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
                                                                                      setState((){});
                                                                                    }else{
                                                                                      model.amount = 10000.0;
                                                                                      model.notifyListeners();
                                                                                      setState((){});
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
                                                                              setState((){});
                                                                            },
                                                                          ),

                                                                          //giver name
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              focusNode: model.nameFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.nameController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.giverName,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //loan interest
                                                                          SizedBox(height: Get.height*.03,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                              focusNode: model.loanFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.loanController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.loaninterest,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //time duration
                                                                          SizedBox(height: Get.height*.02,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.time,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          SizedBox(height: Get.height*.01,),

                                                                          //date
                                                                          Row(
                                                                            children: [

                                                                              //startdate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                        model.startDayUpdate(context,model.item!.starttime);
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
                                                                                  margin: EdgeInsets.all(Get.width*.02),
                                                                                  child: Text('to',style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                              //enddate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                          model.endDayUpdate(context, model.item!.endtime);
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
                                                                              Get.back();
                                                                              if(model.amount > 0.0 && model.nameController.text.isNotEmpty && model.loanController.text.isNotEmpty && model.startDateController.text.isNotEmpty && model.endDateController.text.isNotEmpty){
                                                                                model.updateLoanInfo(model.item!.type, model.item!.id);
                                                                              }else{
                                                                                Get.snackbar(
                                                                                  'Error',
                                                                                  'Enter All Data',
                                                                                  snackPosition: SnackPosition.TOP,
                                                                                  backgroundColor: Colors.red,
                                                                                  borderRadius: 20,
                                                                                  margin: EdgeInsets.all(Get.width/20),
                                                                                  colorText: Colors.white,
                                                                                  duration: const Duration(seconds: 4),
                                                                                  isDismissible: true,
                                                                                  dismissDirection: DismissDirection.horizontal,
                                                                                  forwardAnimationCurve: Curves.easeOutBack,
                                                                                );
                                                                              }

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
                                                                  ),

                                                                ),
                                                              );

                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                  model.notifyListeners();
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

                                              Text('\u{20B9} ${model.item!.amount!.toStringAsFixed(2)}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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

                                              Text(model.item!.giverName!,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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
                                              Text('${model.item!.interest!.toStringAsFixed(2)}%',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),
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
                                      StringRes.home,
                                      style: appTextStyle(
                                        fontSize: 25.0,
                                        textColor: ColorRes.headingColor,
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
                                    StringRes.home,
                                    style: appTextStyle(
                                      fontSize: 25.0,
                                      textColor: ColorRes.headingColor,
                                    ),
                                  ),
                                ),
                              )
                          );
                        }
                      }
                  ),
                ) :
                model.index == 2 ?
                  Expanded(
                  child: FutureBuilder(
                      future: DatabaseHelper.internal().loans(),
                      builder: (BuildContext context,AsyncSnapshot<List<LoanTable>> snapshot){
                        if(snapshot.hasData){

                          model.items = [];

                          snapshot.data!.forEach((element) {
                            if(element.type == StringRes.personal){
                              model.items!.add(element);
                            }
                          });

                          if(model.items!.length > 0){

                            return ListView.builder(
                                itemCount: model.items!.length,
                                itemBuilder: (BuildContext context, int index){

                                  model.item = model.items![index];

                                  print(model.item);

                                  String firstDate = model.item!.starttime!;
                                  DateTime dateTime1 = DateTime.parse(firstDate);

                                  String lastDate = model.item!.endtime!;
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
                                                  model.deleteItem(model.item!.id);
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

                                                 /* if(model.amount != null){
                                                    model.amount = model.item!.amount!;
                                                  }

                                                  if(model.nameController.text.isEmpty){
                                                    model.nameController = TextEditingController(text: model.item!.giverName);
                                                  }

                                                  if(model.loanController.text.isEmpty){
                                                    model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  }

                                                  if(model.startDateController.text.isEmpty){
                                                    model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  }

                                                  if(model.endDateController.text.isEmpty){
                                                    model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  }
*/
                                                  model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  model.nameController = TextEditingController(text: model.item!.giverName);
                                                  model.amountController = TextEditingController(text: model.item!.amount!.toStringAsFixed(2));
                                                  model.amount = model.item!.amount!;

                                                  model.notifyListeners();



                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    backgroundColor: Colors.transparent,
                                                    builder: (BuildContext context) {
                                                      return BottomSheet(
                                                        onClosing: () {},
                                                        backgroundColor: ColorRes.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                                        ),
                                                        builder: (BuildContext context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext context, setState){

                                                              return SingleChildScrollView(
                                                                child: Container(
                                                                  padding: EdgeInsets.all(Get.width*.05),
                                                                  child: SingleChildScrollView(
                                                                    child: Padding(
                                                                      padding: MediaQuery.of(context).viewInsets,
                                                                      child: Column(
                                                                        children: [

                                                                          //close button
                                                                          Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: GestureDetector(
                                                                              onTap: (){
                                                                                model.amount = 0.0;
                                                                                model.startDateController.clear();
                                                                                model.amountController.clear();
                                                                                model.endDateController.clear();
                                                                                model.loanController.clear();
                                                                                model.nameController.clear();
                                                                                model.startDate = null;
                                                                                model.selectedDate = DateTime.now();
                                                                                setState((){});
                                                                                model.notifyListeners();
                                                                                Get.back();
                                                                              },
                                                                              child: const Icon(IconRes.close),
                                                                            ),
                                                                          ),

                                                                          //add loan
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.addLoan,style: appTextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),

                                                                          //select amount
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.selectamount,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          //amount displaybox
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            //margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
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
                                                                                      setState((){});
                                                                                    }else{
                                                                                      model.amount = 10000.0;
                                                                                      model.notifyListeners();
                                                                                      setState((){});
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
                                                                              setState((){});
                                                                            },
                                                                          ),

                                                                          //giver name
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              focusNode: model.nameFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.nameController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.giverName,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //loan interest
                                                                          SizedBox(height: Get.height*.03,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                              focusNode: model.loanFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.loanController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.loaninterest,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //time duration
                                                                          SizedBox(height: Get.height*.02,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.time,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          SizedBox(height: Get.height*.01,),

                                                                          //date
                                                                          Row(
                                                                            children: [

                                                                              //startdate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                        model.startDayUpdate(context,model.item!.starttime);
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
                                                                                  margin: EdgeInsets.all(Get.width*.02),
                                                                                  child: Text('to',style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                              //enddate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                          model.endDayUpdate(context, model.item!.endtime);
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
                                                                              Get.back();
                                                                              if(model.amount > 0.0 && model.nameController.text.isNotEmpty && model.loanController.text.isNotEmpty && model.startDateController.text.isNotEmpty && model.endDateController.text.isNotEmpty){
                                                                                model.updateLoanInfo(model.item!.type, model.item!.id);
                                                                              }else{
                                                                                Get.snackbar(
                                                                                  'Error',
                                                                                  'Enter All Data',
                                                                                  snackPosition: SnackPosition.TOP,
                                                                                  backgroundColor: Colors.red,
                                                                                  borderRadius: 20,
                                                                                  margin: EdgeInsets.all(Get.width/20),
                                                                                  colorText: Colors.white,
                                                                                  duration: const Duration(seconds: 4),
                                                                                  isDismissible: true,
                                                                                  dismissDirection: DismissDirection.horizontal,
                                                                                  forwardAnimationCurve: Curves.easeOutBack,
                                                                                );
                                                                              }

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
                                                                  ),

                                                                ),
                                                              );

                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                  model.notifyListeners();
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

                                              Text('\u{20B9} ${model.item!.amount!.toStringAsFixed(2)}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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

                                              Text(model.item!.giverName!,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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
                                              Text('${model.item!.interest!.toStringAsFixed(2)}%',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),
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
                                      StringRes.personal,
                                      style: appTextStyle(
                                        fontSize: 25.0,
                                        textColor: ColorRes.headingColor,
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
                                    StringRes.personal,
                                    style: appTextStyle(
                                      fontSize: 25.0,
                                      textColor: ColorRes.headingColor,
                                    ),
                                  ),
                                ),
                              )
                          );
                        }
                      }
                  ),
                ) :
                model.index == 3 ?
                  Expanded(
                  child: FutureBuilder(
                      future: DatabaseHelper.internal().loans(),
                      builder: (BuildContext context,AsyncSnapshot<List<LoanTable>> snapshot){
                        if(snapshot.hasData){

                          model.items = [];

                          snapshot.data!.forEach((element) {
                            if(element.type == StringRes.car){
                              model.items!.add(element);
                            }
                          });

                          if(model.items!.length > 0){
                            return ListView.builder(
                                itemCount: model.items!.length,
                                itemBuilder: (BuildContext context, int index){

                                  model.item = model.items![index];

                                  print(model.item);

                                  String firstDate = model.item!.starttime!;
                                  DateTime dateTime1 = DateTime.parse(firstDate);

                                  String lastDate = model.item!.endtime!;
                                  DateTime dateTime2 = DateTime.parse(lastDate);

                                  print(firstDate+'-------------'+lastDate);

                                  int diff = dateTime2.difference(dateTime1).inDays;

                                  return Container(
                                    width: Get.width*.90,
                                    height: Get.height*.38,
                                    margin: EdgeInsets.only(left: Get.width*.03, right: Get.width*.03, bottom: Get.width*.02),
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
                                                  model.deleteItem(model.item!.id);
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

                                                  /*if(model.amount != null){
                                                    model.amount = model.item!.amount!;
                                                  }

                                                  if(model.nameController.text.isEmpty){
                                                    model.nameController = TextEditingController(text: model.item!.giverName);
                                                  }

                                                  if(model.loanController.text.isEmpty){
                                                    model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  }

                                                  if(model.startDateController.text.isEmpty){
                                                    model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  }

                                                  if(model.endDateController.text.isEmpty){
                                                    model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  }*/

                                                  model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  model.nameController = TextEditingController(text: model.item!.giverName);
                                                  model.amountController = TextEditingController(text: model.item!.amount!.toStringAsFixed(2));
                                                  model.amount = model.item!.amount!;

                                                  model.notifyListeners();


                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    backgroundColor: Colors.transparent,
                                                    builder: (BuildContext context) {
                                                      return BottomSheet(
                                                        onClosing: () {},
                                                        backgroundColor: ColorRes.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                                        ),
                                                        builder: (BuildContext context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext context, setState){

                                                              return SingleChildScrollView(
                                                                child: Container(
                                                                  padding: EdgeInsets.all(Get.width*.05),
                                                                  child: SingleChildScrollView(
                                                                    child: Padding(
                                                                      padding: MediaQuery.of(context).viewInsets,
                                                                      child: Column(
                                                                        children: [

                                                                          //close button
                                                                          Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: GestureDetector(
                                                                              onTap: (){
                                                                                model.amount = 0.0;
                                                                                model.startDateController.clear();
                                                                                model.amountController.clear();
                                                                                model.endDateController.clear();
                                                                                model.loanController.clear();
                                                                                model.nameController.clear();
                                                                                model.startDate = null;
                                                                                model.selectedDate = DateTime.now();
                                                                                setState((){});
                                                                                model.notifyListeners();
                                                                                Get.back();
                                                                              },
                                                                              child: const Icon(IconRes.close),
                                                                            ),
                                                                          ),

                                                                          //add loan
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.addLoan,style: appTextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),

                                                                          //select amount
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.selectamount,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          //amount displaybox
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            //margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
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
                                                                                      setState((){});
                                                                                    }else{
                                                                                      model.amount = 10000.0;
                                                                                      model.notifyListeners();
                                                                                      setState((){});
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
                                                                              setState((){});
                                                                            },
                                                                          ),

                                                                          //giver name
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              focusNode: model.nameFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.nameController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.giverName,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //loan interest
                                                                          SizedBox(height: Get.height*.03,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                              focusNode: model.loanFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.loanController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.loaninterest,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //time duration
                                                                          SizedBox(height: Get.height*.02,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.time,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          SizedBox(height: Get.height*.01,),

                                                                          //date
                                                                          Row(
                                                                            children: [

                                                                              //startdate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                        model.startDayUpdate(context,model.item!.starttime);
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
                                                                                  margin: EdgeInsets.all(Get.width*.02),
                                                                                  child: Text('to',style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                              //enddate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                          model.endDayUpdate(context, model.item!.endtime);
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
                                                                              Get.back();
                                                                              if(model.amount > 0.0 && model.nameController.text.isNotEmpty && model.loanController.text.isNotEmpty && model.startDateController.text.isNotEmpty && model.endDateController.text.isNotEmpty){
                                                                                model.updateLoanInfo(model.item!.type, model.item!.id);
                                                                              }else{
                                                                                Get.snackbar(
                                                                                  'Error',
                                                                                  'Enter All Data',
                                                                                  snackPosition: SnackPosition.TOP,
                                                                                  backgroundColor: Colors.red,
                                                                                  borderRadius: 20,
                                                                                  margin: EdgeInsets.all(Get.width/20),
                                                                                  colorText: Colors.white,
                                                                                  duration: const Duration(seconds: 4),
                                                                                  isDismissible: true,
                                                                                  dismissDirection: DismissDirection.horizontal,
                                                                                  forwardAnimationCurve: Curves.easeOutBack,
                                                                                );
                                                                              }

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
                                                                  ),

                                                                ),
                                                              );

                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                  model.notifyListeners();
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

                                              Text('\u{20B9} ${model.item!.amount!.toStringAsFixed(2)}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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

                                              Text(model.item!.giverName!,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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
                                              Text('${model.item!.interest!.toStringAsFixed(2)}%',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),
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
                                      StringRes.car,
                                      style: appTextStyle(
                                        fontSize: 25.0,
                                        textColor: ColorRes.headingColor,
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
                                    StringRes.car,
                                    style: appTextStyle(
                                      fontSize: 25.0,
                                      textColor: ColorRes.headingColor,
                                    ),
                                  ),
                                ),
                              )
                          );
                        }
                      }
                  ),
                ) :
                model.index == 4 ?
                  Expanded(
                  child: FutureBuilder(
                      future: DatabaseHelper.internal().loans(),
                      builder: (BuildContext context,AsyncSnapshot<List<LoanTable>> snapshot){
                        if(snapshot.hasData){

                          model.items = [];

                          snapshot.data!.forEach((element) {
                            if(element.type == StringRes.education){
                              model.items!.add(element);
                            }
                          });

                          if(model.items!.length > 0){



                            return ListView.builder(
                                itemCount: model.items!.length,
                                itemBuilder: (BuildContext context, int index){

                                  model.item = model.items![index];

                                  print(model.item);

                                  String firstDate = model.item!.starttime!;
                                  DateTime dateTime1 = DateTime.parse(firstDate);

                                  String lastDate = model.item!.endtime!;
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
                                                  model.deleteItem(model.item!.id);
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

                                                 /* if(model.amount != null){
                                                    model.amount = model.item!.amount!;
                                                  }

                                                  if(model.nameController.text.isEmpty){
                                                    model.nameController = TextEditingController(text: model.item!.giverName);
                                                  }

                                                  if(model.loanController.text.isEmpty){
                                                    model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  }

                                                  if(model.startDateController.text.isEmpty){
                                                    model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  }

                                                  if(model.endDateController.text.isEmpty){
                                                    model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  }
*/
                                                  model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  model.nameController = TextEditingController(text: model.item!.giverName);
                                                  model.amountController = TextEditingController(text: model.item!.amount!.toStringAsFixed(2));
                                                  model.amount = model.item!.amount!;

                                                  model.notifyListeners();

                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    backgroundColor: Colors.transparent,
                                                    builder: (BuildContext context) {
                                                      return BottomSheet(
                                                        onClosing: () {},
                                                        backgroundColor: ColorRes.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                                        ),
                                                        builder: (BuildContext context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext context, setState){

                                                              return SingleChildScrollView(
                                                                child: Container(
                                                                  padding: EdgeInsets.all(Get.width*.05),
                                                                  child: SingleChildScrollView(
                                                                    child: Padding(
                                                                      padding: MediaQuery.of(context).viewInsets,
                                                                      child: Column(
                                                                        children: [

                                                                          //close button
                                                                          Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: GestureDetector(
                                                                              onTap: (){
                                                                                model.amount = 0.0;
                                                                                model.startDateController.clear();
                                                                                model.amountController.clear();
                                                                                model.endDateController.clear();
                                                                                model.loanController.clear();
                                                                                model.nameController.clear();
                                                                                model.startDate = null;
                                                                                model.selectedDate = DateTime.now();
                                                                                setState((){});
                                                                                model.notifyListeners();
                                                                                Get.back();
                                                                              },
                                                                              child: const Icon(IconRes.close),
                                                                            ),
                                                                          ),

                                                                          //add loan
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.addLoan,style: appTextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),

                                                                          //select amount
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.selectamount,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          //amount displaybox
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            //margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
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
                                                                                      setState((){});
                                                                                    }else{
                                                                                      model.amount = 10000.0;
                                                                                      model.notifyListeners();
                                                                                      setState((){});
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
                                                                              setState((){});
                                                                            },
                                                                          ),

                                                                          //giver name
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              focusNode: model.nameFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.nameController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.giverName,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //loan interest
                                                                          SizedBox(height: Get.height*.03,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                              focusNode: model.loanFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.loanController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.loaninterest,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //time duration
                                                                          SizedBox(height: Get.height*.02,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.time,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          SizedBox(height: Get.height*.01,),

                                                                          //date
                                                                          Row(
                                                                            children: [

                                                                              //startdate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                        model.startDayUpdate(context,model.item!.starttime);
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
                                                                                  margin: EdgeInsets.all(Get.width*.02),
                                                                                  child: Text('to',style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                              //enddate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                          model.endDayUpdate(context, model.item!.endtime);
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
                                                                              Get.back();
                                                                              if(model.amount > 0.0 && model.nameController.text.isNotEmpty && model.loanController.text.isNotEmpty && model.startDateController.text.isNotEmpty && model.endDateController.text.isNotEmpty){
                                                                                model.updateLoanInfo(model.item!.type, model.item!.id);
                                                                              }else{
                                                                                Get.snackbar(
                                                                                  'Error',
                                                                                  'Enter All Data',
                                                                                  snackPosition: SnackPosition.TOP,
                                                                                  backgroundColor: Colors.red,
                                                                                  borderRadius: 20,
                                                                                  margin: EdgeInsets.all(Get.width/20),
                                                                                  colorText: Colors.white,
                                                                                  duration: const Duration(seconds: 4),
                                                                                  isDismissible: true,
                                                                                  dismissDirection: DismissDirection.horizontal,
                                                                                  forwardAnimationCurve: Curves.easeOutBack,
                                                                                );
                                                                              }

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
                                                                  ),

                                                                ),
                                                              );

                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                  model.notifyListeners();
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

                                              Text('\u{20B9} ${model.item!.amount!.toStringAsFixed(2)}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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

                                              Text(model.item!.giverName!,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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
                                              Text('${model.item!.interest!.toStringAsFixed(2)}%',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),
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
                                      StringRes.education,
                                      style: appTextStyle(
                                        fontSize: 25.0,
                                        textColor: ColorRes.headingColor,
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
                                    StringRes.education,
                                    style: appTextStyle(
                                      fontSize: 25.0,
                                      textColor: ColorRes.headingColor,
                                    ),
                                  ),
                                ),
                              )
                          );
                        }
                      }
                  ),
                ) :
                  Expanded(
                  child: FutureBuilder(
                      future: DatabaseHelper.internal().loans(),
                      builder: (BuildContext context,AsyncSnapshot<List<LoanTable>> snapshot){
                        if(snapshot.hasData){
                          model.items = [];
                          snapshot.data!.forEach((element) {
                            if(element.type == StringRes.other){
                              model.items!.add(element);
                            }
                          });
                          if(model.items!.length > 0){
                            return ListView.builder(
                                itemCount: model.items!.length,
                                itemBuilder: (BuildContext context, int index){

                                  model.item = model.items![index];
                                  print(model.item);
                                  String firstDate = model.item!.starttime!;
                                  DateTime dateTime1 = DateTime.parse(firstDate);

                                  String lastDate = model.item!.endtime!;
                                  DateTime dateTime2 = DateTime.parse(lastDate);

                                  print(firstDate+'-------------'+lastDate);

                                  int diff = dateTime2.difference(dateTime1).inDays;

                                  return Container(
                                    width: Get.width*.90,
                                    height: Get.height*.38,
                                    margin: EdgeInsets.only(left: Get.width*.03, right: Get.width*.03,bottom: Get.width*.03),
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
                                                  model.deleteItem(model.item!.id);
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

                                                  /*if(model.amount != null){
                                                    model.amount = model.item!.amount!;
                                                  }

                                                  if(model.nameController.text.isEmpty){
                                                    model.nameController = TextEditingController(text: model.item!.giverName);
                                                  }

                                                  if(model.loanController.text.isEmpty){
                                                    model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  }

                                                  if(model.startDateController.text.isEmpty){
                                                    model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  }

                                                  if(model.endDateController.text.isEmpty){
                                                    model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  }*/

                                                  model.endDateController = TextEditingController(text: model.item!.endtime);
                                                  model.startDateController = TextEditingController(text: model.item!.starttime);
                                                  model.loanController = TextEditingController(text: model.item!.interest!.toStringAsFixed(1));
                                                  model.nameController = TextEditingController(text: model.item!.giverName);
                                                  model.amountController = TextEditingController(text: model.item!.amount!.toStringAsFixed(2));
                                                  model.amount = model.item!.amount!;
                                                  model.notifyListeners();

                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    backgroundColor: Colors.transparent,
                                                    builder: (BuildContext context) {
                                                      return BottomSheet(
                                                        onClosing: () {},
                                                        backgroundColor: ColorRes.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                                        ),
                                                        builder: (BuildContext context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext context, setState){

                                                              return SingleChildScrollView(
                                                                child: Container(
                                                                  padding: EdgeInsets.all(Get.width*.05),
                                                                  child: SingleChildScrollView(
                                                                    child: Padding(
                                                                      padding: MediaQuery.of(context).viewInsets,
                                                                      child: Column(
                                                                        children: [

                                                                          //close button
                                                                          Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: GestureDetector(
                                                                              onTap: (){
                                                                                model.amount = 0.0;
                                                                                model.startDateController.clear();
                                                                                model.amountController.clear();
                                                                                model.endDateController.clear();
                                                                                model.loanController.clear();
                                                                                model.nameController.clear();
                                                                                model.startDate = null;
                                                                                model.selectedDate = DateTime.now();
                                                                                setState((){});
                                                                                model.notifyListeners();
                                                                                Get.back();
                                                                              },
                                                                              child: const Icon(IconRes.close),
                                                                            ),
                                                                          ),

                                                                          //add loan
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.addLoan,style: appTextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),

                                                                          //select amount
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.selectamount,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          //amount displaybox
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            //margin: EdgeInsets.only(right: Get.width*.05,left: Get.width*.05,bottom: Get.width*.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
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
                                                                                      setState((){});
                                                                                    }else{
                                                                                      model.amount = 10000.0;
                                                                                      model.notifyListeners();
                                                                                      setState((){});
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
                                                                              setState((){});
                                                                            },
                                                                          ),

                                                                          //giver name
                                                                          SizedBox(height: Get.height*.01,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              focusNode: model.nameFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.nameController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.giverName,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //loan interest
                                                                          SizedBox(height: Get.height*.03,),
                                                                          Container(
                                                                            width: Get.width*.9,
                                                                            height: Get.height*.07,
                                                                            padding: EdgeInsets.only(left: Get.width*0.05),
                                                                            decoration: BoxDecoration(
                                                                              color: ColorRes.background,
                                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                            ),
                                                                            child: TextField(
                                                                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                              focusNode: model.loanFocusNode,
                                                                              style: appTextStyle(textColor: ColorRes.filledText),
                                                                              controller: model.loanController,
                                                                              onTap: (){},
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: StringRes.loaninterest,
                                                                                hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          //time duration
                                                                          SizedBox(height: Get.height*.02,),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(StringRes.time,style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                          SizedBox(height: Get.height*.01,),

                                                                          //date
                                                                          Row(
                                                                            children: [

                                                                              //startdate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                        model.startDayUpdate(context,model.item!.starttime);
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
                                                                                  margin: EdgeInsets.all(Get.width*.02),
                                                                                  child: Text('to',style: appTextStyle(textColor: ColorRes.textHintColor),)),

                                                                              //enddate
                                                                              Expanded(
                                                                                  child: Container(
                                                                                    height: Get.height*.07,
                                                                                    padding: EdgeInsets.only(left: Get.width*0.05),
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.background,
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
                                                                                          model.endDayUpdate(context, model.item!.endtime);
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
                                                                              Get.back();
                                                                              if(model.amount > 0.0 && model.nameController.text.isNotEmpty && model.loanController.text.isNotEmpty && model.startDateController.text.isNotEmpty && model.endDateController.text.isNotEmpty){
                                                                                model.updateLoanInfo(model.item!.type, model.item!.id);
                                                                              }else{
                                                                                Get.snackbar(
                                                                                  'Error',
                                                                                  'Enter All Data',
                                                                                  snackPosition: SnackPosition.TOP,
                                                                                  backgroundColor: Colors.red,
                                                                                  borderRadius: 20,
                                                                                  margin: EdgeInsets.all(Get.width/20),
                                                                                  colorText: Colors.white,
                                                                                  duration: const Duration(seconds: 4),
                                                                                  isDismissible: true,
                                                                                  dismissDirection: DismissDirection.horizontal,
                                                                                  forwardAnimationCurve: Curves.easeOutBack,
                                                                                );
                                                                              }

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
                                                                  ),

                                                                ),
                                                              );

                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                  model.notifyListeners();
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

                                              Text('\u{20B9} ${model.item!.amount!.toStringAsFixed(2)}',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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

                                              Text(model.item!.giverName!,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),

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
                                              Text('${model.item!.interest!.toStringAsFixed(2)}%',style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0,fontWeight: FontWeight.w500),),
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
                                      StringRes.other,
                                      style: appTextStyle(
                                        fontSize: 25.0,
                                        textColor: ColorRes.headingColor,
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
                                    StringRes.other,
                                    style: appTextStyle(
                                      fontSize: 25.0,
                                      textColor: ColorRes.headingColor,
                                    ),
                                  ),
                                ),
                              )
                          );
                        }
                      }
                  ),
                ),
              ],
            ),

            Positioned(
              top: Get.height*.23,
              child: Container(
                width: Get.width,
                height: Get.height*.13,
                //margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03),
                child: ListView(
                  padding: EdgeInsets.all(Get.width*.01),
                  scrollDirection: Axis.horizontal,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        //home
                        GestureDetector(
                          onTap: (){
                            model.index = 1;
                            model.notifyListeners();
                          },
                          child: Container(
                            width: model.index == 1 ? Get.width*.25 : Get.width*.16,
                            height: model.index == 1 ? Get.height*.125 : Get.height*.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(model.index == 1 ? Get.width*.05 : Get.width*.03)),
                              color: ColorRes.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 7.0,
                                  spreadRadius: -2.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(right: Get.width*.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                SvgPicture.asset('images/homeloanicon.svg',width: model.index == 1 ? Get.height*.05 : Get.height*.02,height: model.index == 1 ? Get.height*.05 : Get.height*.02,color: ColorRes.headingColor,),

                                SizedBox(height: Get.width*.01,),

                                Text(StringRes.home,style: appTextStyle(textColor: ColorRes.headingColor, fontSize: model.index == 1 ? 16.0 : 10.0 ),),

                              ],
                            ),

                          ),
                        ),

                        //personal
                        GestureDetector(
                          onTap: (){
                            model.index = 2;
                            model.notifyListeners();
                          },
                          child: Container(
                            width: model.index == 2 ? Get.width*.25 : Get.width*.16,
                            height: model.index == 2 ? Get.height*.125 : Get.height*.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(model.index == 2 ? Get.width*.05 : Get.width*.03)),
                              color: ColorRes.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 7.0,
                                  spreadRadius: -2.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(right: Get.width*.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                SvgPicture.asset('images/personalloanicon.svg',width: model.index == 2 ? Get.height*.05 : Get.height*.02,height: model.index == 2 ? Get.height*.05 : Get.height*.02,color: ColorRes.headingColor,),

                                SizedBox(height: Get.width*.01,),

                                Text(StringRes.personal,style: appTextStyle(textColor: ColorRes.headingColor, fontSize: model.index == 2 ? 16.0 : 10.0 ),),

                              ],
                            ),

                          ),
                        ),

                        //car
                        GestureDetector(
                          onTap: (){
                            model.index = 3;
                            model.notifyListeners();
                          },
                          child: Container(
                            width: model.index == 3 ? Get.width*.25 : Get.width*.16,
                            height: model.index == 3 ? Get.height*.125 : Get.height*.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(model.index == 3 ? Get.width*.05 : Get.width*.03)),
                              color: ColorRes.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 7.0,
                                  spreadRadius: -2.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(right: Get.width*.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                SvgPicture.asset('images/carloanicon.svg',width: model.index == 3 ? Get.height*.05 : Get.height*.02,height: model.index == 3 ? Get.height*.05 : Get.height*.02,color: ColorRes.headingColor,),

                                SizedBox(height: Get.width*.01,),

                                Text(StringRes.car,style: appTextStyle(textColor: ColorRes.headingColor, fontSize: model.index == 3 ? 16.0 : 10.0 ),),

                              ],
                            ),

                          ),
                        ),

                        //education
                        GestureDetector(
                          onTap: (){
                            model.index = 4;
                            model.notifyListeners();
                          },
                          child: Container(
                            width: model.index == 4 ? Get.width*.25 : Get.width*.16,
                            height: model.index == 4 ? Get.height*.125 : Get.height*.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(model.index == 4 ? Get.width*.05 : Get.width*.03)),
                              color: ColorRes.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 7.0,
                                  spreadRadius: -2.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(right: Get.width*.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('images/eduloanicon.svg',width: model.index == 4 ? Get.height*.05 : Get.height*.02,height: model.index == 4 ? Get.height*.05 : Get.height*.02,color: ColorRes.headingColor,),
                                SizedBox(height: Get.width*.01,),
                                Text(StringRes.education,style: appTextStyle(textColor: ColorRes.headingColor, fontSize: model.index == 4 ? 16.0 : 10.0 ),),
                              ],
                            ),

                          ),
                        ),

                        //other
                        GestureDetector(
                          onTap: (){
                            model.index = 5;
                            model.notifyListeners();
                          },
                          child: Container(
                            width: model.index == 5 ? Get.width*.25 : Get.width*.16,
                            height: model.index == 5 ? Get.height*.125 : Get.height*.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(model.index ==5 ? Get.width*.05 : Get.width*.03)),
                              color: ColorRes.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 7.0,
                                  spreadRadius: -2.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(right: Get.width*.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconRes.add,size: model.index == 5 ? Get.height*.05 : Get.height*.02,color: ColorRes.headingColor,),
                                SizedBox(height: Get.width*.01,),
                                Text(StringRes.other,style: appTextStyle(textColor: ColorRes.headingColor, fontSize: model.index == 5 ? 16.0 : 10.0 ),),
                              ],
                            ),

                          ),
                        ),


                      ],
                    ),

                  ],
                ),
              )),

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