import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../STATICS/data.static.dart';

Future signin(userPhone, userPassword) async {
  var response = await http.post(Uri.parse('$serverAddress/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': userPhone,
        'password': userPassword
      }));
  debugPrint(response.body);
}

Future signup(userName, userPhone, userPassword, userMail) async {
  var response = await http.post(
    Uri.parse('$serverAddress/user/add'),
    headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
    body: jsonEncode(<String, String>{
      'name': userName,
      'phoneNumber': userPhone,
      'password': userPassword,
      'email': userMail,
    }),
  );
  debugPrint(response.body);
}
