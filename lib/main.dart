import 'dart:io';
import 'package:flutter/material.dart';
import './EXPORTS/exports.files.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = PostHttpOverrides();
  localBackupDb();

  runApp(MaterialApp(
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
      brightness: Brightness.dark,
    )),
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
  ));
}
