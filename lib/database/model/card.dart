class CardTable {

  int? id;
  String? name;
  String? number;
  int? type;
  String? cvv;
  String? expirydate;
  int? back;

  CardTable({this.id,required this.name,required this.cvv,required this.number, required this.type, required this.expirydate, required this.back});

  CardTable.map(dynamic obj){
    this.id = obj['id'];
    this.name = obj['name'];
    this.number = obj['number'];
    this.type = obj['type'];
    this.cvv = obj['cvv'];
    this.expirydate = obj['date'];
    this.back = obj['back'];
  }

  int? get cid => id;
  String? get cname => name;
  String? get cnumber => number;
  int? get ctype => type;
  String? get ccvv => cvv;
  int? get cback => back;
  String? get cexpirydate => expirydate;


  Map<String, dynamic> toMap(){

    return{'id': id,'name' : name,'number' : number, 'type' : type, 'cvv': cvv, 'date':expirydate, 'back': back};
  }

  CardTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.number = map['number'];
    this.type = map['type'];
    this.cvv = map['cvv'];
    this.expirydate = map['date'];
    this.back = map['back'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Cardtable{id: $id,name: $name, number : $number, type : $type, cvv: $cvv, date: $expirydate, back: $back}';
  }

}