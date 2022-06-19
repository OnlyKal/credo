import 'package:flutter/material.dart';
import './EXPORTS/exports.files.dart';




class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new PostHttpOverrides();
  runApp(MaterialApp(
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
      brightness: Brightness.dark,
    )),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/dashboard': (context) => const DashBoard(),
      '/user/signin': (context) => const UserSignin(),
      '/user/signup': (context) => const UserSignup(),
      '/user/profil': (context) => const UserProfil(),
      '/customer/add': (context) => const CurstomerCreate(),
      '/customer/edit': (context) => const CurstomerEdit()
    },
  ));
}
