import 'package:flutter/services.dart';

class LoanTable{

  int? id;
  double? amount;
  String? giverName;
  double? interest;
  String? starttime;
  String? endtime;
  String? type;

  LoanTable({ required this.id,required this.amount, required this.giverName, required this.interest, required this.starttime, required this.endtime,required this.type});

  LoanTable.map(dynamic obj){
    this.id = obj['id'];
    this.amount = obj['amount'];
    this.giverName = obj['giverName'];
    this.interest = obj['interest'];
    this.starttime = obj['starttime'];
    this.endtime = obj['endtime'];
    this.type = obj['type'];
  }

  int? get lid => id;
  double? get lamount => amount;
  double? get linterest => interest;
  String? get lgiverName => giverName;
  String? get lstarttime => starttime;
  String? get lendtime => endtime;
  String? get ltype => type;

  Map<String, dynamic> toMap(){

    return{'id': id,'amount' : amount,'giverName' : giverName, 'interest' : interest,'starttime': starttime,'endtime': endtime,'type':type};
  }

  LoanTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.amount = map['amount'];
    this.giverName = map['giverName'];
    this.interest = map['interest'];
    this.starttime = map['starttime'];
    this.endtime = map['endtime'];
    this.type = map['type'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Loantable{id: $id,amount: $amount, giverName: $giverName, interest: $interest, starttime: $starttime, endstart: $endtime, type: $type}';
  }

}