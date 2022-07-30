import 'package:credo/MODELS/db.dart';

class User {
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final String? token;

  const User(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.password,
      this.token});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'token': token
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    };
  }

  Future<Map<String, String>> add() {
    Db db = Db();
    return db.add("users", toMap());
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

  Future login() {
    Db db = Db();
    return db.fetch("SELECT * FROM users where phoneNumber='$phoneNumber' or name='$name' and password='$password'");
  }

  Future get() {
    Db db = Db();
    return db.fetch("SELECT * FROM users");
  }
}
