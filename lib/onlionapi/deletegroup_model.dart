// To parse this JSON data, do
//
//     final groupDelete = groupDeleteFromJson(jsonString);

import 'dart:convert';

GroupDelete groupDeleteFromJson(String str) => GroupDelete.fromJson(json.decode(str));

String groupDeleteToJson(GroupDelete data) => json.encode(data.toJson());

class GroupDelete {
  GroupDelete({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  String? data;

  factory GroupDelete.fromJson(Map<String, dynamic> json) => GroupDelete(
    message: json["message"] == null ? null : json["message"],
    messageCode: json["messageCode"] == null ? null : json["messageCode"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "messageCode": messageCode == null ? null : messageCode,
    "status": status == null ? null : status,
    "data": data == null ? null : data,
  };
}
