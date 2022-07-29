import 'package:flutter/material.dart';
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

void signUp(userName, userPhone, userMail, userPassword) async {
  final session = await SharedPreferences.getInstance();
  User user = User(
      name: userName,
      phoneNumber: userPhone,
      email: userMail,
      password: userPassword);
  user.add().then((data) {
    debugPrint(data.toString());
    if (data['type'] == 'failure') {
      messageError(data['message']);
    } else {
      // session.setString('user_token', data['result']['token'].toString());
      // session.setString('user_id', data['result']['id'].toString());
      // goto(context, const Home());
      messageSuccess(data['message']);
    }
  });
}
