import 'package:credo/MODELS/db.dart';

class Client {
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? description;
  final double? usdBalance;
  final double? cdfBalance;

  const Client(
      {this.id,
      this.name,
      this.phoneNumber,
      this.description,
      this.usdBalance,
      this.cdfBalance});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'description': description,
      'usdBalance': usdBalance,
      'cdfBalance': cdfBalance
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'description': description,
      'usdBalance': usdBalance,
      'cdfBalance': cdfBalance
    };
  }

  Future<Map<String, String>> add() {
    Db db = Db();
    return db.add("clients", toMapWithId());
  }

  Future get(filter,inverse) {
    Db db = Db();
    return db.fetch("SELECT * FROM clients ORDER BY $filter $inverse");
  }

  Future getById(int id) {
    Db db = Db();
    return db.fetch(
      "SELECT * FROM clients where id=$id",
    );
  }

  Future getLike(String name) {
    Db db = Db();
    return db.fetch(
      "SELECT * FROM clients where name like '%$name%'",
    );
  }
}
