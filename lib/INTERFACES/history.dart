import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => back(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Détails du client',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 176, 90, 90),
      ),
    );
  }
}
