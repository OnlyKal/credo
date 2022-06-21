import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

class HomeTransaction extends StatefulWidget {
  const HomeTransaction({Key? key}) : super(key: key);

  @override
  State<HomeTransaction> createState() => _HomeTransactionState();
}

class _HomeTransactionState extends State<HomeTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
