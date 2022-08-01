import 'package:credo/MODELS/db.dart';

class Transaction {
  final int? id;
  final double? usdDebit;
  final double? cdfDebit;
  final double? usdCredit;
  final double? cdfCredit;

  final int? clientId;
  final String? description;
  final String? paymentDate;
  final String? typeOp;
  const Transaction(
      {this.id,
      this.usdDebit,
      this.cdfDebit,
      this.cdfCredit,
      this.usdCredit,
      this.clientId,
      this.description,
      this.paymentDate,
      this.typeOp});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usdDebit': usdDebit,
      'cdfDebit': cdfDebit,
      'cdfCredit': cdfCredit,
      'usdCredit': usdCredit,
      'clientId': clientId,
      'description': description,
      'paymentDate': paymentDate,
      'typeOp': typeOp
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'usdDebit': usdDebit,
      'cdfDebit': cdfDebit,
      'cdfCredit': cdfCredit,
      'usdCredit': usdCredit,
      'clientId': clientId,
      'description': description,
      'paymentDate': paymentDate,
      'typeOp': typeOp
    };
  }

  Future<Map<String, dynamic>> add() {
    Db db = Db();
    return db.add("transactions", toMapWithId());
  }

  Future get() {
    Db db = Db();
    return db.fetch("SELECT * FROM transactions ORDER BY id DESC");
  }

  Future getByClientId(id) {
    Db db = Db();
    return db.fetch(
      "SELECT * FROM transactions where clientId=$id ORDER BY id DESC",
    );
  }
}
