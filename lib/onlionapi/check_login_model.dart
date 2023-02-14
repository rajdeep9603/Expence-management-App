// To parse this JSON data, do
//
//     final loginCheck = loginCheckFromJson(jsonString);

import 'dart:convert';

LoginCheck loginCheckFromJson(String str) => LoginCheck.fromJson(json.decode(str));

String loginCheckToJson(LoginCheck data) => json.encode(data.toJson());

class LoginCheck {
  LoginCheck({
    this.message,
    this.messageCode,
    this.status,
    this.data,
  });

  String? message;
  int? messageCode;
  bool? status;
  Data? data;

  factory LoginCheck.fromJson(Map<String, dynamic> json) => LoginCheck(
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
  dynamic userName;
  dynamic mobileNo;
  dynamic password;
  bool? isConfirmed;
  int? type;
  dynamic randomId;

  factory Emum.fromJson(Map<String, dynamic> json) => Emum(
    id: json["id"] == null ? null : json["id"],
    userName: json["userName"],
    mobileNo: json["mobileNo"],
    password: json["password"],
    isConfirmed: json["isConfirmed"] == null ? null : json["isConfirmed"],
    type: json["type"] == null ? null : json["type"],
    randomId: json["randomId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userName": userName,
    "mobileNo": mobileNo,
    "password": password,
    "isConfirmed": isConfirmed == null ? null : isConfirmed,
    "type": type == null ? null : type,
    "randomId": randomId,
  };
}
