import 'dart:convert';

InsertGroup insertGroupFromJson(String str) => InsertGroup.fromJson(json.decode(str));

String insertGroupToJson(InsertGroup data) => json.encode(data.toJson());

class InsertGroup {
  InsertGroup({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  Data? data;

  factory InsertGroup.fromJson(Map<String, dynamic> json) => InsertGroup(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
