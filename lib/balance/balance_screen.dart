import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/balance/balance_screen_model.dart';
import 'package:personal_expenses/balance/settelup/settelup_screen.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:stacked/stacked.dart';

class BalanceScreen extends StatelessWidget {

  int? gid, eid;
  double? amount;

  BalanceScreen({required this.gid, required this.eid, required this.amount});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BalanceScreenModel>.reactive(
      onModelReady: (model){
        model.init(gid,eid,amount);
      },
      viewModelBuilder: () => BalanceScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
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
                  margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.07),
                  child: const Icon(IconRes.back,color: ColorRes.headingColor,),
                  decoration: const BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: (){
                  Get.to(() => const SettelupScreen());
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
            ),


            model.show == false ? Container(
              width: Get.width*.85,
              height: Get.height*.1,
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
              ),
              child: ListTile(
                leading: Container(
                  width: Get.width*.12,
                  height: Get.width*.12,
                  decoration: BoxDecoration(
                    color: ColorRes.headingColor,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*.02))
                  ),
                ),
                trailing: GestureDetector(
                  onTap: (){
                    model.show = true;
                    model.notifyListeners();
                  },
                  child: Container(
                    width: Get.width*.06,
                    height: Get.width*.06,
                    decoration: BoxDecoration(
                        color: ColorRes.headingColor,
                        borderRadius: BorderRadius.all(Radius.circular(Get.width*.06))
                    ),
                    child: const Center(
                      child: Icon(IconRes.down,color: ColorRes.white,),
                    ),
                  ),
                ),
              ),
            ):
            Container(
              width: Get.width*.85,
              height: Get.height*.2,
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.all(Radius.circular(Get.width*.02)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: Get.width*.12,
                      height: Get.width*.12,
                      decoration: BoxDecoration(
                          color: ColorRes.headingColor,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width*.02))
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: (){
                        model.show = false;
                        model.notifyListeners();
                      },
                      child: Container(
                        width: Get.width*.06,
                        height: Get.width*.06,
                        decoration: BoxDecoration(
                            color: ColorRes.headingColor,
                            borderRadius: BorderRadius.all(Radius.circular(Get.width*.06))
                        ),
                        child: const Center(
                          child: Icon(IconRes.up,color: ColorRes.white,),
                        ),
                      ),
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        width: Get.width*.85,
                        height: Get.height*.01,
                        color: index.isEven ? ColorRes.headingColor : ColorRes.textHintColor,
                      );
                    }),
                ],
              ),
            ),





          ],
        ),
      );
    });
  }
}
