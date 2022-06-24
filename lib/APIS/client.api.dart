import 'dart:convert';
import 'package:credo/APIS/user.api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../STATICS/data.static.dart';

Future addCurtomer(curstomerName, curstomerPhone, curstomerDescription) async {
  try {
    var checkSession = await readSession();
    debugPrint(checkSession['TOKEN'].toString());
    debugPrint(checkSession['SESSION'].toString());
    var response = await http.post(
      Uri.parse('$serverAddress/client/add'),
      headers: <String, String>{
        'token': checkSession['TOKEN'].toString(),
        'Content-Type': 'application/json;charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'userId': checkSession['SESSION'].toString(),
        'name': curstomerName,
        'phoneNumber': curstomerPhone,
        'description': curstomerDescription
      }),
    );
    debugPrint(response.body);
  } catch (ex) {
    debugPrint('CREATE CURSTOMER : ${ex.toString()}');
  }
}
