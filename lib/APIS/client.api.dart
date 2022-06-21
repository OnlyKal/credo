import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../STATICS/data.static.dart';

Future addCurtomer(curstomerName, curstomerPhone, curstomerDescription) async {
  var response = await http.post(
    Uri.parse('$serverAddress/client/add'),
    headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
    body: jsonEncode(<String, String>{
      'name': curstomerName,
      'phoneNumber': curstomerPhone,
      'description': curstomerDescription
    }),
  );
  debugPrint(response.body);
}
