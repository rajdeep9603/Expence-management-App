// To parse this JSON data, do
//
//     final getSingalGroupContact = getSingalGroupContactFromJson(jsonString);

import 'dart:convert';

GetSingalGroupContact getSingalGroupContactFromJson(String str) => GetSingalGroupContact.fromJson(json.decode(str));

String getSingalGroupContactToJson(GetSingalGroupContact data) => json.encode(data.toJson());

class GetSingalGroupContact {
  GetSingalGroupContact({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  Data? data;

  factory GetSingalGroupContact.fromJson(Map<String, dynamic> json) => GetSingalGroupContact(
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
    this.eg,
    this.gdList,
    this.ecList,
  });

  dynamic eg;
  List<GdList>? gdList;
  List<EcList>? ecList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    eg: json["eg"],
    gdList: json["gdList"] == null ? null : List<GdList>.from(json["gdList"].map((x) => GdList.fromJson(x))),
    ecList: json["ecList"] == null ? null : List<EcList>.from(json["ecList"].map((x) => EcList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "eg": eg,
    "gdList": gdList == null ? null : List<dynamic>.from(gdList!.map((x) => x.toJson())),
    "ecList": ecList == null ? null : List<dynamic>.from(ecList!.map((x) => x.toJson())),
  };
}

class EcList {
  EcList({
    this.id,
    this.groupId,
    this.name,
    this.mobileNo,
    this.entryBy,
    this.entryTime,
    this.updateBy,
    this.updateTime,
    this.randomId,
  });

  int? id;
  int? groupId;
  String? name;
  String? mobileNo;
  String? entryBy;
  DateTime? entryTime;
  dynamic updateBy;
  DateTime? updateTime;
  String? randomId;

  factory EcList.fromJson(Map<String, dynamic> json) => EcList(
    id: json["id"] == null ? null : json["id"],
    groupId: json["groupId"] == null ? null : json["groupId"],
    name: json["name"] == null ? null : json["name"],
    mobileNo: json["mobileNo"] == null ? null : json["mobileNo"],
    entryBy: json["entryBy"] == null ? null : json["entryBy"],
    entryTime: json["entryTime"] == null ? null : DateTime.parse(json["entryTime"]),
    updateBy: json["updateBy"],
    updateTime: json["updateTime"] == null ? null : DateTime.parse(json["updateTime"]),
    randomId: json["randomId"] == null ? null : json["randomId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "groupId": groupId == null ? null : groupId,
    "name": name == null ? null : name,
    "mobileNo": mobileNo == null ? null : mobileNo,
    "entryBy": entryBy == null ? null : entryBy,
    "entryTime": entryTime == null ? null : entryTime!.toIso8601String(),
    "updateBy": updateBy,
    "updateTime": updateTime == null ? null : updateTime!.toIso8601String(),
    "randomId": randomId == null ? null : randomId,
  };
}

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
