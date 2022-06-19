import 'package:flutter/material.dart';
import './EXPORTS/exports.files.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
      brightness: Brightness.dark,
    )),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const UserSignin(),
      '/dashboard': (context) => const DashBoard(),
      '/user/signin': (context) => const UserSignin(),
      '/user/signup': (context) => const UserSignup(),
      '/user/profil': (context) => const UserProfil(),
      '/customer/add': (context) => const CurstomerCreate(),
      '/customer/edit': (context) => const CurstomerEdit()
    },
  ));
}
