import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/contact.dart';
import 'package:personal_expenses/group/addgroupexpanse/whopaid/multiperson/multi_person_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class MultiPersonScreen extends StatelessWidget {

  int? gid,eid;
  double? amount;

  MultiPersonScreen({required this.gid, required this.eid, required this.amount});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultiPersonScreenModel>.reactive(viewModelBuilder: () => MultiPersonScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
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
                        child: Text(StringRes.enterAmount,style: appTextStyle(fontSize: 22.0,fontWeight: FontWeight.w400,textColor: ColorRes.headingColor),)),


                  ],
                ),

                GestureDetector(
                  onTap: (){
                    model.addwho(gid,eid,amount);
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

            Expanded(
              child: FutureBuilder(
                future: DatabaseHelper.internal().contacts(),
                builder: (BuildContext context, AsyncSnapshot<List<ContactTable>> snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data!.length > 0){

                      List d = [];

                      List<Map> data = [];
                      snapshot.data!.forEach((element) {
                        data.add(element.toMap());
                      });

                      print(data);

                      data.forEach((element) {
                        if(element['gid'] == gid){
                          d.add(element);
                          model.controllers.add(TextEditingController());
                          model.focusnodes.add(FocusNode());
                          model.selected.add(element['id']);
                        }
                      });

                      print(d);

                      if(d.isNotEmpty){

                        return Container(
                          width: Get.width*.9,
                          child: ListView.builder(
                            itemCount: d.length,
                            itemBuilder: (context, int index){

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

                                      print(d.length);

                                      model.controllers.forEach((element) {

                                        print(element.text);

                                      });

                                      print(model.controllers.length);
                                      print(model.focusnodes.length);

                                      print(model.controllers[index].text);

                                    },
                                    leading: Container(
                                      width: Get.width*.14,
                                      height: Get.height,
                                      //margin: EdgeInsets.only(left: Get.width*.05),
                                      decoration: BoxDecoration(
                                        color: ColorRes.headingColor,
                                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.03)),
                                      ),
                                      child: Center(child: Text(d[index]['name'][0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontSize: 22.0,fontWeight: FontWeight.w500),)),
                                    ),
                                    title: Text(d[index]['name'].toString(),style: appTextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,textColor: ColorRes.headingColor),),
                                    trailing: Container(
                                      width: Get.width*.15,
                                      height: Get.width*.1,
                                      child: TextField(
                                        controller: model.controllers[index],
                                        focusNode: model.focusnodes[index],
                                        style: appTextStyle(textColor: ColorRes.headingColor,fontSize: 20.0),
                                        inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        decoration: InputDecoration(
                                          hintText: '\u{20B9} 0.00',
                                          hintStyle: appTextStyle(textColor: ColorRes.textHintColor,fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                            },
                          ),
                        );

                      }else{
                        return const Align(
                          alignment: Alignment.center,
                          child: Text('No Contact Selected'),
                        );
                      }

                    }else{
                      return const Align(
                        alignment: Alignment.center,
                        child: Text('No Contact Selected'),
                      );
                    }
                  }else{
                    return const Align(
                      alignment: Alignment.center,
                      child: Text('No Contact Selected'),
                    );
                  }
                },
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