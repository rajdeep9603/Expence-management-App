import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/expense/addnewexpense/add_expense_screen.dart';
import 'package:personal_expenses/expense/expense_screen_model.dart';
import 'package:personal_expenses/expense/updateexpense/update_expense_screen.dart';
import 'package:personal_expenses/home/home_screen.dart';
import 'package:personal_expenses/income/updateincomescreen/update_income_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';
import "package:collection/collection.dart";

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpenseScreenModel>.reactive(viewModelBuilder: () => ExpenseScreenModel(), builder: (context,model,child){
      return WillPopScope(
        onWillPop: ()async{
          if(model.searchController.text.isNotEmpty){

            if(model.back == true){
              Get.back();
            }

            model.back = true;

            model.searchFocusNode.unfocus();
            model.notifyListeners();
            return true;
          }else{
            if(model.showsearchbar == true){
              model.showsearchbar = false;
              model.notifyListeners();
              return true;
            }else{
              return true;
            }
          }
        },
        child: Scaffold(
          backgroundColor: ColorRes.background,
          body: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: (){
                      if(model.searchController.text.isNotEmpty){

                        if(model.back == true){
                          Get.back();
                        }

                        model.back = true;

                        model.searchFocusNode.unfocus();
                        model.notifyListeners();
                      }else{
                        if(model.showsearchbar == true){
                          model.showsearchbar = false;
                          model.notifyListeners();
                        }else{
                          Get.back();
                        }
                      }
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

                  model.showsearchbar == true ? Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.width*.125,
                        margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.02,right: Get.width*.07),
                        padding: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            const Icon(IconRes.search,color: ColorRes.textHintColor,),

                            Expanded(
                              child: Container(
                                height: Get.width*.125,
                                margin: EdgeInsets.only(left: Get.width*.03),
                                child: TextField(
                                  onChanged: (value){
                                    model.runFilter(value);
                                  },
                                  autofocus: true,
                                  controller: model.searchController,
                                  focusNode: model.searchFocusNode,
                                  style: appTextStyle(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: StringRes.search,
                                    hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        decoration: const BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        ),
                      ),
                    ),
                  ):GestureDetector(
                    onTap: (){
                      model.showsearchbar = true;
                      model.notifyListeners();
                    },
                    child: Container(
                      width: Get.width*.125,
                      height: Get.width*.125,
                      margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.07),
                      child: const Icon(IconRes.search,color: ColorRes.headingColor,),
                      decoration: const BoxDecoration(
                        color: ColorRes.white,
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                    ),
                  ),



                ],
              ),


              Expanded(
                child: model.find.isEmpty && model.isSearch == false
                    ?
                FutureBuilder(
                  future: DatabaseHelper.internal().transactions(),
                  builder: (BuildContext context,AsyncSnapshot<List<TransactionTable>> snapshot){
                    if(snapshot.hasData){

                      model.items = [];

                      snapshot.data!.forEach((element) {
                        if(element.ttype! == StringRes.expense){
                          model.items!.add(element);
                        }
                      });

                      if(model.items!.length > 0){

                        List<Map> data = [];
                        model.items!.forEach((element) {
                          data.add(element.toMap());
                        });

                        var newMap = groupBy(data, (Map obj) => obj['entrydate']);
                        model.listkeys = newMap.keys.toList();
                        model.listvalue = newMap.values.toList();

                        model.listkeys.sort((a, b){
                          return DateTime.parse(b).compareTo(DateTime.parse(a));
                        });

                        return  ListView.builder(
                          itemCount: newMap.values.length,
                          itemBuilder: (context,index){
                            var newlist = [];
                            model.listvalue.forEach((element) {
                              element.forEach((el) {
                                if(el['entrydate'] == model.listkeys[index]){
                                  newlist.add(el);
                                }
                              });
                            });

                            /*DateTime d = DateTime.parse(newlist.first['date']);
                            final now = DateTime.now();
                            final now1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                            final now2 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 1));
                            String d2 = DateFormat.d().format(d);
                            String d3 = DateFormat.MMM().format(d);*/


                            DateTime d1 = DateTime.parse(newlist.first['entrydate']);
                            final now = DateTime.now();
                            final now3 = DateTime(now.year, now.month - 1, now.day);
                            final now1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
                            final now2 = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, now.day - 1));
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
                                        print('---------${newlist[i]}');

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
                                                            Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
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
                                                            Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
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
                                                      Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
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
                            child: Center(child: Text(StringRes.noTransaction,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                          ),
                        );
                      }


                    }else{

                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(child: Text(StringRes.noData,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                        ),
                      );

                    }
                  },
                )
                    :
                model.find.isNotEmpty
                    ?
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.find.length,
                  itemBuilder: (context,i){

                    var newlist = model.find;

                    print(newlist);

                    DateTime d = DateTime.parse(newlist[i]['date']);
                    final now = DateTime.now();
                    String d2 = DateFormat.d().format(d);
                    String d3 = DateFormat.MMM().format(d);

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
                              Container(
                                width: Get.width*.9,
                                padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                                margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                                decoration: BoxDecoration(
                                  color: ColorRes.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                ),
                                child: Column(
                                  children: [

                                    SizedBox(height: Get.width*.03,),
                                    Row(
                                      children: [
                                        Container(
                                          width: Get.width*.1,
                                          height: Get.height*.05,
                                          margin: EdgeInsets.only(left: Get.width*.05),
                                          decoration: BoxDecoration(
                                            color: ColorRes.headingColor,
                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                          ),
                                          child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                        ),

                                        SizedBox(width: Get.width*.05,),

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                              Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
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
                              ),
                            ],
                          ),
                        );
                      }
                      else{
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
                              Container(
                                width: Get.width*.9,
                                padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                                margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                                decoration: BoxDecoration(
                                  color: ColorRes.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: Get.width*.1,
                                          height: Get.height*.05,
                                          margin: EdgeInsets.only(left: Get.width*.05),
                                          decoration: BoxDecoration(
                                            color: ColorRes.headingColor,
                                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                          ),
                                          child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                        ),
                                        SizedBox(width: Get.width*.05,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                              Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
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
                                    //SizedBox(height: Get.width*.03,),
                                    //Divider(height: Get.width*.01,),
                                  ],
                                ),
                              ),
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
                            Container(
                              width: Get.width*.9,
                              padding: EdgeInsets.only(left: Get.width*.02,right: Get.width*.02,bottom: Get.width*.03,top: Get.width*.03),
                              margin: EdgeInsets.only(left: Get.width*.03,right: Get.width*.03,bottom: Get.width*.02),
                              decoration: BoxDecoration(
                                color: ColorRes.white,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.05)),
                              ),
                              child: Row(
                                children: [

                                  Container(
                                    width: Get.width*.1,
                                    height: Get.height*.05,
                                    margin: EdgeInsets.only(left: Get.width*.05),
                                    decoration: BoxDecoration(
                                      color: ColorRes.headingColor,
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
                                    ),
                                    child: Image.memory(newlist[i]['logo'],fit: BoxFit.scaleDown,),
                                  ),

                                  SizedBox(width: Get.width*.05,),

                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(newlist[i]['title'].toString(),style: appTextStyle(fontSize: 21.0,textColor: ColorRes.headingColor,fontWeight: FontWeight.w500),),
                                        Text(newlist[i]['subtitle'].toString(),style: appTextStyle(fontSize: 12.0,textColor: ColorRes.textHintColor),),
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
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )
                    :
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Center(child: Text(StringRes.noData,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                  ),
                ),
              ),

            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Get.to(() => const AddExpenseScreen());
            },
            child: const Icon(IconRes.add),
            backgroundColor: ColorRes.headingColor,
          ),
        ),
      );
    });
  }
}
