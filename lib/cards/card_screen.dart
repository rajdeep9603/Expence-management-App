import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/cards/card_screen_model.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/card.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardScreenModel>.reactive(viewModelBuilder: () => CardScreenModel(), builder: (context,model,child){





      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
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

                //add new loan
                GestureDetector(
                  onTap: (){

                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context){
                          return BottomSheet(
                              onClosing: () {},
                              backgroundColor: ColorRes.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                              ),
                              builder: (BuildContext context){
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

                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Get.back();
                                                      model.cardNumberController.clear();
                                                      model.cardNameController.clear();
                                                      model.dateController.clear();
                                                      model.cvvController.clear();
                                                      model.cardType = 0;
                                                      setState((){});
                                                    },
                                                    child: const Icon(IconRes.close),
                                                  ),
                                                ),

                                                //add new card
                                                SizedBox(height: Get.height*.01,),
                                                Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(StringRes.addNewCard,style: appTextStyle(),)),

                                                //name on card
                                                SizedBox(height: Get.height*.01,),
                                                Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(StringRes.nameOnCard,style: appTextStyle(textColor: ColorRes.textHintColor),)),
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
                                                    focusNode: model.cardNameFocusNode,
                                                    style: appTextStyle(textColor: ColorRes.headingColor),
                                                    controller: model.cardNameController,
                                                    onTap: (){},
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: StringRes.nameOnCard,
                                                      hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                    ),
                                                  ),
                                                ),


                                                //card type
                                                SizedBox(height: Get.height*.01,),
                                                Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(StringRes.selectCardType,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                                                SizedBox(height: Get.height*.01,),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    GestureDetector(
                                                      onTap: (){
                                                        model.cardType = 1;
                                                        setState((){});
                                                        model.notifyListeners();
                                                      },
                                                      child: Container(
                                                        width: Get.width*.15,
                                                        height: Get.height*.09,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorRes.headingColor),
                                                          //color: ColorRes.headingColor,
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        ),
                                                        child: Column(
                                                          children: [

                                                            Image.asset('images/visa.png',width: Get.width*.12,),

                                                            Container(
                                                              width: Get.width*.05,
                                                              height: Get.width*.05,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                border: Border.all(color: model.cardType == 1 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                color: model.cardType == 1 ? ColorRes.headingColor : null,
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    GestureDetector(
                                                      onTap: (){

                                                        model.cardType = 2;
                                                        setState((){});
                                                        model.notifyListeners();
                                                      },
                                                      child: Container(
                                                        width: Get.width*.15,
                                                        height: Get.height*.09,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorRes.headingColor),
                                                          //color: ColorRes.headingColor,
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        ),
                                                        child: Column(
                                                          children: [

                                                            //Image.asset('images/maestro.png',width: Get.width*.12,height: Get.width*.12,),

                                                            SizedBox(height: Get.width*.025,),

                                                            SvgPicture.asset('images/mastercard.svg',width: Get.width*.07,height: Get.width*.07,),

                                                            SizedBox(height: Get.width*.025,),
                                                            Container(
                                                              width: Get.width*.05,
                                                              height: Get.width*.05,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                border: Border.all(color: model.cardType == 2 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                color: model.cardType == 2 ? ColorRes.headingColor : null,
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    GestureDetector(
                                                      onTap: (){
                                                        model.cardType = 3;
                                                        setState((){});
                                                        model.notifyListeners();
                                                      },
                                                      child: Container(
                                                        width: Get.width*.15,
                                                        height: Get.height*.09,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorRes.headingColor),
                                                          //color: ColorRes.headingColor,
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        ),
                                                        child: Column(
                                                          children: [

                                                            Image.asset('images/discover.png',width: Get.width*.12,),

                                                            Container(
                                                              width: Get.width*.05,
                                                              height: Get.width*.05,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                border: Border.all(color: model.cardType == 3 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                color: model.cardType == 3 ? ColorRes.headingColor : null,
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    GestureDetector(
                                                      onTap: (){
                                                        model.cardType = 4;
                                                        setState((){});
                                                        model.notifyListeners();
                                                      },
                                                      child: Container(
                                                        width: Get.width*.15,
                                                        height: Get.height*.09,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorRes.headingColor),
                                                          //color: ColorRes.headingColor,
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        ),
                                                        child: Column(
                                                          children: [

                                                            Image.asset('images/jcb.png',width: Get.width*.12,),

                                                            Container(
                                                              width: Get.width*.05,
                                                              height: Get.width*.05,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                border: Border.all(color: model.cardType == 4 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                color: model.cardType == 4 ? ColorRes.headingColor : null,
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),


                                                  ],
                                                ),

                                                //card number
                                                SizedBox(height: Get.height*.01,),
                                                Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(StringRes.cardNumber,style: appTextStyle(textColor: ColorRes.textHintColor),)),
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
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly,
                                                      CustomInputFormatter()
                                                    ],
                                                    focusNode: model.cardNumberFocusNode,
                                                    maxLength: 19,
                                                    keyboardType: TextInputType.number,
                                                    style: appTextStyle(textColor: ColorRes.filledText),
                                                    controller: model.cardNumberController,
                                                    onTap: (){},
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      counterText: '',
                                                      hintText: StringRes.cardNumber,
                                                      hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(height: Get.height*.01,),

                                                //expiry & cvv
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    //expiry date
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(StringRes.expiryDate,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                                                        SizedBox(height: Get.height*.01,),

                                                        Container(
                                                          width: Get.width*.42,
                                                          height: Get.height*.07,
                                                          margin: EdgeInsets.only(right: Get.width*.025),
                                                          padding: EdgeInsets.only(left: Get.width * 0.05),
                                                          decoration: BoxDecoration(
                                                            color:ColorRes.background,
                                                            borderRadius: BorderRadius.all(Radius.circular(Get.width * .02)),
                                                          ),
                                                          child: TextField(
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly,
                                                              CustomInputFormatter2()
                                                            ],
                                                            focusNode: model.dateFocusNode,
                                                            maxLength: 5,
                                                            keyboardType:TextInputType.number,
                                                            style: appTextStyle(textColor: ColorRes.filledText),
                                                            controller: model.dateController,
                                                            onTap: (){},
                                                            decoration:
                                                            InputDecoration(
                                                              border:InputBorder.none,
                                                              counterText: '',
                                                              hintText: StringRes.expiryDate,
                                                              hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),


                                                    //cvv
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: Get.width*.025),
                                                            child: Text(StringRes.cvv,style: appTextStyle(textColor: ColorRes.textHintColor),))),
                                                        SizedBox(height: Get.height*.01,),

                                                        Container(
                                                          width: Get.width*.42,
                                                          height: Get.height * .07,
                                                          margin: EdgeInsets.only(left: Get.width*.025),
                                                          padding: EdgeInsets.only(left: Get.width * 0.05),
                                                          decoration: BoxDecoration(
                                                            color: ColorRes.background,
                                                            borderRadius: BorderRadius.all(Radius.circular(Get.width * .02)),
                                                          ),
                                                          child: TextField(
                                                            keyboardType: TextInputType.number,
                                                            focusNode: model.cvvFocusNode,
                                                            style: appTextStyle(textColor: ColorRes.filledText),
                                                            controller: model.cvvController,
                                                            onTap: () {},
                                                            maxLength: 3,
                                                            obscureText: true,
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              counterText: '',
                                                              hintText: StringRes.cvv,
                                                              hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                                                      child: Text(StringRes.saveCard,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
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

                                  }
                                );
                              }
                          );
                        }
                    );

                    /*//bottomsheet
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

                                return Container(
                                  padding: EdgeInsets.all(Get.width*.05),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [

                                        //close button
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: GestureDetector(
                                            onTap: (){
                                              model.amount = 0.0;
                                              model.startDateController.clear();
                                              model.endDateController.clear();
                                              model.loanController.clear();
                                              model.nameController.clear();
                                              model.startDate = null;
                                              model.selectedDate = DateTime.now();
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
                                          decoration: BoxDecoration(
                                            color: ColorRes.background,
                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                          ),
                                          child: Center(child: Text('\u{20B9} ${model.amount.toStringAsFixed(2)}',style: appTextStyle(fontSize: 22.0,textColor: ColorRes.filledText),)),
                                        ),

                                        //slider
                                        Slider(
                                          value: model.amount,
                                          max: 10000.0,
                                          min: 0.0,
                                          label: '${model.amount}',
                                          onChanged: (value){
                                            model.amount = value;
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
                                            model.amount = 0.0;
                                            model.startDateController.clear();
                                            model.endDateController.clear();
                                            model.loanController.clear();
                                            model.nameController.clear();
                                            model.startDate = null;
                                            model.selectedDate = DateTime.now();
                                            model.notifyListeners();
                                            Get.back();
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

                              },
                            );
                          },
                        );
                      },
                    );*/
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

            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: DatabaseHelper.internal().cards(),
                  builder: (BuildContext context,AsyncSnapshot<List<CardTable>> snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data!.length > 0){

                        snapshot.data!.forEach((element) {
                          model.backside.add(false);
                        });

                        print(snapshot.data);

                        model.data ??= snapshot.data!.first;

                        return Container(
                          margin: EdgeInsets.only(top: Get.width*.05),
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: snapshot.data!.length,
                                options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    height: Get.height*.25,
                                    autoPlay: false,
                                    autoPlayInterval: const Duration(seconds: 3),
                                    reverse: false,
                                    aspectRatio: 5.0,
                                    onPageChanged: (i,reason){
                                      print('----------${snapshot.data![i]}');
                                      model.data = snapshot.data![i];
                                      print(model.data);
                                      print(model.data!.cvv);
                                      model.notifyListeners();
                                    },
                                    enableInfiniteScroll: false,
                                ),
                                itemBuilder: (context, i, id){

                                  model.cardimg = snapshot.data![id].type!;

                                  return GestureDetector(
                                    onTap: (){
                                      if(model.backside[id] == false){
                                        model.backside[id] = true;
                                        model.notifyListeners();
                                      }else{
                                        model.backside[id] = false;
                                        model.notifyListeners();
                                      }

                                    },
                                    child: Container(
                                      width: Get.width*.8,
                                      height: Get.height*.3,
                                      decoration: BoxDecoration(
                                        image: snapshot.data![id].back == 1 ? const DecorationImage(
                                          image: AssetImage("images/card.png"),
                                          fit: BoxFit.cover,
                                        ): snapshot.data![id].back == 2 ? const DecorationImage(
                                          image: AssetImage("images/card2.png"),
                                          fit: BoxFit.cover,
                                        ): snapshot.data![id].back == 3 ? const DecorationImage(
                                          image: AssetImage("images/card3.png"),
                                          fit: BoxFit.cover,
                                        ): snapshot.data![id].back == 4 ? const DecorationImage(
                                          image: AssetImage("images/card4.png"),
                                          fit: BoxFit.cover,
                                        ): const DecorationImage(
                                          image: AssetImage("images/card5.png"),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                      ),
                                      child: model.backside[id] == false ? Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Container(
                                            margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05, top: Get.width*.05),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text('Credit Card',style: appTextStyle(textColor: ColorRes.white),),

                                                model.cardimg == 1
                                                    ?
                                                Image.asset('images/visa.png', width: Get.width*.12,)
                                                    :
                                                model.cardimg == 2
                                                    ?
                                                SvgPicture.asset('images/mastercard.svg', width: Get.width*.07, height: Get.width*.07,)
                                                    :
                                                model.cardimg == 3
                                                    ?
                                                Image.asset('images/discover.png', width: Get.width*.12,)
                                                    :
                                                Image.asset('images/jcb.png', width: Get.width*.12,),

                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text(snapshot.data![id].number!,style: appTextStyle(textColor: ColorRes.white),),
                                              ],
                                            ),
                                          ),


                                          Container(
                                            margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05, bottom: Get.width*.05),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text(snapshot.data![id].name!,style: appTextStyle(textColor: ColorRes.white),),

                                                Text(snapshot.data![id].expirydate!,style: appTextStyle(textColor: ColorRes.white),),

                                              ],
                                            ),
                                          ),



                                        ],
                                      ) : Column(
                                        children: [

                                          Container(
                                            width: Get.width*.7,
                                            height: Get.height*.05,
                                            color: ColorRes.white,
                                            margin: EdgeInsets.only(top: Get.width*.2),
                                            padding: EdgeInsets.only(right: Get.width*.03),
                                            alignment: Alignment.centerRight,
                                            child: Text(snapshot.data![id].cvv.toString(),style: appTextStyle(),),
                                          ),

                                          Container(
                                            width: Get.width,
                                            height: Get.height*.05,
                                            color: Colors.black,
                                            margin: EdgeInsets.only(top: Get.width*.02),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  
                                },
                              ),
                            ],
                          ),
                        );
                      }else{
                        return Container();
                      }
                    }else{
                      return Container();
                    }
                  },
                ),
              ),
            ),

            
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(Get.width*.05),
                child: Column(
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(StringRes.cardSetting,style: appTextStyle(fontSize: 22.0,fontWeight: FontWeight.w500),)),

                    SizedBox(height: Get.height*.01,),

                    //edit card
                    GestureDetector(
                      onTap: (){

                        if(model.data != null){
                          showModalBottomSheet(
                              isDismissible: false,
                              enableDrag: false,
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context){

                                if(model.cvvController.text.isEmpty){
                                  model.cvvController.text = model.data!.cvv.toString();
                                }

                                if(model.cardNumberController.text.isEmpty){
                                  model.cardNumberController.text = model.data!.number!;
                                }

                                if(model.cardNameController.text.isEmpty){
                                  model.cardNameController.text = model.data!.name!;
                                }

                                if(model.cardType == 0){
                                  model.cardType = model.data!.type!;
                                }

                                if(model.dateController.text.isEmpty){
                                  model.dateController.text = model.data!.expirydate!;
                                }

                                return BottomSheet(
                                    onClosing: () {
                                      model.cvvController.clear();
                                      model.cardNumberController.clear();
                                      model.cardNameController.clear();
                                      model.cardType = 0;
                                      model.dateController.clear();
                                      model.notifyListeners();
                                    },
                                    backgroundColor: ColorRes.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                    ),
                                    builder: (BuildContext context){
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

                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              Get.back();
                                                              model.cardNumberController.clear();
                                                              model.cardNameController.clear();
                                                              model.dateController.clear();
                                                              model.cvvController.clear();
                                                              model.cardType = 0;
                                                              setState((){});
                                                            },
                                                            child: const Icon(IconRes.close),
                                                          ),
                                                        ),

                                                        //add new card
                                                        SizedBox(height: Get.height*.01,),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(StringRes.editcard,style: appTextStyle(),)),

                                                        //name on card
                                                        SizedBox(height: Get.height*.01,),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(StringRes.nameOnCard,style: appTextStyle(textColor: ColorRes.textHintColor),)),
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
                                                            focusNode: model.cardNameFocusNode,
                                                            style: appTextStyle(textColor: ColorRes.headingColor),
                                                            controller: model.cardNameController,
                                                            onTap: (){},
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: StringRes.nameOnCard,
                                                              hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                            ),
                                                          ),
                                                        ),


                                                        //card type
                                                        SizedBox(height: Get.height*.01,),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(StringRes.selectCardType,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                                                        SizedBox(height: Get.height*.01,),

                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [

                                                            GestureDetector(
                                                              onTap: (){
                                                                model.cardType = 1;
                                                                setState((){});
                                                                model.notifyListeners();
                                                              },
                                                              child: Container(
                                                                width: Get.width*.15,
                                                                height: Get.height*.09,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: ColorRes.headingColor),
                                                                  //color: ColorRes.headingColor,
                                                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                                ),
                                                                child: Column(
                                                                  children: [

                                                                    Image.asset('images/visa.png',width: Get.width*.12,),

                                                                    Container(
                                                                      width: Get.width*.05,
                                                                      height: Get.width*.05,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                        border: Border.all(color: model.cardType == 1 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                        color: model.cardType == 1 ? ColorRes.headingColor : null,
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            GestureDetector(
                                                              onTap: (){

                                                                model.cardType = 2;
                                                                setState((){});
                                                                model.notifyListeners();
                                                              },
                                                              child: Container(
                                                                width: Get.width*.15,
                                                                height: Get.height*.09,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: ColorRes.headingColor),
                                                                  //color: ColorRes.headingColor,
                                                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                                ),
                                                                child: Column(
                                                                  children: [

                                                                    //Image.asset('images/maestro.png',width: Get.width*.12,height: Get.width*.12,),

                                                                    SizedBox(height: Get.width*.025,),

                                                                    SvgPicture.asset('images/mastercard.svg',width: Get.width*.07,height: Get.width*.07,),

                                                                    SizedBox(height: Get.width*.025,),
                                                                    Container(
                                                                      width: Get.width*.05,
                                                                      height: Get.width*.05,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                        border: Border.all(color: model.cardType == 2 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                        color: model.cardType == 2 ? ColorRes.headingColor : null,
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            GestureDetector(
                                                              onTap: (){
                                                                model.cardType = 3;
                                                                setState((){});
                                                                model.notifyListeners();
                                                              },
                                                              child: Container(
                                                                width: Get.width*.15,
                                                                height: Get.height*.09,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: ColorRes.headingColor),
                                                                  //color: ColorRes.headingColor,
                                                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                                ),
                                                                child: Column(
                                                                  children: [

                                                                    Image.asset('images/discover.png',width: Get.width*.12,),

                                                                    Container(
                                                                      width: Get.width*.05,
                                                                      height: Get.width*.05,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                        border: Border.all(color: model.cardType == 3 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                        color: model.cardType == 3 ? ColorRes.headingColor : null,
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            GestureDetector(
                                                              onTap: (){
                                                                model.cardType = 4;
                                                                setState((){});
                                                                model.notifyListeners();
                                                              },
                                                              child: Container(
                                                                width: Get.width*.15,
                                                                height: Get.height*.09,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: ColorRes.headingColor),
                                                                  //color: ColorRes.headingColor,
                                                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                                ),
                                                                child: Column(
                                                                  children: [

                                                                    Image.asset('images/jcb.png',width: Get.width*.12,),

                                                                    Container(
                                                                      width: Get.width*.05,
                                                                      height: Get.width*.05,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                                        border: Border.all(color: model.cardType == 4 ? ColorRes.headingColor : ColorRes.textHintColor),
                                                                        color: model.cardType == 4 ? ColorRes.headingColor : null,
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),


                                                          ],
                                                        ),

                                                        //card number
                                                        SizedBox(height: Get.height*.01,),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(StringRes.cardNumber,style: appTextStyle(textColor: ColorRes.textHintColor),)),
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
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly,
                                                              CustomInputFormatter()
                                                            ],
                                                            focusNode: model.cardNumberFocusNode,
                                                            maxLength: 19,
                                                            keyboardType: TextInputType.number,
                                                            style: appTextStyle(textColor: ColorRes.filledText),
                                                            controller: model.cardNumberController,
                                                            onTap: (){},
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              counterText: '',
                                                              hintText: StringRes.cardNumber,
                                                              hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                            ),
                                                          ),
                                                        ),

                                                        SizedBox(height: Get.height*.01,),

                                                        //expiry & cvv
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [

                                                            //expiry date
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [

                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text(StringRes.expiryDate,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                                                                SizedBox(height: Get.height*.01,),

                                                                Container(
                                                                  width: Get.width*.42,
                                                                  height: Get.height*.07,
                                                                  margin: EdgeInsets.only(right: Get.width*.025),
                                                                  padding: EdgeInsets.only(left: Get.width * 0.05),
                                                                  decoration: BoxDecoration(
                                                                    color:ColorRes.background,
                                                                    borderRadius: BorderRadius.all(Radius.circular(Get.width * .02)),
                                                                  ),
                                                                  child: TextField(
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter.digitsOnly,
                                                                      CustomInputFormatter2()
                                                                    ],
                                                                    focusNode: model.dateFocusNode,
                                                                    maxLength: 5,
                                                                    keyboardType:TextInputType.number,
                                                                    style: appTextStyle(textColor: ColorRes.filledText),
                                                                    controller: model.dateController,
                                                                    onTap: (){},
                                                                    decoration:
                                                                    InputDecoration(
                                                                      border:InputBorder.none,
                                                                      counterText: '',
                                                                      hintText: StringRes.expiryDate,
                                                                      hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),


                                                            //cvv
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [

                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Container(
                                                                        margin: EdgeInsets.only(left: Get.width*.025),
                                                                        child: Text(StringRes.cvv,style: appTextStyle(textColor: ColorRes.textHintColor),))),
                                                                SizedBox(height: Get.height*.01,),

                                                                Container(
                                                                  width: Get.width*.42,
                                                                  height: Get.height * .07,
                                                                  margin: EdgeInsets.only(left: Get.width*.025),
                                                                  padding: EdgeInsets.only(left: Get.width * 0.05),
                                                                  decoration: BoxDecoration(
                                                                    color: ColorRes.background,
                                                                    borderRadius: BorderRadius.all(Radius.circular(Get.width * .02)),
                                                                  ),
                                                                  child: TextField(
                                                                    focusNode: model.cvvFocusNode,
                                                                    keyboardType: TextInputType.number,
                                                                    style: appTextStyle(textColor: ColorRes.filledText),
                                                                    controller: model.cvvController,
                                                                    onTap: () {},
                                                                    maxLength: 3,
                                                                    obscureText: true,
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                      counterText: '',
                                                                      hintText: StringRes.cvv,
                                                                      hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(height: Get.height*.03,),

                                                        //button
                                                        GestureDetector(
                                                          onTap: (){
                                                            Get.back();
                                                            model.updatecard(model.data!.id, model.data!.back);
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
                                                              child: Text(StringRes.saveCard,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
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

                                          }
                                      );
                                    }
                                );
                              }
                          );
                        }else{
                          Get.snackbar(
                            'Error',
                            'Please Insert Card',
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
                        width: Get.width*.85,
                        height: Get.height*.1,
                        padding: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                          color: ColorRes.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Container(
                                  width: Get.width*.1,
                                  height: Get.height*.05,
                                  decoration: BoxDecoration(
                                    gradient: gredient(),
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.01)),
                                  ),
                                  child: SvgPicture.asset('images/edit.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                                ),

                                SizedBox(width: Get.width*.02,),

                                Text(StringRes.editCardDetails,style: appTextStyle(textColor: ColorRes.textHintColor),),

                              ],
                            ),

                            Icon(IconRes.inside,size: Get.width*.05,color: ColorRes.textHintColor,),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: Get.height*.02,),

                    //block card
                    GestureDetector(
                      onTap: (){

                        print(model.data);

                        if(model.data != null){
                          showModalBottomSheet(
                              isDismissible: false,
                              enableDrag: false,
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context){

                                if(model.cvvController.text.isEmpty){
                                  model.cvvController.text = model.data!.cvv.toString();
                                }

                                if(model.cardNumberController.text.isEmpty){
                                  model.cardNumberController.text = model.data!.number!;
                                }

                                if(model.cardNameController.text.isEmpty){
                                  model.cardNameController.text = model.data!.name!;
                                }

                                if(model.cardType == 0){
                                  model.cardType = model.data!.type!;
                                }

                                if(model.dateController.text.isEmpty){
                                  model.dateController.text = model.data!.expirydate!;
                                }

                                return BottomSheet(
                                    onClosing: () {
                                      model.cvvController.clear();
                                      model.cardNumberController.clear();
                                      model.cardNameController.clear();
                                      model.cardType = 0;
                                      model.dateController.clear();
                                      model.notifyListeners();
                                    },
                                    backgroundColor: ColorRes.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                    ),
                                    builder: (BuildContext context){
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

                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              Get.back();
                                                              model.cardNumberController.clear();
                                                              model.cardNameController.clear();
                                                              model.dateController.clear();
                                                              model.cvvController.clear();
                                                              model.cardType = 0;
                                                              setState((){});
                                                            },
                                                            child: const Icon(IconRes.close),
                                                          ),
                                                        ),

                                                        //add new card
                                                        SizedBox(height: Get.height*.01,),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(StringRes.blockCard,style: appTextStyle(),)),

                                                        SizedBox(height: Get.height*.03,),

                                                        //card
                                                        Container(
                                                          width: Get.width*.8,
                                                          height: Get.height*.25,
                                                          decoration: BoxDecoration(
                                                            image: model.data!.back == 1 ? const DecorationImage(
                                                              image: AssetImage("images/card.png"),
                                                              fit: BoxFit.cover,
                                                            ): model.data!.back == 2 ? const DecorationImage(
                                                              image: AssetImage("images/card2.png"),
                                                              fit: BoxFit.cover,
                                                            ): model.data!.back == 3 ? const DecorationImage(
                                                              image: AssetImage("images/card3.png"),
                                                              fit: BoxFit.cover,
                                                            ): model.data!.back == 4 ? const DecorationImage(
                                                              image: AssetImage("images/card4.png"),
                                                              fit: BoxFit.cover,
                                                            ): const DecorationImage(
                                                              image: AssetImage("images/card5.png"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              Container(
                                                                margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05, top: Get.width*.05),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [

                                                                    Text('Credit Card',style: appTextStyle(textColor: ColorRes.white),),

                                                                    model.cardimg == 1
                                                                        ?
                                                                    Image.asset('images/visa.png', width: Get.width*.12,)
                                                                        :
                                                                    model.cardimg == 2
                                                                        ?
                                                                    SvgPicture.asset('images/mastercard.svg', width: Get.width*.07, height: Get.width*.07,)
                                                                        :
                                                                    model.cardimg == 3
                                                                        ?
                                                                    Image.asset('images/discover.png', width: Get.width*.12,)
                                                                        :
                                                                    Image.asset('images/jcb.png', width: Get.width*.12,),

                                                                  ],
                                                                ),
                                                              ),

                                                              Container(
                                                                margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [

                                                                    Text(model.data!.number!,style: appTextStyle(textColor: ColorRes.white),),
                                                                  ],
                                                                ),
                                                              ),


                                                              Container(
                                                                margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05, bottom: Get.width*.05),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [

                                                                    Text(model.data!.name!,style: appTextStyle(textColor: ColorRes.white),),

                                                                    Text(model.data!.expirydate!,style: appTextStyle(textColor: ColorRes.white),),

                                                                  ],
                                                                ),
                                                              ),



                                                            ],
                                                          ),
                                                        ),


                                                        SizedBox(height: Get.height*.03,),

                                                        //button
                                                        GestureDetector(
                                                          onTap: (){
                                                            Get.back();
                                                            model.deletecard(model.data!.id);
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
                                                              child: Text(StringRes.blockCard,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
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

                                          }
                                      );
                                    }
                                );
                              }
                          );
                        }else{
                          Get.snackbar(
                            'Error',
                            'Please Insert Card',
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
                        width: Get.width*.85,
                        height: Get.height*.1,
                        padding: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                          color: ColorRes.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Container(
                                  width: Get.width*.1,
                                  height: Get.height*.05,
                                  decoration: BoxDecoration(
                                    gradient: gredient(),
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.01)),
                                  ),
                                  child: SvgPicture.asset('images/blockcard.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                                ),

                                SizedBox(width: Get.width*.02,),

                                Text(StringRes.blockCard,style: appTextStyle(textColor: ColorRes.textHintColor),),

                              ],
                            ),

                            Icon(IconRes.inside,size: Get.width*.05,color: ColorRes.textHintColor,),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: Get.height*.02,),

                    //change theme
                    GestureDetector(
                      onTap: (){

                        if(model.data != null){
                          showModalBottomSheet(
                              isDismissible: false,
                              enableDrag: false,
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context){

                                if(model.cvvController.text.isEmpty){
                                  model.cvvController.text = model.data!.cvv.toString();
                                }

                                if(model.cardNumberController.text.isEmpty){
                                  model.cardNumberController.text = model.data!.number!;
                                }

                                if(model.cardNameController.text.isEmpty){
                                  model.cardNameController.text = model.data!.name!;
                                }

                                if(model.cardType == 0){
                                  model.cardType = model.data!.type!;
                                  model.cardback = model.data!.back!;
                                }

                                if(model.dateController.text.isEmpty){
                                  model.dateController.text = model.data!.expirydate!;
                                }

                                return BottomSheet(
                                    onClosing: () {
                                      model.cvvController.clear();
                                      model.cardNumberController.clear();
                                      model.cardNameController.clear();
                                      model.cardType = 0;
                                      model.dateController.clear();
                                      model.notifyListeners();
                                    },
                                    backgroundColor: ColorRes.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                                    ),
                                    builder: (BuildContext context){
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

                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              Get.back();
                                                              model.cardNumberController.clear();
                                                              model.cardNameController.clear();
                                                              model.dateController.clear();
                                                              model.cvvController.clear();
                                                              model.cardType = 0;
                                                              setState((){});
                                                            },
                                                            child: const Icon(IconRes.close),
                                                          ),
                                                        ),

                                                        //add new card
                                                        SizedBox(height: Get.height*.01,),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(StringRes.changeCardTheme,style: appTextStyle(),)),

                                                        SizedBox(height: Get.height*.03,),

                                                        Row(
                                                          children: [

                                                            Container(
                                                              width: Get.width*.75,
                                                              height: Get.height*.25,
                                                              decoration: BoxDecoration(
                                                                image: model.cardback == 1 ? const DecorationImage(
                                                                  image: AssetImage("images/card.png"),
                                                                  fit: BoxFit.cover,
                                                                ): model.cardback == 2 ? const DecorationImage(
                                                                  image: AssetImage("images/card2.png"),
                                                                  fit: BoxFit.cover,
                                                                ):model.cardback == 3 ? const DecorationImage(
                                                                  image: AssetImage("images/card3.png"),
                                                                  fit: BoxFit.cover,
                                                                ):model.cardback == 4 ? const DecorationImage(
                                                                  image: AssetImage("images/card4.png"),
                                                                  fit: BoxFit.cover,
                                                                ):const DecorationImage(
                                                                  image: AssetImage("images/card5.png"),
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [

                                                                  Container(
                                                                    margin: EdgeInsets.only(left: Get.width*.03, right: Get.width*.03, top: Get.width*.03),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [

                                                                        Text('Credit Card',style: appTextStyle(textColor: ColorRes.white),),

                                                                        model.cardimg == 1
                                                                            ?
                                                                        Image.asset('images/visa.png', width: Get.width*.12,)
                                                                            :
                                                                        model.cardimg == 2
                                                                            ?
                                                                        SvgPicture.asset('images/mastercard.svg', width: Get.width*.07, height: Get.width*.07,)
                                                                            :
                                                                        model.cardimg == 3
                                                                            ?
                                                                        Image.asset('images/discover.png', width: Get.width*.12,)
                                                                            :
                                                                        Image.asset('images/jcb.png', width: Get.width*.12,),

                                                                      ],
                                                                    ),
                                                                  ),

                                                                  Container(
                                                                    margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [

                                                                        Text(model.data!.number!,style: appTextStyle(textColor: ColorRes.white),),
                                                                      ],
                                                                    ),
                                                                  ),


                                                                  Container(
                                                                    margin: EdgeInsets.only(left: Get.width*.05, right: Get.width*.05, bottom: Get.width*.05),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [

                                                                        Text(model.data!.name!,style: appTextStyle(textColor: ColorRes.white),),

                                                                        Text(model.data!.expirydate!,style: appTextStyle(textColor: ColorRes.white),),

                                                                      ],
                                                                    ),
                                                                  ),



                                                                ],
                                                              ),
                                                            ),

                                                            SizedBox(width: Get.width*.05,),

                                                            Container(
                                                              width: Get.width*.1,
                                                              height: Get.height*.25,
                                                              padding: EdgeInsets.only(top: Get.width*.01),
                                                              decoration: BoxDecoration(
                                                                color: ColorRes.background,
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [

                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      model.cardback = 1;
                                                                      setState((){});
                                                                      model.notifyListeners();
                                                                    },
                                                                    child: Container(
                                                                      width: Get.width*.08,
                                                                      height: Get.height*.04,
                                                                      padding: EdgeInsets.all(Get.width*.002),
                                                                      decoration: BoxDecoration(
                                                                        border: model.cardback == 1 ? Border.all(color: ColorRes.headingColor) : Border.all(color: Colors.transparent),
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                      ),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                        child: Image.asset('images/card.png',fit: BoxFit.cover,)),
                                                                    ),
                                                                  ),

                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      print('2');
                                                                      model.cardback = 2;
                                                                      print(model.cardback);
                                                                      setState((){});
                                                                      model.notifyListeners();
                                                                    },
                                                                    child: Container(
                                                                      width: Get.width*.08,
                                                                      height: Get.height*.04,
                                                                      padding: EdgeInsets.all(Get.width*.002),
                                                                      decoration: BoxDecoration(
                                                                        border: model.cardback == 2 ? Border.all(color: ColorRes.headingColor) : Border.all(color: Colors.transparent),
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                      ),
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                          child: Image.asset('images/card2.png',fit: BoxFit.cover,)),
                                                                    ),
                                                                  ),

                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      model.cardback = 3;
                                                                      setState((){});
                                                                      model.notifyListeners();
                                                                    },
                                                                    child: Container(
                                                                      width: Get.width*.08,
                                                                      height: Get.height*.04,
                                                                      padding: EdgeInsets.all(Get.width*.002),
                                                                      decoration: BoxDecoration(
                                                                        border: model.cardback == 3 ? Border.all(color: ColorRes.headingColor) : Border.all(color: Colors.transparent),
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                      ),
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                          child: Image.asset('images/card3.png',fit: BoxFit.cover,)),
                                                                    ),
                                                                  ),

                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      model.cardback = 4;
                                                                      setState((){});
                                                                      model.notifyListeners();
                                                                    },
                                                                    child: Container(
                                                                      width: Get.width*.08,
                                                                      height: Get.height*.04,
                                                                      padding: EdgeInsets.all(Get.width*.002),
                                                                      decoration: BoxDecoration(
                                                                        border: model.cardback == 4 ? Border.all(color: ColorRes.headingColor) : Border.all(color: Colors.transparent),
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                      ),
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                          child: Image.asset('images/card4.png',fit: BoxFit.cover,)),
                                                                    ),
                                                                  ),

                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      model.cardback = 5;
                                                                      setState((){});
                                                                      model.notifyListeners();
                                                                    },
                                                                    child: Container(
                                                                      width: Get.width*.08,
                                                                      height: Get.height*.04,
                                                                      padding: EdgeInsets.all(Get.width*.002),
                                                                      decoration: BoxDecoration(
                                                                        border: model.cardback == 5 ? Border.all(color: ColorRes.headingColor) : Border.all(color: Colors.transparent),
                                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                      ),
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                                          child: Image.asset('images/card5.png',fit: BoxFit.cover,)),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(height: Get.height*.03,),

                                                        //button
                                                        GestureDetector(
                                                          onTap: (){
                                                            Get.back();
                                                            model.changecardtheme(model.data!.id);
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
                                                              child: Text(StringRes.saveChange,style: appTextStyle(fontSize: 20.0,textColor: ColorRes.white),),
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

                                          }
                                      );
                                    }
                                );
                              }
                          );
                        }else{
                          Get.snackbar(
                            'Error',
                            'Please Insert Card',
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
                        width: Get.width*.85,
                        height: Get.height*.1,
                        padding: EdgeInsets.only(left: Get.width*.05,right: Get.width*.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                          color: ColorRes.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Container(
                                  width: Get.width*.1,
                                  height: Get.height*.05,
                                  decoration: BoxDecoration(
                                    gradient: gredient(),
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.01)),
                                  ),
                                  child: SvgPicture.asset('images/theme.svg',color: ColorRes.white,fit: BoxFit.scaleDown,),
                                ),

                                SizedBox(width: Get.width*.02,),

                                Text(StringRes.changeCardTheme,style: appTextStyle(textColor: ColorRes.textHintColor),),

                              ],
                            ),

                            Icon(IconRes.inside,size: Get.width*.05,color: ColorRes.textHintColor,),

                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),

          ],
        ),
      );
    });
  }
}



class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length)
    );
  }
}

class CustomInputFormatter2 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length)
    );
  }
}

