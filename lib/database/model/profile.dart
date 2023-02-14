import 'dart:typed_data';

class ProfileTable {

  int? uid;
  String? uname;
  int? gender;
  int? mobile;
  String? mail;
  String? address;
  String? birthdate;
  Uint8List? uimage;

  ProfileTable({this.uid,required this.uname,required this.uimage,required this.birthdate, required this.mobile, required this.address, required this.mail, required this.gender});

  ProfileTable.map(dynamic obj){
    this.uid = obj['uid'];
    this.uname = obj['uname'];
    this.gender = obj['gender'];
    this.mobile = obj['mobile'];
    this.mail = obj['mail'];
    this.address = obj['address'];
    this.birthdate = obj['birthdate'];
    this.uimage = obj['uimage'];
  }

  int? get userid => uid;
  int? get ugender => gender;
  int? get umobile => mobile;
  String? get username => uname;
  String? get umail => mail;
  String? get uaddress => address;
  String? get ubirthdate => birthdate;
  Uint8List? get userimage => uimage;

  Map<String, dynamic> toMap(){
    return{'uid' : uid,'uimage' : uimage,'uname' : uname,'gender' : gender,'mobile' : mobile,'mail':mail,'address': address,'birthdate':birthdate};
  }

  ProfileTable.fromMap(Map<String, dynamic> map){
    this.uid = map['uid'];
    this.uname = map['uname'];
    this.gender = map['gender'];
    this.mobile = map['mobile'];
    this.mail = map['mail'];
    this.address = map['address'];
    this.birthdate = map['birthdate'];
    this.uimage = map['uimage'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Profiletable{uid: $uid, uimage: $uimage, uname: $uname, gender: $gender, mobile: $mobile, mail: $mail, address: $address, birthdate: $birthdate}';
  }

}