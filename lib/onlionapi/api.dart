import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:personal_expenses/home/home_screen_model.dart';
import 'package:personal_expenses/onlionapi/add_contact_model.dart';
import 'package:personal_expenses/onlionapi/allexpenselist_model.dart';
import 'package:personal_expenses/onlionapi/check_login_model.dart';
import 'package:personal_expenses/onlionapi/check_whopaid_done_model.dart';
import 'package:personal_expenses/onlionapi/delete_expense.dart';
import 'package:personal_expenses/onlionapi/deletegroup_model.dart';
import 'package:personal_expenses/onlionapi/expense_model.dart';
import 'package:personal_expenses/onlionapi/expense_splitx_list_model.dart';
import 'package:personal_expenses/onlionapi/get_group_contact.dart';
import 'package:personal_expenses/onlionapi/get_group_model.dart';
import 'package:personal_expenses/onlionapi/settlement_model.dart';
import 'dart:convert';

import 'package:personal_expenses/onlionapi/signup_model.dart';
import 'package:personal_expenses/onlionapi/splituser_model.dart';
import 'package:personal_expenses/onlionapi/useless_verification_model.dart';
import 'package:personal_expenses/onlionapi/whopaid_model.dart';

class AddGroup{
  static Future<Map?> addOneGroup(String? gname, String? gtype, String? uname, int? uid, String? image, String? banner) async{
    try{

      String url = AllApi.addgroup;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields.addAll({
        'Type_Check': '1',//
        'Id': '0',
        'Name': '$gname',
        'Type': '$gtype',
        'EntryBy': randomid,
        'UpdateBy': '$uname',
        'UserId': '$uid',
        'RandomId': 'abc',
      });

      request.files.add(await http.MultipartFile.fromPath('Image',image!));
      request.files.add(await http.MultipartFile.fromPath('Banner',banner!));
      http.StreamedResponse response = await request.send();

      print(response);

      if (response.statusCode == 200){
        String a = await response.stream.bytesToString();
        Map valueMap = json.decode(a);
        return valueMap;
      }
      else {
        return {'':''};
      }

    } catch (e) {
      print(e);
    }
  }
  static Future<bool?> updateOneGroup(int? gid,String? gname, String? gtype, String? image, String? banner, bool? imgc, bool? banc) async{
    try{

      String url = AllApi.addgroup;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields.addAll({
        'Type_Check': '1',//
        'Id': '$gid',
        'Name': '$gname',
        'Type': '$gtype',
        'EntryBy': 'abc',
        'UpdateBy': randomid,
        'UserId': uid,
        'RandomId': 'abc',
      });

      request.files.add(await http.MultipartFile.fromPath('Image',image!));
      request.files.add(await http.MultipartFile.fromPath('Banner',banner!));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200){

        print(await response.stream.bytesToString());

        /*String a = await response.stream.bytesToString();
        Map valueMap = json.decode(a);

        print(valueMap);*/

        return true;
        //return valueMap;
      }
      else {
        return false;
        //return {'':''};
      }

    } catch (e) {
      print(e);
    }
  }
}




class SignupUser {
  static Future<SignUp?> checkSignup(String uname, String pass, String umobile) async {
    try {
      String url = AllApi.singin;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "UserName": uname,
        "Password": pass,
        "MobileNo": umobile,
        "Type": 1,
        "Id": 0,
        "RandomId": 'abc',
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return signUpFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class VerifyLogin {
  static Future<LoginCheck?> checkLogin(String uname, String pass) async {
    try {
      String url = AllApi.login;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "UserName": uname,
        "Password": pass,
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return loginCheckFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class SaveContact {
  static Future<AddContact?> contacts(int gid, String cname, String cno) async {
    try {
      String url = AllApi.contact;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" : 0,
        "EC" : {
          "Id" : 0,
          "GroupId" :gid,
          "Name": cname,
          "MobileNo": cno,
          "EntryBy": randomid,
          "UpdateBy": "",
          "RandomId":"abc"
        },
        "apiKey": randomid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return addContactFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class Useless {
  static Future<AfterOtpVerification?> checkok() async {
    try {
      String url = AllApi.ul;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" :uid,
        "apiKey":randomid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return afterOtpVerificationFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}



class AllGroups {
  static Future<GetAllGroup?> groups() async {
    try {
      String url = AllApi.allgroups;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 0,
        "Id" : 0,
        "apiKey": randomid
      };

      print('---------------$randomid');

      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return getAllGroupFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class GetSingalGroup {
  static Future<GetSingalGroupContact?> singalgroupinfo(int id) async {
    try {
      String url = AllApi.allgroups;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 0,
        "Id" : id,
        "apiKey": randomid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return getSingalGroupContactFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class GetAllExpense {
  static Future<Expenselist?> list(int id) async {
    try {
      String url = AllApi.oneexpense;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 0,
        "Id" : id,
        "apiKey": randomid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return expenselistFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}



class AddExpense {
  static Future<SingalExpenseAdd?> expense(int gid, String title, String catagory, String des, String date, double amount) async {
    try {
      String url = AllApi.expense;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" : 0,
        "EE" : {
          "Id" : 0,
          "GroupId" : gid,
          "Title" : title,
          "Category" : catagory,
          "Description" : des,
          "Date" :  date,
          "Amount" : amount,
          "EntryBy" : randomid,
          "UpdateBy" : "abc",
          "IsSettled" : false,
          "RandomId" : "abc"
        },
        "apiKey" : randomid
      };

      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return singalExpenseAddFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}



class Split {
  static Future<WhoPaid?> list(int gid,int eid, double amount, List<Map> contacts) async {
    try {
      String url = AllApi.splitx;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" : 0,
        "apiKey" : randomid,
        "EWP":{
          "Id":0,
          "GroupId":gid,
          "ContactId":0,
          "ExpenseId":eid,
          "Amount": amount,
          "EntryBy": randomid,
          "UpdateBy" : "abc",
          "IsDelete" : false,
          "RandomId" : "abc"
        },
        "CWAList" : contacts
      };

      print(bodyData);

      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return whoPaidFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
  static Future<WhoPaid?> list1(int gid,int eid, double amount, List<Map> contacts) async {
    try {
      String url = AllApi.splitx;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" : 1,
        "apiKey" : randomid,
        "EWP":{
          "Id":0,
          "GroupId":gid,
          "ContactId":0,
          "ExpenseId":eid,
          "Amount": amount,
          "EntryBy": randomid,
          "UpdateBy" : "abc",
          "IsDelete" : false,
          "RandomId" : "abc"
        },
        "CWAList" : contacts
      };

      print(bodyData);

      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return whoPaidFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}




class UserWiseExpense {
  static Future<PaidUser?> userexpenselist(int id, int gid) async {
    try {
      String url = AllApi.who;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 0,
        "Id" : id,
        "apiKey" : randomid,
        "GroupId": gid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return paidUserFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class DeleteEx {
  static Future<DeleteExpense?> letsdelete(int? eid, int? gid) async {
    try {
      String url = AllApi.delete;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" :eid,
        "apiKey":randomid,
        "GroupId":gid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return deleteExpenseFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}

class Whopaidlist {
  static Future<IsContactSelected?> getlist(int? eid, int? gid) async {
    try {
      String url = AllApi.contactlist;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" :eid,
        "apiKey":randomid,
        "GroupId":gid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return isContactSelectedFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class DeleteG {
  static Future<GroupDelete?> letsdeleteg(int? gid) async {
    try {
      String url = AllApi.deletegroup;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" :gid,
        "apiKey":randomid,
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return groupDeleteFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}



class Settelement {
  static Future<IsSettled?> letssettel(int? eid, int? gid) async {
    try {
      String url = AllApi.us;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 1,
        "Id" :eid,
        "apiKey":randomid,
        "GroupId":gid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return isSettledFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}



class ExpenseSplit {
  static Future<SyncData?> getsingalexpensesplitlist() async {
    try {
      String url = AllApi.sy;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 0,
        "Id" :0,
        "apiKey":randomid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return syncDataFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
  static Future<SyncData?> getsingalexpensesplitlistall() async {
    try {
      String url = AllApi.sy;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> bodyData = {
        "Type" : 0,
        "Id" :1,
        "apiKey":randomid
      };
      var body = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201){
        return syncDataFromJson(response.body);
      } else {
        var errorMsg = jsonDecode(response.body)['message'];
        Get.snackbar("error".tr, errorMsg);
        return null;
      }
    } catch (e) {
      print(e);
      // throw Exception(e.toString());
    }
  }
}


class AllApi {
  static const String addgroup = 'http://103.206.139.223:6042/api/API/InsertUpdateGroup';
  static const String singin = 'http://103.206.139.223:6042/api/API/Signup';
  static const String login = 'http://103.206.139.223:6042/api/API/Login';
  static const String contact = 'http://103.206.139.223:6042/api/API/InsertUpdateContact';
  static const String ul = 'http://103.206.139.223:6042/api/API/ChangeToVerified';
  static const String allgroups = 'http://103.206.139.223:6042/api/API/GetGroups';
  static const String expense = 'http://103.206.139.223:6042/api/API/InsertUpdateExpense';
  static const String oneexpense = 'http://103.206.139.223:6042/api/API/GetExpense';
  static const String splitx = 'http://103.206.139.223:6042/api/API/InsertUpdateWhoPaid';
  static const String who = 'http://103.206.139.223:6042/api/API/GetWhoPaid';
  static const String delete = 'http://103.206.139.223:6042/api/API/DeleteExpense';
  static const String contactlist = 'http://103.206.139.223:6042/api/API/CheckGetContacts';
  static const String deletegroup = 'http://103.206.139.223:6042/api/API/DeleteGroup';
  static const String us = 'http://103.206.139.223:6042/api/API/UpdateIsSettled';
  static const String sy = 'http://103.206.139.223:6042/api/API/GetUnSyncData';
}
