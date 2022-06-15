import 'package:flutter/material.dart';
import './EXPORTS/exports.files.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/dashboard': (context) => const DashBoard(),
      '/user/signin': (context) => const UserSignin(),
      '/user/signup': (context) => const UserSignup(),
      '/user/profil': (context) => const UserProfil(),
      '/customer/create': (context) => const CurstomerCreate(),
      '/customer/edit': (context) => const CurstomerEdit()
    },
  ));
}
