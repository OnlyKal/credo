import 'dart:io';
import 'package:credo/CONFIG/func.dart';
import 'package:flutter/material.dart';
import './EXPORTS/exports.files.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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

  DateTime date = DateTime.now();
  if (date.day > 1 && date.day < 25) {
    // localBackupDb();
  }

  runApp(Phoenix(
    child: MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      )),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    ),
  ));
}
