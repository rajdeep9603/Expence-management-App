
class ContactTable {

  int? id;
  int? gid;
  String? contactname;
  String? contactnumber;
  String? enterby;
  String? entertime;

  ContactTable({this.id,required this.gid, required this.contactname, required this.contactnumber, required this.enterby, required this.entertime});

  ContactTable.map(dynamic obj){
    this.id = obj['id'];
    this.gid = obj['gid'];
    this.contactname = obj['name'];
    this.contactnumber = obj['number'];
    this.enterby = obj['entryby'];
    this.entertime = obj['entrytime'];
  }

  int? get conid => id;
  int? get congid => gid;
  String? get conname => contactname;
  String? get connumber => contactnumber;
  String? get conentryby => enterby;
  String? get conentrytime => entertime;


  Map<String, dynamic> toMap(){
    return{'id' : id,'gid' : gid,'name': contactname,'number': contactnumber,'entryby': enterby,'entrytime': entertime};
  }

  ContactTable.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.gid = map['gid'];
    this.contactname = map['name'];
    this.contactnumber = map['number'];
    this.enterby = map['entryby'];
    this.entertime = map['entrytime'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Groupheader{id: $id, gid: $gid, name: $contactname, number: $contactnumber, entryby: $enterby, entrytime: $entertime}';
  }

}