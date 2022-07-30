import 'package:credo/APIS/trans.api.dart';
import 'package:credo/EXPORTS/exports.files.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTransaction extends StatefulWidget {
  final customer;
  const HomeTransaction({Key? key, @required this.customer}) : super(key: key);

  @override
  State<HomeTransaction> createState() => _HomeTransactionState();
}

class _HomeTransactionState extends State<HomeTransaction> {
  TextEditingController opertationType = TextEditingController();
  TextEditingController operationMount = TextEditingController();
  TextEditingController operationDescription = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Client customer = const Client();

  _oncreateDebit() {
    addOperation('Debit', operationMount.text, operationDescription.text,
        widget.customer['id'].toString(), (dateController.text));
    setState(() {
      operationMount.text =
          operationDescription.text = dateController.text = '';
    });
    Navigator.of(context).pop();
  }

  _oncreateCredit() {
    addOperation('Credit', operationMount.text, operationDescription.text,
        widget.customer['id'].toString(), '22/09/2002');
    setState(() {
      operationMount.text =
          operationDescription.text = dateController.text = '';
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Détails du client',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 176, 90, 90),
        ),
        body: SingleChildScrollView(
            child: SizedBox(
                height: fullHeight(context),
                width: fullWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: FutureBuilder<dynamic>(
                        future: customer.getById(widget.customer['id']),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> client) {
                          if (client.hasData) {
                            if (client.data['type'] == 'success') {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          client.data['result'][0]
                                                  ['description']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          client.data['result'][0]['name']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        height: fullHeight(context) * 0.13,
                                        width: fullWidth(context),
                                        decoration: BoxDecoration(
                                            color: greencolor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Total Balance',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    54,
                                                                    248,
                                                                    229)),
                                                      ),
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "CDF ${client.data['result'][0]['usdBalance'].toString()}",
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Text('-'),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "USD ${client.data['result'][0]['usdBalance'].toString()}",
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const Image(
                                                      image: AssetImage(
                                                          'assets/images/45000.png'))
                                                ]))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        _option(Icons.bookmark_remove,
                                            'Décaissement', _addDebit),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        _option(Icons.bookmark_add,
                                            'Encaissement', _addCredit),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FutureBuilder<dynamic>(
                          future:
                              getTransction(widget.customer['name'].toString()),
                          builder: (BuildContext comtext,
                              AsyncSnapshot<dynamic> operation) {
                            if (operation.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('has wait accured');
                            }

                            if (operation.hasError) {
                              return const Text('has error accured');
                            }
                            if (operation.hasError) {
                              return const Text('has error accured');
                            }

                            if (operation.connectionState ==
                                ConnectionState.done) {
                              if (operation.hasData) {
                                if (operation.data['type'] == 'success') {
                                  return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          operation.data['result'].length,
                                      itemBuilder: ((context, i) {
                                        return const Text('Text');
                                      }));
                                }
                              }
                            }

                            return const Text('errrrooooo');
                          },
                        ),
                      ),
                    )
                  ],
                ))));
  }

  _addCredit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Créditer compte'),
            content: SizedBox(
                width: fullWidth(context),
                height: fullHeight(context) * 0.17,
                child: SingleChildScrollView(
                  child: Column(children: [
                    inputField(context, operationMount, 'Montant reçu',
                        Icons.balance_sharp, TextInputType.number),
                    inputField(context, operationDescription, 'Description',
                        Icons.density_medium_sharp, TextInputType.text),
                  ]),
                )),
            actions: [
              TextButton(
                  onPressed: () => _oncreateCredit(),
                  child: const Text('Créditer compte',
                      style: TextStyle(color: greencolor)))
            ],
          );
        });
  }

  _addDebit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Décaisser l'argent"),
            content: SizedBox(
                width: fullWidth(context),
                height: fullHeight(context) * 0.27,
                child: SingleChildScrollView(
                  child: Column(children: [
                    inputField(context, operationMount, 'Montant à decaisser',
                        Icons.balance_sharp, TextInputType.number),
                    inputField(context, operationDescription, 'Description',
                        Icons.density_medium_sharp, TextInputType.text),
                    Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Material(
                          elevation: 3,
                          child: Container(
                            decoration: const BoxDecoration(border: Border()),
                            height: 46,
                            child: TextField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickerDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2002),
                                    lastDate: DateTime(2102));
                                if (pickerDate != null) {
                                  String formatted = DateFormat('dd/MM/yyyy')
                                      .format(pickerDate);
                                  setState(() {
                                    dateController.text = formatted;
                                  });
                                }
                              },
                              controller: dateController,
                              cursorColor: greencolor,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.calendar_month),
                                filled: true,
                                hintText: 'Date écheance',
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: greencolor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: greencolor)),
                              ),
                            ),
                          ),
                        ))
                  ]),
                )),
            actions: [
              TextButton(
                  onPressed: () => _oncreateDebit(),
                  child: const Text('Débiter compte',
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
            height: 40,
            width: 40,
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
