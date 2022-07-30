import 'package:credo/MODELS/db.dart';

class Client {
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? description;
  final double? balance;


  const Client({this.id, this.name, this.phoneNumber, this.description, this.balance});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'description': description,
      'balance': balance
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'description': description,
      'balance': balance
    };
  }

  Future<Map<String, String>> add() {
    Db db = Db();
    double balances=0.00;
   Future<Map<String,String>> query= db.myInstert("clients","name,phoneNumber,description,currrency,balance", "$name,$phoneNumber,$description,Cdf,$balance");
    return db.myInstert("clients","name,phoneNumber,description,currrency,balance", "$name,$phoneNumber,$description,usd,$balance");

    // if(query["type"]=="success"){
    //   }else{
    //   return {"type": "failure", "message": "Echec d'enregistrement"};
    // }
  }

  Object update() {
    Db db = Db();
    if (id != null) {
      return db.update("users", toMapWithId(), 'id=?', [id]);
    } else {
      return {
        "type": "failure",
        "message": "Echec de modification l'id est introuvable"
      };
    }
  }

  Object delete() {
    Db db = Db();
    if (id != null) {
      return db.delete("users", 'id=?', [id]);
    } else {
      return {
        "type": "failure",
        "message": "Echec de suppression l'id est introuvable"
      };
    }
  }

  Future get() {
    Db db = Db();
    return db.fetch("SELECT * FROM clients");
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
