import 'dart:typed_data';

class TransactionTable{

  int? id;
  String? tcatagory;
  String? ttitle;
  String? subtitle;
  String? ttype;
  int? ttypeid;
  String? date;
  String? entrydate;
  double? price;
  Uint8List? logo;

  TransactionTable({this.id, required this.tcatagory,required this.date, required this.entrydate, required this.ttypeid,required this.ttype, required this.price, required this.subtitle, required this.ttitle, required this.logo});

  TransactionTable.map(dynamic obj){
    this.id = obj['id'];
    this.tcatagory = obj['catagory'];
    this.ttitle = obj['title'];
    this.logo = obj['logo'];
    this.subtitle = obj['subtitle'];
    this.price = obj['price'];
    this.ttype = obj['type'];
    this.ttypeid = obj['typeid'];
    this.date = obj['date'];
    this.entrydate = obj['entrydate'];
  }

  int? get allid => id;
  String? get allcata => tcatagory;
  String? get alltitle => ttitle;
  String? get tsubtitle => subtitle;
  String? get alltype => ttype;
  String? get tdate => date;
  double? get tprice => price;
  Uint8List? get tlogo => logo;

  Map<String, dynamic> toMap(){
    return{'id' : id,'title' : ttitle,'catagory' : tcatagory,'logo' : logo,'subtitle': subtitle,'price':price,'type': ttype,'date': date, 'typeid': ttypeid, 'entrydate': entrydate};
  }

  TransactionTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.ttitle = map['title'];
    this.tcatagory = map['catagory'];
    this.logo = map['logo'];
    this.subtitle = map['subtitle'];
    this.price = map['price'];
    this.ttype = map['type'];
    this.date = map['date'];
    this.ttypeid = map['typeid'];
    this.entrydate = map['entrydate'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Transactiontable{title: $ttitle, catagory : $tcatagory,logo: $logo, id: $id, subtitle: $subtitle, price: $price, type: $ttype, date: $date, typeid: $ttypeid, entrydate: $entrydate}';
  }

}