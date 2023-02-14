class RecieveTable{

  int? id;
  double? ramount;
  String? borrowerName;
  double? rinterest;
  String? startDate;
  String? endDate;

  RecieveTable({required this.id,required this.borrowerName,required this.ramount, required this.rinterest, required this.startDate, required this.endDate});

  RecieveTable.map(dynamic obj){
    this.id = obj['id'];
    this.ramount = obj['amount'];
    this.borrowerName = obj['borrowerName'];
    this.rinterest = obj['interest'];
    this.startDate = obj['startDate'];
    this.endDate = obj['endDate'];
  }

  int? get reid => id;
  double? get reamount => ramount;
  String? get reborrowerName => borrowerName;
  double? get reinterest => rinterest;
  String? get startday => startDate;
  String? get endday => endDate;

  Map<String, dynamic> toMap(){
    return{'id': id,'amount' : ramount,'borrowerName' : borrowerName, 'interest' : rinterest,'startDate': startDate,'endDate': endDate};
  }

  RecieveTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.ramount = map['amount'];
    this.borrowerName = map['borrowerName'];
    this.rinterest = map['interest'];
    this.startDate = map['startDate'];
    this.endDate = map['endDate'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Receivetble{id: $id,amount: $ramount, borrowerName: $borrowerName, interest: $rinterest, startDate: $startDate, endDate: $endDate}';
  }

}