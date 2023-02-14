// To parse this JSON data, do
//
//     final addContact = addContactFromJson(jsonString);

import 'dart:convert';

AddContact addContactFromJson(String str) => AddContact.fromJson(json.decode(str));

String addContactToJson(AddContact data) => json.encode(data.toJson());

class AddContact {
  AddContact({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  List<Datum>? data;

  factory AddContact.fromJson(Map<String, dynamic> json) => AddContact(
    message: json["message"] == null ? null : json["message"],
    messageCode: json["messageCode"] == null ? null : json["messageCode"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "messageCode": messageCode == null ? null : messageCode,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
