import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../EXPORTS/exports.files.dart';
import 'package:shared_preferences/shared_preferences.dart';

void createNewSession(value, token) async {
  try {
    final userSession = await SharedPreferences.getInstance();
    userSession.setString('credo_session', value);
  } catch (ex) {
    debugPrint('CREATE SESSION : ${ex.toString()}');
  }
}

readSession() async {
  try {
    final userSession = await SharedPreferences.getInstance();

    final String? sessionToken = userSession.getString('user_token');
    final String? sessionUser = userSession.getString('user_id');

    var dataSession = {
      'TOKEN': sessionToken,
      'SESSION': sessionUser,
    };

    return dataSession;
  } catch (ex) {
    debugPrint('READ SESSSION : ${ex.toString()}');
  }
}

void detroySession(context) async {
  try {
    final userSession = await SharedPreferences.getInstance();

    userSession.remove('user_id');
    userSession.remove('user_token');
    userSession.clear();
    goto(context, const UserSignin());
  } catch (ex) {
    debugPrint('DESTROTY SESSION : ${ex.toString()}');
  }
}

Future signin(context, userPhone, userPassword) async {
  try {
    final session = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse('$serverAddress/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': userPhone,
          'password': userPassword
        }));

    var data = jsonDecode(response.body);
    debugPrint(response.body);

    if (data['type'] == 'failure') {
      snackError(context, data['message']);
    } else {
      session.setString('user_token', data['result']['token'].toString());
      session.setString('user_id', data['result']['id'].toString());
      goto(context, const Home());
    }
  } catch (ex) {
    debugPrint('SIGNIN : ${ex.toString()}');
  }
}

Future signup(context, userName, userPhone, userPassword, userMail) async {
  try {
    var response = await http.post(
      Uri.parse('$serverAddress/user/add'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'name': userName,
        'phoneNumber': userPhone,
        'password': userPassword,
        'email': userMail,
        'currency': 'USD',
      }),
    );

    final session = await SharedPreferences.getInstance();

    var data = jsonDecode(response.body);

    if (data['type'] == 'failure') {
      snackError(context, data['message']);
    } else {
      session.setString('user_token', data['result']['token'].toString());
      session.setString('user_id', data['result']['id'].toString());
      goto(context, const Home());
    }
  } catch (ex) {
    debugPrint('SIGN UP : ${ex.toString()}');
  }
}
