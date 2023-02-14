class BankTable {

  int? id;
  String? name;
  int? acno;
  String? ifsc;
  String? branchname;


  BankTable({this.id,required this.name,required this.acno,required this.ifsc, required this.branchname});

  BankTable.map(dynamic obj){
    this.id = obj['id'];
    this.name = obj['name'];
    this.acno = obj['acno'];
    this.ifsc = obj['ifsc'];
    this.branchname = obj['branchname'];
  }

  int? get bid => id;
  String? get bname => name;
  int? get bacno => acno;
  String? get bifsc => ifsc;
  String? get bbranchname => branchname;

  Map<String, dynamic> toMap(){

    return{'id': id,'name' : name,'acno' : acno, 'ifsc' : ifsc,'branchname': branchname};
  }

  BankTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.acno = map['acno'];
    this.ifsc = map['ifsc'];
    this.branchname = map['branchname'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Banktable{id: $id,name: $name, acno: $acno, ifsc: $ifsc, branchname: $branchname}';
  }

}