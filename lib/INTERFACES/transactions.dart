import 'package:credo/APIS/trans.api.dart';
import 'package:credo/CONFIG/colors.dart';
import 'package:credo/CONFIG/media.query.dart';
import 'package:credo/EXPORTS/exports.files.dart';
import 'package:flutter/material.dart';

class HomeTransaction extends StatefulWidget {
  final customer;
  const HomeTransaction({Key? key, @required this.customer}) : super(key: key);

  @override
  State<HomeTransaction> createState() => _HomeTransactionState();
}

class _HomeTransactionState extends State<HomeTransaction> {
  var newBalance = '';

  TextEditingController opertationType = TextEditingController();
  TextEditingController operationMount = TextEditingController();
  TextEditingController operationDescription = TextEditingController();

  @override
  void initState() {
    debugPrint(widget.customer.toString());
    setState(() {
      newBalance = '830.0000';
    });
    super.initState();
  }

  _oncreateOperatiom() {
    addOperation(opertationType.text, operationMount.text,
        operationDescription.text, widget.customer['id']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.customer['name'].toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
                height: fullHeight(context) * 0.13,
                width: fullWidth(context),
                decoration: BoxDecoration(
                    color: greencolor, borderRadius: BorderRadius.circular(4)),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Balance',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 14, 232, 210)),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                'CDF $newBalance',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Image(
                              image: AssetImage('assets/images/45000.png'))
                        ]))),

            // OPTIONS

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                _option(Icons.addchart_sharp, 'Opération', _addTransactionForm),
                const SizedBox(
                  width: 15,
                ),
                _option(Icons.bar_chart_sharp, 'Situation', null),
                const SizedBox(
                  width: 15,
                ),
                _option(Icons.person_outline_sharp, 'Client', null),
              ],
            )
          ],
        ),
      )),
    );
  }

  _addTransactionForm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nouvelle opération'),
            content: SizedBox(
                width: fullWidth(context),
                height: fullHeight(context) * 0.26,
                child: SingleChildScrollView(
                  child: Column(children: [
                    inputField(context, opertationType, 'Type de operation',
                        Icons.person),
                    inputField(context, operationMount, 'Montant',
                        Icons.balance_sharp),
                    inputField(context, operationDescription, 'Description',
                        Icons.density_medium_sharp),
                  ]),
                )),
            actions: [
              TextButton(
                  onPressed: _oncreateOperatiom,
                  child: const Text('Ajouter',
                      style: TextStyle(color: greencolor)))
            ],
          );
        });
  }

  _option(icon, title, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(6)),
            child: Center(child: Icon(icon)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
