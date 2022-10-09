import '../EXPORTS/exports.files.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future signIn(context, userPhone, userPassword) async {
  final session = await SharedPreferences.getInstance();
  User user = User(phoneNumber: userPhone, password: userPassword);
  user.login().then((data) {
    if (data['type'] == 'failure') {
      snackError(context, data['message']);
    } else {
      user.get().then((user) {
        session.setString('user_token', user['result'][0]['token'].toString());
        session.setString('user_id', user['result'][0]['id'].toString());
        goto(context, const Home());
      });
    }
  });
}

Future signUp(context, userName, userPhone, userMail, userPassword) async {
  final session = await SharedPreferences.getInstance();
  User user = User(
      name: userName,
      phoneNumber: userPhone,
      email: userMail,
      password: userPassword);
  user.add().then((data) {
    if (data['type'] == 'failure') {
      snackError(context, data['message']);
    } else {
      user.get().then((user) {
        session.setString('user_token', user['result'][0]['token'].toString());
        session.setString('user_id', user['result'][0]['id'].toString());
        goto(context, const Home());
      });
    }
  });
}
