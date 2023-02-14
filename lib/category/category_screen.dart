import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/category/category_screen_model.dart';
import 'package:personal_expenses/category/create_category/create_category_screen.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/catagorywithimage.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryScreenModel>.reactive(viewModelBuilder: () => CategoryScreenModel(), builder: (context,model,child){
      return WillPopScope(
        onWillPop: ()async{
          if(model.searchController.text.isNotEmpty){
            if(model.back == false){
              return true;
            }else{
              model.back = false;
              model.searchFocusNode.unfocus();
              model.searchController.clear();
              model.showsearchbar = false;
              model.notifyListeners();
              return false;
            }
          }else{

            if(model.showsearchbar == true){
              model.showsearchbar = false;
              model.searchFocusNode.unfocus();
              model.searchController.clear();
              model.notifyListeners();
              return false;
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

                  //back button
                  GestureDetector(
                    onTap: (){
                      if(model.searchController.text.isNotEmpty){
                        if(model.back == false){
                          Get.back();
                        }else{
                          model.back = false;
                          model.searchFocusNode.unfocus();
                          model.searchController.clear();
                          model.showsearchbar = false;
                          model.notifyListeners();
                        }
                      }else{

                        if(model.showsearchbar == true){
                          model.showsearchbar = false;
                          model.searchFocusNode.unfocus();
                          model.searchController.clear();
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

                  model.showsearchbar == true ?Expanded(
                    child: Container(
                      width: Get.width,
                      height: Get.width*.125,
                      margin: EdgeInsets.only(top: Get.height*.06,left: Get.width*.02,right: Get.width*.02),
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
                                onTap: (){
                                  print('on tap searchbar ${model.showsearchbar}');
                                },
                                onChanged: (v){
                                  if(v.isNotEmpty){
                                    model.back = true;
                                    model.notifyListeners();
                                    print('on change :- ${model.back}');
                                  }else{
                                    model.back = false;
                                    model.notifyListeners();
                                    print('on change :- ${model.back}');
                                  }

                                  model.runFilter(v);

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
                  ): Expanded(child: Row(
                    children: [
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: (){
                          model.showsearchbar = true;
                          model.notifyListeners();
                        },
                        child: Container(
                          width: Get.width*.125,
                          height: Get.width*.125,
                          margin: EdgeInsets.only(top: Get.height*.06,right: Get.width*.02),
                          child: const Icon(IconRes.search,color: ColorRes.headingColor,),
                          decoration: const BoxDecoration(
                            color: ColorRes.white,
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                        ),
                      ),
                    ],
                  ),),



                  GestureDetector(
                    onTap: (){
                      Get.to(() => const CreateCategoryScreen());
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
                child: model.find.isEmpty ? FutureBuilder(
                  future: DatabaseHelper.internal().catagorys(),
                  builder: (BuildContext context,AsyncSnapshot<List<CatagoryWithImageTable>> snapshot){
                    if(snapshot.hasData){

                      if(snapshot.data!.length > 0){

                        model.listvalue = snapshot.data!;

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,int index){

                            return GestureDetector(
                              onTap: (){
                                Get.back(result: [{'name': snapshot.data![index].title},{'photo': snapshot.data![index].image}]);
                              },
                              child: ListTile(
                                leading: Container(
                                   width: Get.width*.12,
                                   height: Get.width*.12,
                                   margin: EdgeInsets.only(left: Get.width*.05),
                                   decoration: BoxDecoration(
                                     color: ColorRes.headingColor,
                                     borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                                   ),
                                child: Image.memory(snapshot.data![index].image!,fit: BoxFit.scaleDown,)),
                                title: Text(snapshot.data![index].title!,style: appTextStyle(),),
                              ),
                            );

                          },
                        );


                      }else{
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Center(child: Text(StringRes.noData,style: appTextStyle(textColor: ColorRes.textHintColor),)),
                          ),
                        );
                      }

                    }else{
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(child: Text('Add New Category',style: appTextStyle(textColor: ColorRes.textHintColor),)),
                        ),
                      );
                    }
                  },
                ) : ListView.builder(
                  itemCount: model.find.length,
                  itemBuilder: (context,int index){

                    return GestureDetector(
                      onTap: (){
                        Get.back(result: [{'name': model.find[index]['title']},{'photo': model.find[index]['image']}]);
                      },
                      child: ListTile(
                        leading: Container(
                            width: Get.width*.12,
                            height: Get.width*.12,
                            margin: EdgeInsets.only(left: Get.width*.05),
                            decoration: BoxDecoration(
                                color: ColorRes.headingColor,
                                borderRadius: BorderRadius.all(Radius.circular(Get.width*.03))
                            ),
                            child: Image.memory(model.find[index]['image'],fit: BoxFit.scaleDown,)),
                        title: Text(model.find[index]['title'],style: appTextStyle(),),
                      ),
                    );

                  },
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
