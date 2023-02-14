// To parse this JSON data, do
//
//     final isSettled = isSettledFromJson(jsonString);

import 'dart:convert';

IsSettled isSettledFromJson(String str) => IsSettled.fromJson(json.decode(str));

String isSettledToJson(IsSettled data) => json.encode(data.toJson());

class IsSettled {
  IsSettled({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  Data? data;

  factory IsSettled.fromJson(Map<String, dynamic> json) => IsSettled(
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
  });

  List<EeList>? eeList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    eeList: json["eeList"] == null ? null : List<EeList>.from(json["eeList"].map((x) => EeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "eeList": eeList == null ? null : List<dynamic>.from(eeList!.map((x) => x.toJson())),
  };
}

class EeList {
  EeList({
    this.id,
    this.groupId,
    this.category,
    this.title,
    this.description,
    this.date,
    this.amount,
    this.entryBy,
    this.entryTime,
    this.updateBy,
    this.updateTime,
    this.isSettled,
    this.randomId,
  });

  int? id;
  int? groupId;
  String? category;
  String? title;
  String? description;
  DateTime? date;
  double? amount;
  String? entryBy;
  DateTime? entryTime;
  dynamic updateBy;
  DateTime? updateTime;
  bool? isSettled;
  String? randomId;

  factory EeList.fromJson(Map<String, dynamic> json) => EeList(
    id: json["id"] == null ? null : json["id"],
    groupId: json["groupId"] == null ? null : json["groupId"],
    category: json["category"] == null ? null : json["category"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    entryBy: json["entryBy"] == null ? null : json["entryBy"],
    entryTime: json["entryTime"] == null ? null : DateTime.parse(json["entryTime"]),
    updateBy: json["updateBy"],
    updateTime: json["updateTime"] == null ? null : DateTime.parse(json["updateTime"]),
    isSettled: json["isSettled"] == null ? null : json["isSettled"],
    randomId: json["randomId"] == null ? null : json["randomId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "groupId": groupId == null ? null : groupId,
    "category": category == null ? null : category,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "date": date == null ? null : date!.toIso8601String(),
    "amount": amount == null ? null : amount,
    "entryBy": entryBy == null ? null : entryBy,
    "entryTime": entryTime == null ? null : entryTime!.toIso8601String(),
    "updateBy": updateBy,
    "updateTime": updateTime == null ? null : updateTime!.toIso8601String(),
    "isSettled": isSettled == null ? null : isSettled,
    "randomId": randomId == null ? null : randomId,
  };
}
