import 'dart:convert';
import 'package:credo/APIS/user.api.dart';
import 'package:credo/CONFIG/messa.toast.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../STATICS/data.static.dart';

Future addCurtomer(
    curstomerName, curstomerPhone, curstomerDescription, context) async {
  try {
    var checkSession = await readSession();
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

    var data = jsonDecode(response.body);
    if (data['type'] == 'failure') {
      snackError(context, data['message']);
    } else {
      snackSuccess(context, data['message']);
    }
  } catch (ex) {
    debugPrint('CREATE CURSTOMER : ${ex.toString()}');
  }
}

Future getCustomer() async {
  try {
    var checkSession = await readSession();
    var response = await http.post(Uri.parse('$serverAddress/client/get'),
        headers: <String, String>{
          'token': checkSession['TOKEN'].toString(),
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
            <String, String>{'userId': checkSession['SESSION'].toString()}));
    var data = jsonDecode(response.body);

    if (data['type'] == 'success') {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  } catch (ex) {
    debugPrint('GET CURSTOMERS : ${ex.toString()}');
  }
}

Future getCustomerByName(customerName) async {
  try {
    var checkSession = await readSession();
    var response = await http.post(Uri.parse('$serverAddress/client/getLike'),
        headers: <String, String>{
          'token': checkSession['TOKEN'].toString(),
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'userId': checkSession['SESSION'].toString(),
          'name': customerName
        }));
    var data = jsonDecode(response.body);

    if (data['type'] == 'success') {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  } catch (ex) {
    debugPrint('GET CURSTOMERS : ${ex.toString()}');
  }
}
