import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/group/groupmember/contact/contact_screen_model.dart';
import 'package:personal_expenses/util/color_file.dart';
import 'package:personal_expenses/util/icon_file.dart';
import 'package:personal_expenses/util/textstyle.dart';
import 'package:stacked/stacked.dart';

class ContactScreen extends StatelessWidget {

  List<Contact>? contacts;

  ContactScreen({required this.contacts});
  //const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactScreenModel>.reactive(viewModelBuilder: () => ContactScreenModel(), builder: (context,model,child){

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

            Expanded(
              child: ListView.builder(
                itemCount: contacts!.length,
                itemBuilder: (BuildContext context, int i){
                  return Container(
                    margin: EdgeInsets.only(left: Get.width*.07,bottom: Get.width*.01),
                    child: ListTile(
                      title: Text(contacts![i].displayName),
                      onTap: ()async{

                        final fullContact =
                            await FlutterContacts.getContact(contacts![i].id);

                        Get.back(result: [{'contact': fullContact}]);

                      },
                      leading: Container(decoration: BoxDecoration(color: ColorRes.headingColor,borderRadius: BorderRadius.all(Radius.circular(Get.width*.12))),width: Get.width*.13,height: Get.width*.12,child: contacts![i].thumbnail != null ? Image.memory(contacts![i].thumbnail!) : Center(child: Text(contacts![i].displayName[0].toUpperCase(),style: appTextStyle(textColor: ColorRes.white,fontWeight: FontWeight.w500,fontSize: 20.0),)),),
                    ),
                  );
                }),
            ),

          ],
        ),
      );

    });
  }
}
