// To parse this JSON data, do
//
//     final deleteExpense = deleteExpenseFromJson(jsonString);

import 'dart:convert';

DeleteExpense deleteExpenseFromJson(String str) => DeleteExpense.fromJson(json.decode(str));

String deleteExpenseToJson(DeleteExpense data) => json.encode(data.toJson());

class DeleteExpense {
  DeleteExpense({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  String? data;

  factory DeleteExpense.fromJson(Map<String, dynamic> json) => DeleteExpense(
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
