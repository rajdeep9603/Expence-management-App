import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/category/create_category/create_category_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateCategoryScreenModel>.reactive(viewModelBuilder: () => CreateCategoryScreenModel(), builder: (context,model,child){
      return Scaffold(
        backgroundColor: ColorRes.background,
        body: Column(
          children: [

            Align(
              alignment: Alignment.topLeft,
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


            SizedBox(height: Get.height*.04,),

            GestureDetector(
              onTap: (){
                model.pickFile();
              },
              child: Container(
                width: Get.width*0.9,
                height: Get.height*.06,
                padding: EdgeInsets.only(left: Get.width*0.05),
                margin: EdgeInsets.only(left: Get.width*0.08,right: Get.width*0.08),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorRes.white
                ),
                child: Align(alignment: Alignment.centerLeft,child: Text(model.result != null ? 'Image Selected Successfully':StringRes.selectImg,style: appTextStyle(textColor: ColorRes.textHintColor),)),
              ),
            ),
            SizedBox(height: Get.height*0.03,),


            //title
            Container(
              width: Get.width*0.9,
              height: Get.height*.06,
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
                controller: model.titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: StringRes.title,
                  hintStyle: appTextStyle(textColor: ColorRes.textHintColor),
                ),
              ),
            ),
            SizedBox(height: Get.height*0.03,),


            //button
            GestureDetector(
              onTap: (){
                //Get.to(() => const OnBodingScreen());
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
      );
    });
  }
}
