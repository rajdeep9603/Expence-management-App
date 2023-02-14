// To parse this JSON data, do
//
//     final whoPaid = whoPaidFromJson(jsonString);

import 'dart:convert';

WhoPaid whoPaidFromJson(String str) => WhoPaid.fromJson(json.decode(str));

String whoPaidToJson(WhoPaid data) => json.encode(data.toJson());

class WhoPaid {
  WhoPaid({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  Data? data;

  factory WhoPaid.fromJson(Map<String, dynamic> json) => WhoPaid(
    message: json["message"] == null ? null : json["message"],
    messageCode: json["messageCode"] == null ? null : json["messageCode"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "messageCode": messageCode == null ? null : messageCode,
    "status": status == null ? null : status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.eeList,
    this.ewpList,
  });

  List<dynamic>? eeList;
  List<EwpList>? ewpList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    eeList: json["eeList"] == null ? null : List<dynamic>.from(json["eeList"].map((x) => x)),
    ewpList: json["ewpList"] == null ? null : List<EwpList>.from(json["ewpList"].map((x) => EwpList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "eeList": eeList == null ? null : List<dynamic>.from(eeList!.map((x) => x)),
    "ewpList": ewpList == null ? null : List<dynamic>.from(ewpList!.map((x) => x.toJson())),
  };
}

class EwpList {
  EwpList({
    this.id,
    this.groupId,
    this.contactId,
    this.expenseId,
    this.amount,
    this.entryBy,
    this.entryTime,
    this.updateBy,
    this.updateTime,
    this.isDelete,
    this.randomId,
  });

  int? id;
  int? groupId;
  int? contactId;
  int? expenseId;
  double? amount;
  String? entryBy;
  DateTime? entryTime;
  String? updateBy;
  DateTime? updateTime;
  bool? isDelete;
  dynamic randomId;

  factory EwpList.fromJson(Map<String, dynamic> json) => EwpList(
    id: json["id"] == null ? null : json["id"],
    groupId: json["groupId"] == null ? null : json["groupId"],
    contactId: json["contactId"] == null ? null : json["contactId"],
    expenseId: json["expenseId"] == null ? null : json["expenseId"],
    amount: json["amount"] == null ? null : json["amount"],
    entryBy: json["entryBy"] == null ? null : json["entryBy"],
    entryTime: json["entryTime"] == null ? null : DateTime.parse(json["entryTime"]),
    updateBy: json["updateBy"] == null ? null : json["updateBy"],
    updateTime: json["updateTime"] == null ? null : DateTime.parse(json["updateTime"]),
    isDelete: json["isDelete"] == null ? null : json["isDelete"],
    randomId: json["randomId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "groupId": groupId == null ? null : groupId,
    "contactId": contactId == null ? null : contactId,
    "expenseId": expenseId == null ? null : expenseId,
    "amount": amount == null ? null : amount,
    "entryBy": entryBy == null ? null : entryBy,
    "entryTime": entryTime == null ? null : entryTime!.toIso8601String(),
    "updateBy": updateBy == null ? null : updateBy,
    "updateTime": updateTime == null ? null : updateTime!.toIso8601String(),
    "isDelete": isDelete == null ? null : isDelete,
    "randomId": randomId,
  };
}
