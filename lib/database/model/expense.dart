import 'dart:typed_data';

class ExpenseTable{

  int? id;
  int? gid;
  String? catagoryname;
  String? catagorytitle;
  String? catagorydis;
  String? date;
  String? entryby;
  String? entrytime;
  double? price;
  Uint8List? logo;

  ExpenseTable({this.id, required this.entryby, required this.entrytime,required this.date, required this.gid, required this.price, required this.catagorydis, required this.catagoryname, required this.logo, required this.catagorytitle});

  ExpenseTable.map(dynamic obj){
    this.id = obj['id'];
    this.gid = obj['gid'];
    this.catagoryname = obj['name'];
    this.catagorytitle = obj['title'];
    this.logo = obj['image'];
    this.price = obj['price'];
    this.catagorydis = obj['dis'];
    this.date = obj['date'];
    this.entryby = obj['entryby'];
    this.entrytime = obj['entrytime'];
  }

  int? get allid => id;
  int? get allgid => gid;
  String? get allcatagoryname => catagoryname;
  String? get allcatagorytitle => catagorytitle;
  String? get allcatagorydis => catagorydis;
  String? get tdate => date;
  double? get tprice => price;
  Uint8List? get tlogo => logo;

  Map<String, dynamic> toMap(){
    return{'id' : id,'gid' : gid,'image' : logo,'dis': catagorydis, 'price':price, 'name': catagoryname, 'date': date, 'title': catagorytitle, 'entryby': entryby, 'entrytime': entrytime};
  }

  ExpenseTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.gid = map['gid'];
    this.catagoryname = map['name'];
    this.catagorytitle = map['title'];
    this.logo = map['image'];
    this.price = map['price'];
    this.catagorydis = map['dis'];
    this.date = map['date'];
    this.entryby = map['entryby'];
    this.entrytime = map['entrytime'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Expensetable{id : $id,gid : $gid,image : $logo,dis: $catagorydis, price: $price, name: $catagoryname, date: $date, title: $catagorytitle, entryby: $entryby, entrytime: $entrytime}';
  }

}