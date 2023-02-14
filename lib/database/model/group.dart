import 'dart:typed_data';

class GroupHeader {

  int? id;
  String? name;
  String? username;
  String? time;
  int? type;
  Uint8List? image;
  Uint8List? bimage;

  GroupHeader({required this.id,required this.name, required this.image, required this.type, required this.username, required this.time, required this.bimage});

  GroupHeader.map(dynamic obj){
    this.id = obj['id'];
    this.name = obj['name'];
    this.type = obj['type'];
    this.image = obj['image'];
    this.bimage = obj['bimage'];
    this.username = obj['entryby'];
    this.time = obj['entrytime'];
  }

  int? get gid => id;
  int? get gtype => type;
  String? get gname => name;
  String? get guser => username;
  String? get gtime => time;
  Uint8List? get gimage => image;

  Map<String, dynamic> toMap(){
    return{'name' : name,'image' : image,'id': id,'type': type,'entryby': username,'entrytime': time,'bimage': bimage};
  }

  GroupHeader.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.type = map['type'];
    this.image = map['image'];
    this.bimage = map['bimage'];
    this.username = map['entryby'];
    this.time = map['entrytime'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Groupheader{id: $id, name: $name, type: $type, image: $image, entryby: $username, entrytime: $time, bimage: $bimage}';
  }

}