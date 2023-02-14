class SendTable{

  int? id;
  double? samount;
  String? borrowerName;
  double? sinterest;
  String? startDate;
  String? endDate;

  SendTable({required this.id,required this.borrowerName,required this.samount, required this.sinterest, required this.startDate, required this.endDate});

  SendTable.map(dynamic obj){
    this.id = obj['id'];
    this.samount = obj['amount'];
    this.borrowerName = obj['borrowerName'];
    this.sinterest = obj['interest'];
    this.startDate = obj['startDate'];
    this.endDate = obj['endDate'];
  }

  int? get sendid => id;
  double? get sendamount => samount;
  String? get sendborrowerName => borrowerName;
  double? get sendinterest => sinterest;
  String? get startday => startDate;
  String? get endday => endDate;

  Map<String, dynamic> toMap(){
    return{'id': id,'amount' : samount,'borrowerName' : borrowerName, 'interest' : sinterest,'startDate': startDate,'endDate': endDate};
  }

  SendTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.samount = map['amount'];
    this.borrowerName = map['borrowerName'];
    this.sinterest = map['interest'];
    this.startDate = map['startDate'];
    this.endDate = map['endDate'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Sendtable{id: $id,amount: $samount, borrowerName: $borrowerName, interest: $sinterest, startDate: $startDate, endDate: $endDate}';
  }

}