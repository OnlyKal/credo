import 'dart:async';
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
    Timer(
        const Duration(seconds: 8),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UserSignin())));
    super.initState();
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
                Image(
                    image: AssetImage('assets/images/credo.png'),
                    height: 130,
                    fit: BoxFit.cover),
                Text(
                  ' ',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 33,
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ])),
        ]),
      )),
    );
  }
}
