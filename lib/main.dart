import 'package:flutter/material.dart';
import './EXPORTS/exports.files.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/dashboard': (context) => const DashBoard(),
      '/user/signin': (context) => const UserSignup(),
      '/user/signup': (context) => const UserSignup(),
      '/user/profil': (context) => const UserProfil(),
      '/curstomer/create': (ontext) => const CurstomerCreate(),
      '/customer/edit': (context) => const CurstomerEdit()
    },
  ));
}
