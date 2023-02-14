// To parse this JSON data, do
//
//     final afterOtpVerification = afterOtpVerificationFromJson(jsonString);

import 'dart:convert';

AfterOtpVerification afterOtpVerificationFromJson(String str) => AfterOtpVerification.fromJson(json.decode(str));

String afterOtpVerificationToJson(AfterOtpVerification data) => json.encode(data.toJson());

class AfterOtpVerification {
  AfterOtpVerification({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  Data? data;

  factory AfterOtpVerification.fromJson(Map<String, dynamic> json) => AfterOtpVerification(
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
    this.emum,
    this.otp,
    this.apiKey,
  });

  Emum? emum;
  dynamic otp;
  dynamic apiKey;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    emum: json["emum"] == null ? null : Emum.fromJson(json["emum"]),
    otp: json["otp"],
    apiKey: json["apiKey"],
  );

  Map<String, dynamic> toJson() => {
    "emum": emum == null ? null : emum!.toJson(),
    "otp": otp,
    "apiKey": apiKey,
  };
}

class Emum {
  Emum({
    this.id,
    this.userName,
    this.mobileNo,
    this.password,
    this.isConfirmed,
    this.type,
    this.randomId,
  });

  int? id;
  String? userName;
  String? mobileNo;
  String? password;
  bool? isConfirmed;
  int? type;
  String? randomId;

  factory Emum.fromJson(Map<String, dynamic> json) => Emum(
    id: json["id"] == null ? null : json["id"],
    userName: json["userName"] == null ? null : json["userName"],
    mobileNo: json["mobileNo"] == null ? null : json["mobileNo"],
    password: json["password"] == null ? null : json["password"],
    isConfirmed: json["isConfirmed"] == null ? null : json["isConfirmed"],
    type: json["type"] == null ? null : json["type"],
    randomId: json["randomId"] == null ? null : json["randomId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userName": userName == null ? null : userName,
    "mobileNo": mobileNo == null ? null : mobileNo,
    "password": password == null ? null : password,
    "isConfirmed": isConfirmed == null ? null : isConfirmed,
    "type": type == null ? null : type,
    "randomId": randomId == null ? null : randomId,
  };
}
