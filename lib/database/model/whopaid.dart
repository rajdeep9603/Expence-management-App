class WhoPaidTable{

  int? id;
  int? gid;
  int? cid;
  int? eid;
  double? price;
  String? enterby;
  String? entertime;

  WhoPaidTable({this.id,required this.gid, required this.cid, required this.eid, required this.enterby, required this.entertime, required this.price});

  WhoPaidTable.map(dynamic obj){
    this.id = obj['id'];
    this.gid = obj['gid'];
    this.cid = obj['cid'];
    this.eid = obj['eid'];
    this.price = obj['price'];
    this.enterby = obj['entryby'];
    this.entertime = obj['entrytime'];
  }

  int? get wid => id;
  int? get wgid => gid;
  int? get wcid => cid;
  int? get weid => eid;
  double? get wprice => price;
  String? get wentryby => enterby;
  String? get wentrytime => entertime;


  Map<String, dynamic> toMap(){
    return{'id' : id,'gid' : gid,'price': price,'cid': cid,'eid': eid,'entryby': enterby,'entrytime': entertime};
  }

  WhoPaidTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.gid = map['gid'];
    this.cid = map['cid'];
    this.eid = map['eid'];
    this.price = map['price'];
    this.enterby = map['entryby'];
    this.entertime = map['entrytime'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Whopaid{id: $id, gid: $gid, price: $price,cid: $cid,eid: $eid, entryby: $enterby, entrytime: $entertime}';
  }

}