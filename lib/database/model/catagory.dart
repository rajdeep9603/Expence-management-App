
class CatagoryTable {

  String? title;


  CatagoryTable({required this.title});

  CatagoryTable.map(dynamic obj){
    this.title = obj['title'];
  }

  String? get ctitle => title;

  Map<String, dynamic> toMap(){
    return{'title' : title};
  }

  CatagoryTable.fromMap(Map<String, dynamic> map){
    this.title = map['title'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Catagorytable{title: $title}';
  }

}