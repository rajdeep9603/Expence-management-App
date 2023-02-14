import 'dart:typed_data';

class CatagoryWithImageTable {

  String? title;
  Uint8List? image;

  CatagoryWithImageTable({required this.title,required this.image});

  CatagoryWithImageTable.map(dynamic obj){
    this.title = obj['title'];
    this.image = obj['image'];
  }

  String? get ctitle => title;
  Uint8List? get cimage => image;

  Map<String, dynamic> toMap(){
    return{'title' : title,'image' : image};
  }

  CatagoryWithImageTable.fromMap(Map<String, dynamic> map){
    this.title = map['title'];
    this.image = map['image'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'CatagoryWithImagetable{title: $title, image: $image}';
  }

}