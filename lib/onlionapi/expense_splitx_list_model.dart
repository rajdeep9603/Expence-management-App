// To parse this JSON data, do
//
//     final syncData = syncDataFromJson(jsonString);

import 'dart:convert';

SyncData syncDataFromJson(String str) => SyncData.fromJson(json.decode(str));

String syncDataToJson(SyncData data) => json.encode(data.toJson());

class SyncData {
  SyncData({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  Data? data;

  factory SyncData.fromJson(Map<String, dynamic> json) => SyncData(
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
    this.gdList,
    this.eeList,
    this.ewpList,
  });

  List<GdList>? gdList;
  List<EeList>? eeList;
  List<EwpList>? ewpList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gdList: json["gdList"] == null ? null : List<GdList>.from(json["gdList"].map((x) => GdList.fromJson(x))),
    eeList: json["eeList"] == null ? null : List<EeList>.from(json["eeList"].map((x) => EeList.fromJson(x))),
    ewpList: json["ewpList"] == null ? null : List<EwpList>.from(json["ewpList"].map((x) => EwpList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gdList": gdList == null ? null : List<dynamic>.from(gdList!.map((x) => x.toJson())),
    "eeList": eeList == null ? null : List<dynamic>.from(eeList!.map((x) => x.toJson())),
    "ewpList": ewpList == null ? null : List<dynamic>.from(ewpList!.map((x) => x.toJson())),
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
  UpdateBy? updateBy;
  DateTime? updateTime;
  bool? isDelete;
  dynamic randomId;

  factory EwpList.fromJson(Map<String, dynamic> json) => EwpList(
    id: json["id"] == null ? null : json["id"],
    groupId: json["groupId"] == null ? null : json["groupId"],
    contactId: json["contactId"] == null ? null : json["contactId"],
    expenseId: json["expenseId"] == null ? null : json["expenseId"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    entryBy: json["entryBy"] == null ? null : json["entryBy"],
    entryTime: json["entryTime"] == null ? null : DateTime.parse(json["entryTime"]),
    updateBy: json["updateBy"] == null ? null : updateByValues.map![json["updateBy"]],
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
    "updateBy": updateBy == null ? null : updateByValues.reverse![updateBy],
    "updateTime": updateTime == null ? null : updateTime!.toIso8601String(),
    "isDelete": isDelete == null ? null : isDelete,
    "randomId": randomId,
  };
}

enum UpdateBy { ABC }

final updateByValues = EnumValues({
  "abc": UpdateBy.ABC
});

class GdList {
  GdList({
    this.id,
    this.randomId,
    this.name,
    this.type,
    this.image,
    this.banner,
    this.entryBy,
    this.entryTime,
    this.updateBy,
    this.updateTime,
    this.typeCheck,
    this.userId,
  });

  int? id;
  String? randomId;
  String? name;
  String? type;
  String? image;
  String? banner;
  String? entryBy;
  DateTime? entryTime;
  dynamic updateBy;
  DateTime? updateTime;
  int? typeCheck;
  int? userId;

  factory GdList.fromJson(Map<String, dynamic> json) => GdList(
    id: json["id"] == null ? null : json["id"],
    randomId: json["randomId"] == null ? null : json["randomId"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    image: json["image"] == null ? null : json["image"],
    banner: json["banner"] == null ? null : json["banner"],
    entryBy: json["entryBy"] == null ? null : json["entryBy"],
    entryTime: json["entryTime"] == null ? null : DateTime.parse(json["entryTime"]),
    updateBy: json["updateBy"],
    updateTime: json["updateTime"] == null ? null : DateTime.parse(json["updateTime"]),
    typeCheck: json["type_Check"] == null ? null : json["type_Check"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "randomId": randomId == null ? null : randomId,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "image": image == null ? null : image,
    "banner": banner == null ? null : banner,
    "entryBy": entryBy == null ? null : entryBy,
    "entryTime": entryTime == null ? null : entryTime!.toIso8601String(),
    "updateBy": updateBy,
    "updateTime": updateTime == null ? null : updateTime!.toIso8601String(),
    "type_Check": typeCheck == null ? null : typeCheck,
    "userId": userId == null ? null : userId,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
