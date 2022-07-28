import 'dart:convert';
import 'package:credo/APIS/user.api.dart';
import 'package:credo/CONFIG/messa.toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../STATICS/data.static.dart';

Future addOperation(operationType, operationMontant, operationDesc, customerId,
    echeance) async {
  try {
    var checkSession = await readSession();
    var response = await http.post(
      Uri.parse('$serverAddress/transaction/add'),
      headers: <String, String>{
        'token': checkSession['TOKEN'].toString(),
        'Content-Type': 'application/json;charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'userId': checkSession['SESSION'].toString(),
        'clientId': customerId,
        'type': operationType,
        'amount': operationMontant,
        'description': operationDesc,
        'paymentDate': echeance
      }),
    );
    var data = jsonDecode(response.body);
    debugPrint(response.body);
    if (data['type'] == 'failure') {
      messageError(data['message']);
    } else {
      messageSuccess(data['message']);
    }
  } catch (ex) {
    debugPrint('CREATE OPERATION : ${ex.toString()}');
  }
}

Future getTransction(customerId) async {
  try {
    var checkSession = await readSession();
    var response = await http.post(
      Uri.parse('$serverAddress/transaction/getTransaction'),
      headers: <String, String>{
        'token': checkSession['TOKEN'].toString(),
        'Content-Type': 'application/json;charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'clientId': customerId,
      }),
    );
    var data = jsonDecode(response.body);
    debugPrint(response.body);
    if (data['type'] == 'failure') {
      messageError(data['message']);
    } else {
      messageSuccess(data['message']);
    }
  } catch (ex) {
    debugPrint('CREATE OPERATION : ${ex.toString()}');
  }
}
