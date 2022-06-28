import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    session();
  }

  Future<void> session() async {
    var checkSession = await readSession();

    Timer(
        const Duration(seconds: 8),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => checkSession['TOKEN'] != null
                    ? const Home()
                    : const UserSignin())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: fullHeight(context),
        width: fullWidth(context),
        child: Column(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                Text(
                  'Credo ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: greencolor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Credit Monitoring ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ])),
        ]),
      )),
    );
  }
}
