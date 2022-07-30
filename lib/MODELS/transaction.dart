import 'package:credo/MODELS/db.dart';


class Transaction {
  final int? id;
  final double? usdDebit;
  final double ? cdfDebit;
  final double? usdCredit ;
  final double? cdfCredit; 
 
  final int ?clientId;
  final String? description;
  final DateTime ? dateRecord;
  const Transaction({this.id, this.usdDebit, this.cdfDebit, this.cdfCredit, this.usdCredit, this.clientId, this.description,this.dateRecord});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usdDebit': usdDebit,
      'cdfDebit': cdfDebit,
      'cdfCredit': cdfCredit,
      'usdCredit': usdCredit,
      'clientId':clientId,
      'description':description,
      'dateRecord':dateRecord
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'usdDebit': usdDebit,
      'cdfDebit': cdfDebit,
      'cdfCredit': cdfCredit,
      'usdCredit': usdCredit,
      'clientId':clientId,
      'description':description,
      'dateRecord':dateRecord
      
    };
  }

  Future<Map<String, String>> add1() {
    Db db = Db();
    return db.add("users", toMap());
  }
  Future<Map<String, dynamic>> add() {
    Db db = Db();
    return db.add("transactions", toMapWithId());
  }

 
  Future get() {
    Db db = Db();
    return db.fetch("SELECT * FROM transactions");
  }
  Future getByClientId(int clientId) {
    Db db = Db();
    return db.fetch(
      "SELECT * FROM transactions where clientId=$clientId",
    );
  }


}
