import 'package:personal_expenses/database/model/bank.dart';
import 'package:personal_expenses/database/model/card.dart';
import 'package:personal_expenses/database/model/catagory.dart';
import 'package:personal_expenses/database/model/catagorywithimage.dart';
import 'package:personal_expenses/database/model/contact.dart';
import 'package:personal_expenses/database/model/expense.dart';
import 'package:personal_expenses/database/model/group.dart';
import 'package:personal_expenses/database/model/loan.dart';
import 'package:personal_expenses/database/model/profile.dart';
import 'package:personal_expenses/database/model/receive.dart';
import 'package:personal_expenses/database/model/send.dart';
import 'package:personal_expenses/database/model/transaction.dart';
import 'package:personal_expenses/database/model/whopaid.dart';
import 'package:personal_expenses/util/string_file.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{

  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database? _database;
  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  //catagorywithimage
  final String tablename = 'catagorywithimage';
  final String title = 'title';
  final String image = 'image';

  //bank
  final String tablename1 = 'bank';
  final String bid = 'id';
  final String name = 'name';
  final String acno = 'acno';
  final String ifsc = 'ifsc';
  final String branchname = 'branchname';

  //profile
  final String tablename2 = 'profile';
  final String uid = 'uid';
  final String uname = 'uname';
  final String mail = 'mail';
  final String mobile = 'mobile';
  final String address = 'address';
  final String birthdate = 'birthdate';
  final String gender = 'gender';
  final String uimage = 'uimage';

  //loan
  final String tablename3 = 'loan';
  final String lid = 'id';
  final String amount = 'amount';
  final String interest = 'interest';
  final String giverName = 'giverName';
  final String starttime = 'starttime';
  final String endtime = 'endtime';
  final String type = 'type';

  //send
  final String tablename4 = 'send';
  final String sid = 'id';
  final String samount = 'amount';
  final String sinterest = 'interest';
  final String borrowerName = 'borrowerName';
  final String startDate = 'startDate';
  final String endDate = 'endDate';

  //receive
  final String tablename5 = 'receive';
  final String rid = 'id';
  final String ramount = 'amount';
  final String rinterest = 'interest';
  final String rborrowerName = 'borrowerName';
  final String rstartDate = 'startDate';
  final String rendDate = 'endDate';

  //transaction
  final String tablename6 = 'history';
  final String tid = 'id';
  final String logo = 'logo';
  final String ttitle = 'title';
  final String tcatagory = 'catagory';
  final String subtitle = 'subtitle';
  final String price = 'price';
  final String ttype = 'type';
  final String ttypeid = 'typeid';
  final String tentrydate = 'entrydate';
  final String date = 'date';


  //group
  final String tablename7 = 'groupinfo';
  final String gid = 'id';
  final String gname = 'name';
  final String gtype = 'type';
  final String gimg = 'image';
  final String gbimg = 'bimage';
  final String gentryby = 'entryby';
  final String gentrytime = 'entrytime';

  //contact
  final String tablename8 = 'contact';
  final String contactid = 'id';
  final String contactgid = 'gid';
  final String contactname = 'name';
  final String contactnumber = 'number';
  final String contactentryby = 'entryby';
  final String contactentrytime = 'entrytime';

  //groupexpanse
  final String tablename9 = 'groupexpense';
  final String geid = 'id';
  final String gegid = 'gid';
  final String gecatagoryname = 'name';
  final String gecatagorytitle = 'title';
  final String gecatagoryicon = 'image';
  final String gecatagorydis = 'dis';
  final String gecatagorydate = 'date';
  final String gecatagoryprice = 'price';
  final String geentryby = 'entryby';
  final String geentrytime = 'entrytime';


  //whoid
  final String tablename10 = 'whopaid';
  final String wid = 'id';
  final String wgid = 'gid';
  final String wcid = 'cid';
  final String weid = 'eid';
  final String wprice = 'price';
  final String wentryby = 'entryby';
  final String wentrytime = 'entrytime';

  //card
  final String tablename11 = 'cards';
  final String cardid = 'id';
  final String cardName = 'name';
  final String cardType = 'type';
  final String cardNo = 'number';
  final String cardDate = 'date';
  final String cardcvv = 'cvv';
  final String cardback = 'back';


  Future<Database?> get db async{
    if(_database != null){
      return _database;
    }
    _database = await createdb();
    return _database;
  }

  Future<Database?> createdb() async {
    final database = openDatabase(
      join(await getDatabasesPath(), StringRes.dbName),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS $tablename($title TEXT, $image BLOB)',
        );
        await db.execute(
          'CREATE TABLE $tablename1($bid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $name TEXT, $acno INTEGER, $ifsc TEXT, $branchname TEXT)',
        );
        await db.execute(
          'CREATE TABLE IF NOT EXISTS $tablename2($uid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $uname TEXT, $gender INTEGER, $mail TEXT, $address TEXT, $mobile INTEGER, $uimage BLOB, $birthdate TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename3($lid INTEGER, $amount REAL, $interest REAL, $giverName TEXT, $starttime TEXT, $endtime TEXT, $type TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename4($sid INTEGER , $samount REAL, $sinterest REAL, $borrowerName TEXT, $startDate TEXT, $endDate TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename5($rid INTEGER , $ramount REAL, $rinterest REAL, $rborrowerName TEXT, $rstartDate TEXT, $rendDate TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename6($tid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $logo BLOB, $ttitle TEXT, $tcatagory TEXT, $subtitle TEXT, $price REAL, $ttype TEXT, $date TEXT, $ttypeid INTEGER, $tentrydate TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename7($gid INTEGER , $gname TEXT, $gtype INTEGER, $gimg BLOB, $gbimg BLOB, $gentryby TEXT, $gentrytime TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename8($contactid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $contactgid INTEGER, $contactname TEXT, $contactnumber TEXT, $contactentryby TEXT, $contactentrytime TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename9($geid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $gegid INTEGER, $gecatagoryname TEXT, $gecatagorytitle TEXT, $gecatagorydis TEXT, $gecatagorydate TEXT, $gecatagoryprice REAL, $gecatagoryicon BLOB, $geentryby TEXT, $geentrytime TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename10($wid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $wgid INTEGER, $wcid INTEGER, $weid INTEGER, $wprice REAL, $geentryby TEXT, $geentrytime TEXT)',
        );
        await db.execute(
          'CREATE TABLE $tablename11($cardid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $cardType INTEGER, $cardNo INTEGER, $cardcvv TEXT, $cardName TEXT, $cardDate TEXT, $cardback INTEGER)',
        );
      },
      version: 1,
    );
    return database;
  }


  //cards
  Future<int> insertCard(CardTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename11,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<CardTable>> cards() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename11);
    return List.generate(maps.length, (i) {
      return CardTable(
        back: maps[i]['back'],
        id: maps[i]['id'],
        name: maps[i]['name'],
        type: maps[i]['type'],
        cvv: maps[i]['cvv'],
        expirydate: maps[i]['date'],
        number: maps[i]['number'],
      );
    });
  }

  Future<int> updatecardInfo(CardTable modelC) async {
    final dbg = await db;
    int r = await dbg!.update(
      tablename11,modelC.toMap(), where: 'id = ?', whereArgs: [modelC.id],
    );
    return r;
  }

  Future<int> deleteonecard(int id) async {
    final dbg = await db;
    int result = await dbg!.delete(
      tablename11, where: 'id = ?', whereArgs: [id],
    );

    return result;
  }



  //whopaid
  Future<int> insertWhopaid(WhoPaidTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename10,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<WhoPaidTable?> getlastwho(int id) async {

    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT * FROM $tablename10 WHERE $wid = $id");
    if(result.length == 0 ){
      return null;
    }

    return WhoPaidTable.fromMap(result.first);
  }


  //groupexpense
  Future<int> insertExpense(ExpenseTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename9,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<ExpenseTable>> expenses() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename9);
    return List.generate(maps.length, (i) {
      return ExpenseTable(
          entrytime: maps[i]['entrytime'],
          entryby: maps[i]['entryby'],
          catagorydis: maps[i]['dis'],
          catagoryname: maps[i]['name'],
          catagorytitle: maps[i]['title'],
          date: maps[i]['date'],
          logo: maps[i]['image'],
          price: maps[i]['price'],
          id: maps[i]['id'],
          gid: maps[i]['gid']
      );
    });
  }

  Future<ExpenseTable?> getlaste(int id) async {

    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT * FROM $tablename9 WHERE $geid = $id");
    if(result.length == 0 ){
      return null;
    }

    return ExpenseTable.fromMap(result.first);
  }


  //contact
  Future<int> insertContact(ContactTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename8,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<ContactTable>> contacts() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename8);
    return List.generate(maps.length, (i) {
      return ContactTable(
          enterby: maps[i]['entryby'],
          entertime: maps[i]['entrytime'],
          contactname: maps[i]['name'],
          contactnumber: maps[i]['number'],
          id: maps[i]['id'],
          gid: maps[i]['gid']
      );
    });
  }



  //group
  Future<int> insertinGroup(GroupHeader catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename7,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<GroupHeader>> allgroups() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename7);
    return List.generate(maps.length, (i) {
      return GroupHeader(
        bimage: maps[i]['bimage'],
        username: maps[i]['entryby'],
        time: maps[i]['entrytime'],
        name: maps[i]['name'],
        image: maps[i]['image'],
        id: maps[i]['id'],
        type: maps[i]['type']
      );
    });
  }

  Future<GroupHeader?> getSingal(int id) async {

    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT * FROM $tablename7 WHERE $gid = $id");
    if(result.length == 0 ){
      return null;
    }

    return GroupHeader.fromMap(result.first);
  }

  //categorywithimage
  Future<int> insertCatagoryWithImage(CatagoryWithImageTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  Future<List<CatagoryWithImageTable>> catagorys() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename);
    return List.generate(maps.length, (i) {
      return CatagoryWithImageTable(
        title: maps[i]['title'],
        image: maps[i]['image'],
      );
    });
  }

  //transaction
  Future<int> insertTransaction(TransactionTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename6,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  Future<List<TransactionTable>> transactions() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename6);
    return List.generate(maps.length, (i) {
      return TransactionTable(
        tcatagory: maps[i]['catagory'],
        entrydate: maps[i]['entrydate'],
        ttypeid: maps[i]['typeid'],
        ttype: maps[i]['type'],
        ttitle: maps[i]['title'],
        price: maps[i]['price'],
        logo: maps[i]['logo'],
        subtitle: maps[i]['subtitle'],
        date: maps[i]['date'],
        id: maps[i]['id'],
      );
    });
  }

  Future<TransactionTable?> getLastTransaction(int id1) async {

    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT * FROM $tablename6 WHERE $tid = $id1");
    if(result.length == 0 ){
      return null;
    }

    return TransactionTable.fromMap(result.first);
  }


  Future<int> updateTransactionInfo(TransactionTable modelC) async {
    final dbg = await db;
    int r = await dbg!.update(
      tablename6,modelC.toMap(), where: 'id = ?', whereArgs: [modelC.id],
    );
    return r;

  }


  Future<int> deleteTransaction(int id) async {
    final dbg = await db;
    int result = await dbg!.delete(
      tablename6, where: 'id = ?', whereArgs: [id],
    );

    return result;
  }

  //bank
  Future<int> insertBank(BankTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename1,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;

  }

  Future<List<BankTable>> banks() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename1);
    return List.generate(maps.length, (i) {
      return BankTable(
        name: maps[i]['name'],
        acno: maps[i]['acno'],
        ifsc: maps[i]['ifsc'],
        branchname: maps[i]['branchname'],
        id: maps[i]['id'],
      );
    });
  }


  Future<BankTable?> getSingalBank(int id1) async {

    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT * FROM $tablename1 WHERE $bid = $id1");
    if(result.length == 0 ){
      return null;
    }

    return BankTable.fromMap(result.first);
  }

  Future<int> updateBankInfo(BankTable modelC) async {
    final dbg = await db;
    int r = await dbg!.update(
      tablename1,modelC.toMap(), where: 'id = ?', whereArgs: [modelC.id],
    );

    //var rr = await dbg!.rawUpdate('UPDATE $tablename1 SET $name = \'${modelC.name}\', $acno = \'${modelC.acno}\', $ifsc = \'${modelC.ifsc}\', $branchname = \'${modelC.branchname}\' WHERE $acno = $id');

    return r;

  }



  //profile
  Future<int> insertProfile(ProfileTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename2,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<ProfileTable>> profiles() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename2);
    return List.generate(maps.length, (i) {
      return ProfileTable(
        address: maps[i]['address'],
        birthdate: maps[i]['birthdate'],
        gender: maps[i]['gender'],
        mail: maps[i]['mail'],
        mobile: maps[i]['mobile'],
        uimage: maps[i]['uimage'],
        uname: maps[i]['uname'],
        uid: maps[i]['uid'],
      );
    });
  }

  Future<int> updateUserProfile(ProfileTable modelC) async {
    final dbg = await db;
    int r = await dbg!.update(
      tablename2,modelC.toMap(), where: 'uid = ?', whereArgs: [modelC.uid],
    );

    return r;
  }


  //loan
  Future<int> insertLoan(LoanTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename3,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<LoanTable>> loans() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename3);
    return List.generate(maps.length, (i) {
      return LoanTable(
        amount: maps[i]['amount'],
        id: maps[i]['id'],
        endtime: maps[i]['endtime'],
        giverName: maps[i]['giverName'],
        interest: maps[i]['interest'],
        starttime: maps[i]['starttime'],
        type: maps[i]['type'],
      );
    });
  }

  Future<int> updateLoan(LoanTable modelC) async {
    final dbg = await db;
    int r = await dbg!.update(
      tablename3,modelC.toMap(), where: 'id = ?', whereArgs: [modelC.id],
    );

    return r;
  }


  Future<int> deleteLoan(int id) async {
    final dbg = await db;
    int result = await dbg!.delete(
      tablename3, where: 'id = ?', whereArgs: [id],
    );

    return result;
  }

  //send
  Future<int> insertSend(SendTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename4,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<SendTable>> sends() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename4);
    return List.generate(maps.length, (i) {
      return SendTable(
        borrowerName: maps[i]['borrowerName'],
        endDate: maps[i]['endDate'],
        samount: maps[i]['amount'],
        sinterest: maps[i]['interest'],
        startDate: maps[i]['startDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<SendTable?> getSingalSend(int id1) async {

    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT * FROM $tablename4 WHERE $sid = $id1");
    if(result.length == 0 ){
      return null;
    }

    return SendTable.fromMap(result.first);
  }

  Future<int> updateSend(SendTable modelC) async {
    final dbg = await db;
    int r = await dbg!.update(
      tablename4,modelC.toMap(), where: 'id = ?', whereArgs: [modelC.id],
    );

    return r;
  }

  Future<int> deleteSend(int id) async {
    final dbg = await db;
    int result = await dbg!.delete(
      tablename4, where: 'id = ?', whereArgs: [id],
    );

    return result;
  }


  //receive
  Future<int> insertReceive(RecieveTable catagory) async {
    final dbg = await db;
    int result = await dbg!.insert(
      tablename5,catagory.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<RecieveTable>> receives() async {
    final dbg = await db;
    final List<Map<String, dynamic>> maps = await dbg!.query(tablename5);
    return List.generate(maps.length, (i) {
      return RecieveTable(
        borrowerName: maps[i]['borrowerName'],
        endDate: maps[i]['endDate'],
        ramount: maps[i]['amount'],
        rinterest: maps[i]['interest'],
        startDate: maps[i]['startDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<RecieveTable?> getSingalReceive(int id1) async {

    var dbClient = await db;
    var result = await dbClient!.rawQuery("SELECT * FROM $tablename5 WHERE $rid = $id1");
    if(result.length == 0 ){
      return null;
    }

    return RecieveTable.fromMap(result.first);
  }

  Future<int> updateReceive(RecieveTable modelC) async {
    final dbg = await db;
    int r = await dbg!.update(
      tablename5,modelC.toMap(), where: 'id = ?', whereArgs: [modelC.id],
    );

    return r;
  }

  Future<int> deleteReceive(int id) async {
    final dbg = await db;
    int result = await dbg!.delete(
      tablename5, where: 'id = ?', whereArgs: [id],
    );

    return result;
  }


  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }

}


