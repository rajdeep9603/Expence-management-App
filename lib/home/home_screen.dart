import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/cards/card_screen.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/expense/expense_screen.dart';
import 'package:personal_expenses/expense/updateexpense/update_expense_screen.dart';
import 'package:personal_expenses/group/group_screen.dart';
import 'package:personal_expenses/history/history_screen.dart';

import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/income/income_screen.dart';
import 'package:personal_expenses/income/updateincomescreen/update_income_screen.dart';
import 'package:personal_expenses/loan/loan_screen.dart';
import 'package:personal_expenses/login/login_screen.dart';
import 'package:personal_expenses/profile/bankdetails/bank_details_screen.dart';
import 'package:personal_expenses/profile/profile_home_screen.dart';
import 'package:personal_expenses/receive/receive_screen.dart';
import 'package:personal_expenses/send/send_screen.dart';
import 'package:personal_expenses/sink/sink_old_data_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import "package:collection/collection.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenModel>.reactive(
      onModelReady: (model){
        model.init();
      },
      viewModelBuilder: () => HomeScreenModel(), builder: (context,model,child){
      return WillPopScope(
        onWillPop: ()async{
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorRes.background,
          body: Column(
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

                    //profile
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            model.show == true
                                ?
                            GestureDetector(
                              onTap: (){
                                if(model.show == false){
                                  model.show = true;
                                  model.notifyListeners();
                                }else{
                                  model.show = false;
                                  model.notifyListeners();
                                }
                              },
                              child: Container(
                                width: Get.width*.35,
                                height: Get.width*.125,
                                decoration: BoxDecoration(
                                  gradient: amountcard(),
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                ),
                                margin: EdgeInsets.only(top: Get.height*.06),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    SizedBox(width: Get.width*.02,),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Align(
                                            alignment: Alignment.center,
                                            child: Text(model.total > 100000.0 || model.total < -100000.0? '\u{20B9} ${(model.total/100000).toStringAsFixed(1)} Lac': model.total > 1000.0 || model.total < -1000.0? '\u{20B9} ${(model.total/1000).toStringAsFixed(1)} k': '\u{20B9} ${model.total.toStringAsFixed(2)}',style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),

                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                                //padding: EdgeInsets.only(top: Get.width*.02),
                                                child: Text('balance',style: appTextStyle(fontSize: 8.0,textColor: ColorRes.white),))),

                                      ],
                                    ),

                                    Expanded(child: Container()),


                                  ],
                                ),
                              ),
                            )
                                :
                            GestureDetector(
                              onTap: (){
                                if(model.show == false){
                                  model.show = true;
                                  model.notifyListeners();
                                }else{
                                  model.show = false;
                                  model.notifyListeners();
                                }
                              },
                              child: Container(
                                width: Get.width*.06,
                                height: Get.width*.125,
                                decoration: BoxDecoration(
                                  gradient: amountcard(),
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                ),
                                margin: EdgeInsets.only(top: Get.height*.06),
                                child: const Center(child: Icon(IconRes.inside,color: ColorRes.white,),),
                              ),
                            ),

                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                children: [

                                  GestureDetector(
                                    onTap: (){
                                      if(randomid.isNotEmpty){
                                        Get.to(() => const SinkDataScreen());
                                      }else{
                                        Get.snackbar(
                                          'Error',
                                          'For Sync data you need to login.',
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
                                      width: Get.width*.125,
                                      height: Get.width*.125,
                                      margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.04),
                                      child: const Icon(IconRes.sink,color: ColorRes.headingColor,),
                                      decoration: BoxDecoration(
                                        color: ColorRes.white,
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.1)),
                                      ),
                                    ),
                                  ),

                                  //SizedBox(width: Get.width*.05,),

                                  GestureDetector(
                                    onTap: (){
                                      Get.to(() => const ProfileHomeScreen());
                                    },
                                    child: Container(
                                      width: Get.width*.125,
                                      height: Get.width*.125,
                                      margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                      child: model.result != null ? ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10.0)),child: Image.memory(model.result!,fit: BoxFit.cover,)) :Image.asset('images/user.png',fit: BoxFit.cover,),
                                      decoration: const BoxDecoration(
                                        color: ColorRes.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ],
                    ),

                    //7 icon
                    Container(
                      margin: EdgeInsets.all(Get.width*.03),
                      child: Column(
                        children: [

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(() => const ExpenseScreen());
                                      },
                                      child: Container(
                                        width: Get.width*.125,
                                        height: Get.width*.125,
                                        margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                        child: SvgPicture.asset('images/expenseicon.svg',fit: BoxFit.scaleDown),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(right: Get.width*.07),
                                      child: Text(StringRes.expense,style: appTextStyle(textColor: ColorRes.white,fontSize: 12.0),)),

                                  ],
                                ),


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        Get.to(() => const IncomeScreen());
                                      },
                                      child: Container(
                                        width: Get.width*.125,
                                        height: Get.width*.125,
                                        margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                        child: SvgPicture.asset('images/income.svg',fit: BoxFit.scaleDown,),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(right: Get.width*.07),
                                      child: Text(StringRes.income,style: appTextStyle(textColor: ColorRes.white,fontSize: 12.0),)),
                                  ],
                                ),


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        Get.to(() => const LoanScreen());
                                      },
                                      child: Container(
                                        width: Get.width*.125,
                                        height: Get.width*.125,
                                        margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                        child: SvgPicture.asset('images/loanicon.svg',fit: BoxFit.scaleDown,),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(right: Get.width*.07),
                                      child: Text(StringRes.loan,style: appTextStyle(textColor: ColorRes.white,fontSize: 12.0),)),

                                  ],
                                ),


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        Get.to(() => const BankDetailsScreen());
                                      },
                                      child: Container(
                                        width: Get.width*.125,
                                        height: Get.width*.125,
                                        margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                        child: SvgPicture.asset('images/bankicon.svg',fit: BoxFit.scaleDown,),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(right: Get.width*.07),
                                      child: Text(StringRes.bankHome,style: appTextStyle(textColor: ColorRes.white,fontSize: 12.0),)),
                                  ],
                                ),


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        Get.to(() => const GroupScreen());
                                      },
                                      child: Container(
                                        width: Get.width*.125,
                                        height: Get.width*.125,
                                        margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                        child: SvgPicture.asset('images/groupicon.svg',fit: BoxFit.scaleDown,),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(right: Get.width*.07),
                                      child: Text(StringRes.groupHome,style: appTextStyle(textColor: ColorRes.white,fontSize: 12.0),)),

                                  ],
                                ),


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        Get.to(() => const SendScreen());
                                      },
                                      child: Container(
                                        width: Get.width*.125,
                                        height: Get.width*.125,
                                        margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                        child: SvgPicture.asset('images/sendicon.svg',fit: BoxFit.scaleDown,),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(right: Get.width*.07),
                                      child: Text(StringRes.send,style: appTextStyle(textColor: ColorRes.white,fontSize: 12.0),)),

                                  ],
                                ),


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        Get.to(() => const ReceiveScreen());
                                      },
                                      child: Container(
                                        width: Get.width*.125,
                                        height: Get.width*.125,
                                        margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                                        child: SvgPicture.asset('images/requesticon.svg',fit: BoxFit.scaleDown,),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white,
                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(right: Get.width*.07),
                                      child: Text(StringRes.receive,style: appTextStyle(textColor: ColorRes.white,fontSize: 12.0),)),

                                  ],
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: Get.height*.03,),

              //recent transaction
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    margin: EdgeInsets.only(left: Get.width*.05),
                    child: Text(StringRes.recent,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 22.0,fontWeight: FontWeight.w500),)),

                  GestureDetector(
                    onTap: (){
                      Get.to(()=>const HistoryScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: Get.width*.05),
                      child: Row(
                        children: [
                          Text('See all',style: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 12.0),),
                          SizedBox(width: Get.width*.02,),
                          const Icon(IconRes.inside,color: ColorRes.textHintColor,size: 12.0,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Get.width*.01,),
              Row(
                children: [

                  GestureDetector(
                    onTap: (){
                      Get.to(() => const HistoryScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.05),
                      width: Get.width*.10,
                      height: Get.height*.02,
                      decoration: BoxDecoration(
                        color: ColorRes.headingColor,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                      ),
                      child: Center(child: Text('All',style: appTextStyle(textColor: ColorRes.white,fontSize: 11.0),)),
                    ),
                  ),

                  //SizedBox(width: Get.width*.01,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const IncomeScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.01),
                      width: Get.width*.15,
                      height: Get.height*.02,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                      ),
                      child: Center(child: Text(StringRes.income,style: appTextStyle(textColor: ColorRes.white,fontSize: 11.0),)),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Get.to(() => const ExpenseScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width*.01),
                      width: Get.width*.15,
                      height: Get.height*.02,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                      ),
                      child: Center(child: Text(StringRes.expense,style: appTextStyle(textColor: ColorRes.white,fontSize: 11.0),)),
                    ),
                  ),

                ],
              ),

              //body
              Expanded(
                child: FutureBuilder(
                  future: DatabaseHelper.internal().transactions(),
                  builder: (BuildContext context,AsyncSnapshot<List<TransactionTable>> snapshot){
                    if(snapshot.hasData){

                      if(snapshot.data!.length > 0){

                        model.totalexpense = 0.0;
                        model.totalincome = 0.0;

                        List<Map> data = [];
                        snapshot.data!.forEach((element) {
                          data.add(element.toMap());
                        });

                        var newMap = groupBy(data, (Map obj) => obj['entrydate']);
                        var _listkeys = newMap.keys.toList();
                        var _listvalue = newMap.values.toList();

                        _listkeys.sort((a, b){
                          return DateTime.parse(b).compareTo(DateTime.parse(a));
                        });

                        return  ListView.builder(
                          itemCount: newMap.values.length,
                          itemBuilder: (context,index){
                            var newlist = [];
                            _listvalue.forEach((element) {
                              element.forEach((el) {
                                if(el['entrydate'] == _listkeys[index]){
                                  newlist.add(el);
                                }
                              });
                            });



                            //DateTime d = DateTime.parse(newlist.first['entrydate']);
                            DateTime d1 = DateTime.parse(newlist.first['entrydate']);
                            final now = DateTime.now();
                            final now3 = DateTime(now.year, now.month - 1, now.day);
                            final now1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                            final now2 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 1));
                            //final now3 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 30));
                            String d20 = DateFormat.d().format(d1);
                            String d30 = DateFormat.MMM().format(d1);



                            return Column(
                              children: [

                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(margin: EdgeInsets.only(left: Get.width*.05,bottom: Get.width*.01),child: Text(newlist.first['entrydate'] == now1?'Today':newlist.first['entrydate']== now2? 'Yesterday':'$d20 $d30',style: appTextStyle(textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),))),

                                Container(
                                  width: Get.width*.9,
                                  //height: Get.height*.1,
                                  padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                                  margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                                  decoration: BoxDecoration(
                                    color: ColorRes.white,
                                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                  ),
                                  child: Center(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                        itemCount: newlist.length,
                                        itemBuilder: (context, int i){

                                          DateTime d1 = DateTime.parse(newlist[i]['date']);

                                          String d2 = DateFormat.d().format(d1);
                                          String d3 = DateFormat.MMM().format(d1);


                                          print('------------${newlist[i]['typeid']}');


                                         if(newlist[i]['type'] == StringRes.expense){
                                           if(d1.isAfter(now3)){
                                             model.totalexpense = model.totalexpense + newlist[i]['price'];
                                             model.total = model.totalincome - model.totalexpense;
                                             //model.notifyListeners();
                                           }
                                         }else{
                                           if(d1.isAfter(now3)){
                                             model.totalincome = model.totalincome + newlist[i]['price'];
                                             model.total = model.totalincome - model.totalexpense;
                                             //model.notifyListeners();
                                           }
                                         }

                                          if(newlist.length >1){
                                            if((i+1) == newlist.length){
                                              return SwipeActionCell(
                                                key: ObjectKey(newlist[i]),
                                                backgroundColor: Colors.transparent,
                                                firstActionWillCoverAllSpaceOnDeleting: true,
                                                selectedForegroundColor: ColorRes.headingColor,
                                                trailingActions: <SwipeAction>[
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      if(newlist[i]['typeid'] == 1 || newlist[i]['typeid'] == 2){
                                                        await handler(true);
                                                        int r = await model.db.deleteTransaction(newlist[i]['id']);
                                                        if(r > 0){
                                                          Get.offAll(() => const HomeScreen());
                                                        }
                                                      }
                                                      else if(newlist[i]['typeid'] == 3){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to loan',
                                                          'You can not delete from here',
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
                                                      else if(newlist[i]['typeid'] == 4){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to Send',
                                                          'You can not delete from here',
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
                                                      else if(newlist[i]['typeid'] == 5){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to Receive',
                                                          'You can not delete from here',
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
                                                      else if(newlist[i]['typeid'] == 6){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to Group',
                                                          'You can not delete from here',
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
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        color: Colors.red,
                                                      ),
                                                      child: const Icon(
                                                        IconRes.delete,
                                                        color: ColorRes.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      if(newlist[i]['typeid'] == 1){
                                                        Get.to(() => UpdateIncomeScreen(newList: newlist[i],));
                                                      }
                                                      else if(newlist[i]['typeid'] == 2){
                                                        Get.to(() => UpdateExpenseScreen(newList: newlist[i],));
                                                      }
                                                      else if(newlist[i]['typeid'] == 3){
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to loan Section for edit',
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
                                                      else if(newlist[i]['typeid'] == 4){
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to Send Section for edit',
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
                                                      else if(newlist[i]['typeid'] == 5){
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to Receive Section for edit',
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
                                                      else if(newlist[i]['typeid'] == 6){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to Group Section for edit',
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
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        color: Colors.lightGreenAccent,
                                                      ),
                                                      child: const Icon(
                                                        IconRes.edit,
                                                        color: ColorRes.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                child: Column(
                                                children: [

                                                  SizedBox(height: Get.width*.03,),

                                                  Row(
                                                    children: [

                                                      Container(
                                                        width: Get.width*.15,
                                                        height: Get.height*.07,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            //SizedBox(height: Get.height*.01,),
                                                            Container(
                                                              width: Get.width*.1,
                                                              height: Get.height*.05,
                                                              //margin: EdgeInsets.only(left: Get.width*.05),
                                                              decoration: BoxDecoration(
                                                                color: ColorRes.headingColor,
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                              ),
                                                              child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                                            ),

                                                            Container(
                                                              //margin: EdgeInsets.only(left: Get.width*.0),
                                                                child: Text(newlist[i]['typeid'] == 1 ? StringRes.income : newlist[i]['typeid'] == 2 ? StringRes.expense: newlist[i]['typeid'] == 3 ? StringRes.loan : newlist[i]['typeid'] == 4 ? StringRes.send : newlist[i]['typeid'] == 5 ? StringRes.receive : StringRes.groupHome,style: appTextStyle(fontSize: 8.0,textColor: ColorRes.textHintColor),)),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(width: Get.width*.05,),

                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                            Text('${newlist[i]['subtitle'].toString()}',style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                          ],
                                                        ),
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(right: Get.width*.05),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text('\u{20B9} ${newlist[i]['price'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: newlist[i]['type'] == StringRes.expense ? Colors.red :Colors.green,fontWeight: FontWeight.w500),),

                                                            SizedBox(height: Get.height*.005,),
                                                            Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                          ],
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ],
                                            ),
                                              );
                                            }else{
                                              return SwipeActionCell(
                                                key: ObjectKey(newlist[i]),
                                                backgroundColor: Colors.transparent,
                                                firstActionWillCoverAllSpaceOnDeleting: true,
                                                selectedForegroundColor: ColorRes.headingColor,
                                                trailingActions: <SwipeAction>[
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      if(newlist[i]['typeid'] == 1 || newlist[i]['typeid'] == 2){
                                                        await handler(true);
                                                        int r = await model.db.deleteTransaction(newlist[i]['id']);
                                                        if(r > 0){
                                                          Get.offAll(() => const HomeScreen());
                                                        }
                                                      }
                                                      else if(newlist[i]['typeid'] == 3){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to loan',
                                                          'You can not delete from here',
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
                                                      else if(newlist[i]['typeid'] == 4){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to Send',
                                                          'You can not delete from here',
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
                                                      else if(newlist[i]['typeid'] == 5){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to Receive',
                                                          'You can not delete from here',
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
                                                      else if(newlist[i]['typeid'] == 6){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Go to Group',
                                                          'You can not delete from here',
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
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        color: Colors.red,
                                                      ),
                                                      child: const Icon(
                                                        IconRes.delete,
                                                        color: ColorRes.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SwipeAction(
                                                    onTap: (CompletionHandler handler) async {
                                                      await handler(false);

                                                      if(newlist[i]['typeid'] == 1){
                                                        Get.to(() => UpdateIncomeScreen(newList: newlist[i],));
                                                      }
                                                      else if(newlist[i]['typeid'] == 2){
                                                        Get.to(() => UpdateExpenseScreen(newList: newlist[i],));
                                                      }
                                                      else if(newlist[i]['typeid'] == 3){
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to loan Section for edit',
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
                                                      else if(newlist[i]['typeid'] == 4){
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to Send Section for edit',
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
                                                      else if(newlist[i]['typeid'] == 5){
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to Receive Section for edit',
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
                                                      else if(newlist[i]['typeid'] == 6){
                                                        await handler(false);
                                                        Get.snackbar(
                                                          'Opps...',
                                                          'Go to Group Section for edit',
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
                                                    widthSpace: Get.width*.15,
                                                    color: Colors.transparent,
                                                    content: Container(
                                                      width: Get.width*.13,
                                                      height: Get.height*.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                        color: Colors.lightGreenAccent,
                                                      ),
                                                      child: const Icon(
                                                        IconRes.edit,
                                                        color: ColorRes.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                child: Column(
                                                  children: [
                                                    Row(
                                                    children: [

                                                      Container(
                                                        width: Get.width*.15,
                                                        height: Get.height*.08,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(height: Get.height*.01,),
                                                            Container(
                                                              width: Get.width*.1,
                                                              height: Get.height*.05,
                                                              //margin: EdgeInsets.only(left: Get.width*.05),
                                                              decoration: BoxDecoration(
                                                                color: ColorRes.headingColor,
                                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                              ),
                                                              child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                                            ),

                                                            Container(
                                                              //margin: EdgeInsets.only(left: Get.width*.0),
                                                                child: Text(newlist[i]['typeid'] == 1 ? StringRes.income : newlist[i]['typeid'] == 2 ? StringRes.expense: newlist[i]['typeid'] == 3 ? StringRes.loan : newlist[i]['typeid'] == 4 ? StringRes.send : newlist[i]['typeid'] == 5 ? StringRes.receive : StringRes.groupHome,style: appTextStyle(fontSize: 8.0,textColor: ColorRes.textHintColor),)),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(width: Get.width*.05,),

                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                            Text('${newlist[i]['subtitle'].toString()}',style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                          ],
                                                        ),
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(right: Get.width*.05),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text('\u{20B9} ${newlist[i]['price'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: newlist[i]['type'] == StringRes.expense ? Colors.red :Colors.green,fontWeight: FontWeight.w500),),

                                                            SizedBox(height: Get.height*.005,),
                                                            Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                          ],
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                    SizedBox(height: Get.width*.03,),
                                                    Divider(height: Get.width*.01,),
                                                  ],
                                                ),
                                              );
                                            }
                                          }else{
                                            return SwipeActionCell(
                                              key: ObjectKey(newlist[i]),
                                              backgroundColor: Colors.transparent,
                                              firstActionWillCoverAllSpaceOnDeleting: true,
                                              selectedForegroundColor: ColorRes.headingColor,
                                              trailingActions: <SwipeAction>[
                                                SwipeAction(
                                                  onTap: (CompletionHandler handler) async {
                                                    if(newlist[i]['typeid'] == 1 || newlist[i]['typeid'] == 2){
                                                      await handler(true);
                                                      int r = await model.db.deleteTransaction(newlist[i]['id']);
                                                      if(r > 0){
                                                        Get.offAll(() => const HomeScreen());
                                                      }
                                                    }
                                                    else if(newlist[i]['typeid'] == 3){
                                                      await handler(false);
                                                      Get.snackbar(
                                                        'Go to loan',
                                                        'You can not delete from here',
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
                                                    else if(newlist[i]['typeid'] == 4){
                                                      await handler(false);
                                                      Get.snackbar(
                                                        'Go to Send',
                                                        'You can not delete from here',
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
                                                    else if(newlist[i]['typeid'] == 5){
                                                      await handler(false);
                                                      Get.snackbar(
                                                        'Go to Receive',
                                                        'You can not delete from here',
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
                                                    else if(newlist[i]['typeid'] == 6){
                                                      await handler(false);
                                                      Get.snackbar(
                                                        'Go to Group',
                                                        'You can not delete from here',
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
                                                  widthSpace: Get.width*.15,
                                                  color: Colors.transparent,
                                                  content: Container(
                                                    width: Get.width*.13,
                                                    height: Get.height*.06,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                      color: Colors.red,
                                                    ),
                                                    child: const Icon(
                                                      IconRes.delete,
                                                      color: ColorRes.white,
                                                    ),
                                                  ),
                                                ),
                                                SwipeAction(
                                                  onTap: (CompletionHandler handler) async {
                                                    await handler(false);

                                                    if(newlist[i]['typeid'] == 1){
                                                      Get.to(() => UpdateIncomeScreen(newList: newlist[i],));
                                                    }
                                                    else if(newlist[i]['typeid'] == 2){
                                                      Get.to(() => UpdateExpenseScreen(newList: newlist[i],));
                                                    }
                                                    else if(newlist[i]['typeid'] == 3){
                                                      Get.snackbar(
                                                        'Opps...',
                                                        'Go to loan Section for edit',
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
                                                    else if(newlist[i]['typeid'] == 4){
                                                      Get.snackbar(
                                                        'Opps...',
                                                        'Go to Send Section for edit',
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
                                                    else if(newlist[i]['typeid'] == 5){
                                                      Get.snackbar(
                                                        'Opps...',
                                                        'Go to Receive Section for edit',
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
                                                    else if(newlist[i]['typeid'] == 6){
                                                      await handler(false);
                                                      Get.snackbar(
                                                        'Opps...',
                                                        'Go to Group Section for edit',
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
                                                  widthSpace: Get.width*.15,
                                                  color: Colors.transparent,
                                                  content: Container(
                                                    width: Get.width*.13,
                                                    height: Get.height*.06,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                                      color: Colors.lightGreenAccent,
                                                    ),
                                                    child: const Icon(
                                                      IconRes.edit,
                                                      color: ColorRes.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              child: Row(
                                              children: [

                                                Container(
                                                  width: Get.width*.15,
                                                  height: Get.height*.07,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      //SizedBox(height: Get.height*.01,),
                                                      Container(
                                                        width: Get.width*.1,
                                                        height: Get.height*.05,
                                                        //margin: EdgeInsets.only(left: Get.width*.05),
                                                        decoration: BoxDecoration(
                                                          color: ColorRes.headingColor,
                                                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                                        ),
                                                        child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                                      ),

                                                      Container(
                                                        //margin: EdgeInsets.only(left: Get.width*.0),
                                                          child: Text(newlist[i]['typeid'] == 1 ? StringRes.income : newlist[i]['typeid'] == 2 ? StringRes.expense: newlist[i]['typeid'] == 3 ? StringRes.loan : newlist[i]['typeid'] == 4 ? StringRes.send : newlist[i]['typeid'] == 5 ? StringRes.receive : StringRes.groupHome,style: appTextStyle(fontSize: 8.0,textColor: ColorRes.textHintColor),)),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(width: Get.width*.05,),

                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                                      Text('${newlist[i]['subtitle'].toString()}',style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  margin: EdgeInsets.only(right: Get.width*.05),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text('\u{20B9} ${newlist[i]['price'].toStringAsFixed(1)} /-',style: appTextStyle(fontSize: 21.0,textColor: newlist[i]['type'] == StringRes.expense ? Colors.red :Colors.green,fontWeight: FontWeight.w500),),

                                                      SizedBox(height: Get.height*.005,),
                                                      Text('$d2 $d3',style: appTextStyle(fontSize: 14.0,textColor: ColorRes.textHintColor),),
                                                    ],
                                                  ),
                                                ),


                                              ],
                                          ),
                                            );
                                          }
                                        },
                                    ),
                                  ),
                                ),


                              ],
                            );

                          },
                        );


                      }else{
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Center(child: Text('No Transaction Found.',style: appTextStyle(textColor: ColorRes.textHintColor),)),
                          ),
                        );
                      }

                    }else{
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(child: Text('No Data Available.',style: appTextStyle(textColor: ColorRes.textHintColor),)),
                        ),
                      );
                    }
                  },
                ),
              ),


              //bottom navigation bar
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width,
                  height: Get.height*.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(Get.width*.04),topLeft: Radius.circular(Get.width*.04)),
                    color: ColorRes.bottombar
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      GestureDetector(
                        onTap: (){
                          model.index = 1;
                          model.notifyListeners();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SvgPicture.asset('images/homeicon.svg',color: model.index == 1 ? ColorRes.white : ColorRes.headingColor, fit: BoxFit.scaleDown,),

                            SizedBox(height:Get.width*.01),

                            Text(StringRes.home,style: appTextStyle(textColor: model.index == 1 ? ColorRes.white : ColorRes.headingColor,fontSize: 12.0),),

                          ],
                        ),
                      ),


                      GestureDetector(
                        onTap: (){
                          //model.index = 2;
                          Get.to(()=>const HistoryScreen());
                          model.notifyListeners();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SvgPicture.asset('images/historyicon.svg',color: model.index == 2 ? ColorRes.white : ColorRes.headingColor,fit: BoxFit.scaleDown,),

                            SizedBox(height:Get.width*.01),

                            Text(StringRes.history,style: appTextStyle(textColor: model.index == 2 ? ColorRes.white : ColorRes.headingColor,fontSize: 12.0),),

                          ],
                        ),
                      ),


                      GestureDetector(
                        onTap: (){
                          //model.index = 0;
                          model.notifyListeners();

                          Get.bottomSheet(
                            Container(
                              padding: EdgeInsets.only(top: Get.width*.05),
                              height: Get.height*.35,
                              child: Column(
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              Get.to(() => const ExpenseScreen());
                                            },
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/expenseicon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.expense,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),


                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              Get.to(() => const IncomeScreen());
                                            },
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/income.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.income,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),


                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              Get.to(() => const LoanScreen());
                                            },
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/loanicon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.loan,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),


                                    ],
                                  ),

                                  SizedBox(height: Get.width*.02,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              Get.to(() => const BankDetailsScreen());
                                            },
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/bankicon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.bankHome,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),


                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              Get.to(() => const GroupScreen());
                                            },
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/groupicon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.groupHome,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),


                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              Get.to(() => const SendScreen());
                                            },
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/sendicon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.send,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),


                                    ],
                                  ),

                                  SizedBox(height: Get.width*.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      /*Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){},
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/sendicon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.send,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),*/


                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              Get.to(() => const ReceiveScreen());
                                            },
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/requesticon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.receive,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),


                                     /* Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){},
                                            child: Container(
                                              width: Get.width*.125,
                                              height: Get.width*.125,
                                              margin: EdgeInsets.only(bottom: Get.width*.02),
                                              child: SvgPicture.asset('images/loanicon.svg',fit: BoxFit.scaleDown,),
                                              decoration: BoxDecoration(
                                                //color: ColorRes.lol,
                                                gradient: gredientBottomSheet(),
                                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                              ),
                                            ),
                                          ),

                                          Text(StringRes.loan,style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 12.0),),

                                        ],
                                      ),*/


                                    ],
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: ColorRes.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width*.03),topRight: Radius.circular(Get.width*.03)),
                            ),
                          );

                        },
                        child: Container(
                          width: Get.width*.125,
                          height: Get.width*.125,
                          decoration: BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                          ),
                          child: const Center(
                            child: Icon(IconRes.add,color: ColorRes.headingColor,),
                          ),
                        ),
                      ),


                      GestureDetector(
                        onTap: (){
                          Get.to(() => const CardScreen());

                          /*model.index = 3;
                          model.notifyListeners();*/
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SvgPicture.asset('images/cardicon.svg',fit: BoxFit.scaleDown,color: model.index == 3 ? ColorRes.white : ColorRes.headingColor,),

                            SizedBox(height:Get.width*.01),

                            Text(StringRes.cards,style: appTextStyle(textColor: model.index == 3 ? ColorRes.white : ColorRes.headingColor,fontSize: 12.0),),

                          ],
                        ),
                      ),


                      GestureDetector(
                        onTap: (){
                          /*model.index = 4;
                          model.notifyListeners();*/
                          model.check();

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Image.asset('images/splitxicon.png',width: Get.width*.055,height: Get.width*.055,color: model.index == 4 ? ColorRes.white : ColorRes.headingColor,),

                            SizedBox(height:Get.width*.01),

                            Text(StringRes.splitx,style: appTextStyle(textColor: model.index == 4 ? ColorRes.white : ColorRes.headingColor,fontSize: 12.0),),

                          ],
                        ),
                      ),


                      /*Column(
                        children: [


                        ],
                      ),*/

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      );
    });
  }
}
