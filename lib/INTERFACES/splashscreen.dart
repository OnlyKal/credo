import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../EXPORTS/exports.files.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
    FlutterContacts.requestPermission();
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
                    : const UserSignup())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: fullHeight(context),
        width: fullWidth(context),
        child: Column(children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: fullHeight(context) * 0.7,
            child: TextLiquidFill(
              text: 'Credo',
              waveColor: greencolor,
              boxBackgroundColor: const Color.fromARGB(255, 48, 48, 48),
              textStyle: const TextStyle(
                  fontSize: 51, color: greencolor, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Credit Management©Teal7',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ])),
        ]),
      )),
    );
  }
}
