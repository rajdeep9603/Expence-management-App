import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/database/database_manager.dart';
import 'package:personal_expenses/database/model/whopaid.dart';
import 'package:stacked/stacked.dart';

class MultiPersonScreenModel extends BaseViewModel{

  List<TextEditingController> controllers = [];

  List<FocusNode> focusnodes = [];

  List selected = [];
  var db = DatabaseHelper();

  addwho(int? gid, int? eid, double? amount){

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    var toremove = [];
    focusnodes.forEach((element) {
      element.unfocus();
    });
    for(int i=0; i<controllers.length ; i++){
      if(controllers[i].text.isEmpty){
        toremove.add((i+1));
      }
    }
    print('before ----> $selected');
    print('controllers ----> $controllers');
    selected.removeWhere((element) => toremove.contains(element));
    print('after ----> $selected');

    //int person = selected.length;

    //double? div = amount!/person;    .

    /*selected.forEach((element) async {
      WhoPaidTable wpt = WhoPaidTable(gid: gid, cid: element, eid: eid, enterby: 'xyz', entertime: formattedDate, price: div);

      int i = await db.insertWhopaid(wpt);

      if(i > 0){
        WhoPaidTable w1 = (await db.getlastwho(i))!;

        print(w1);
      }

    });*/




  }

}