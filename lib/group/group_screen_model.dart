import 'package:flutter/cupertino.dart';
import 'package:personal_expenses/database/model/group.dart';
import 'package:personal_expenses/onlionapi/api.dart';
import 'package:personal_expenses/onlionapi/get_group_model.dart';
import 'package:stacked/stacked.dart';

class GroupScreenModel extends BaseViewModel{

  bool back = false;

  TextEditingController searchController = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  bool showsearchbar = false;
  bool isSearch = false;
  List<GroupHeader>? items;
  List find = [];
  List listvalue = [];
  var listkeys;
  GetAllGroup g = GetAllGroup();

  init(){
    setBusy(true);
    notifyListeners();
    AllGroups.groups().then((value) {
      if(value !=  null){
        if(value.messageCode == 1){
          g = value;
          notifyListeners();
          setBusy(false);

          print('-----groups $g');

        }
        else{
          g = GetAllGroup(data:null);
          setBusy(false);
        }
      }
      else{
        g = GetAllGroup(data:null);
        print("no data found");
        setBusy(false);
      }
    });
  }

  void runFilter(String enteredKeyword) {
    List sortinglist = [];
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = [];
      find  = [];
      isSearch = false;
    } else {
      if(g.data!.gdList!.length > 1){
        g.data!.gdList!.forEach((element) {
          sortinglist.add(element);
        });
      }else{
        sortinglist.add(g.data!.gdList!.first);
      }

      results = sortinglist
          .where((user) =>
          user.name.toLowerCase().contains(enteredKeyword.toLowerCase())
      ).toList();

      isSearch = true;
    }
    find = results;
    notifyListeners();
  }

}