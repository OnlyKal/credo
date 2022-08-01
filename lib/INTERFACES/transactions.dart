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
  TextEditingController operationDescription =
      TextEditingController(text: 'Opération cofrirmée');
  TextEditingController dateController = TextEditingController();
  Transaction transaction = const Transaction();
  Client newClient = const Client();

  var devise = ['CDF', 'USD'];
  String newDeviseC = 'USD';
  String newDeviseD = 'USD';

  _oncreateDebit() {
    if (newDeviseD == 'USD') {
      addUSDdedit(operationMount.text, widget.customer['id'],
          dateController.text, operationDescription.text, 'usdD');
    } else {
      addCDFdebit(operationMount.text, widget.customer['id'],
          dateController.text, operationDescription.text, 'cdfD');
    }

    setState(() {
      operationMount.text = dateController.text = '';
    });
    Navigator.of(context).pop();
  }

  _oncreateCredit() {
    if (newDeviseC == 'USD') {
      addUSDcrebit(operationMount.text, widget.customer['id'],
          operationDescription.text, 'usdC');
    } else {
      addCDFcrebit(operationMount.text, widget.customer['id'],
          operationDescription.text, 'cdfC');
    }

    setState(() {
      operationMount.text = dateController.text = '';
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
                        future: newClient.getById(widget.customer['id']),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit))
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
                              transaction.getByClientId(widget.customer['id']),
                          builder: (BuildContext comtext,
                              AsyncSnapshot<dynamic> operation) {
                            debugPrint(operation.data.toString());
                            if (operation.hasData) {
                              if (operation.data['type'] == 'success') {
                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: operation.data['result'].length,
                                    itemBuilder: ((context, i) {
                                      var dateop = operation.data['result'][i]
                                              ['dateRecord']
                                          .toString();
                                      var splitedDate = dateop.split(' ');

                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      operation.data['result']
                                                                          [i][
                                                                      'typeOp'] ==
                                                                  'usdD' ||
                                                              operation.data['result']
                                                                          [i][
                                                                      'typeOp'] ==
                                                                  'cdfD'
                                                          ? const Text(
                                                              'Debit',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            )
                                                          : const Text(
                                                              'Credit',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                      const SizedBox(height: 3),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .calendar_month_outlined,
                                                              size: 13,
                                                              color:
                                                                  Colors.grey),
                                                          const SizedBox(
                                                              width: 06),
                                                          Text(
                                                            (splitedDate[0]
                                                                .toString()
                                                                .replaceAll(
                                                                    '-', '/')),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  if (operation.data['result']
                                                              [i]['typeOp'] ==
                                                          'usdD' ||
                                                      operation.data['result']
                                                              [i]['typeOp'] ==
                                                          'cdfD')
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        operation.data['result']
                                                                        [i][
                                                                    'typeOp'] ==
                                                                'usdD'
                                                            ? Text(
                                                                'usd ${operation.data['result'][i]['usdCredit']}',
                                                                style: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            183,
                                                                            23,
                                                                            12),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                'cdf ${operation.data['result'][i]['cdfCredit']}',
                                                                style: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            183,
                                                                            23,
                                                                            12),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .notifications_active_outlined,
                                                                size: 13,
                                                                color: Colors
                                                                    .grey),
                                                            const SizedBox(
                                                                width: 06),
                                                            Text(
                                                              operation.data[
                                                                      'result'][i]
                                                                  [
                                                                  'paymentDate'],
                                                              style: const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .grey),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  else
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        operation.data['result']
                                                                        [i][
                                                                    'typeOp'] ==
                                                                'usdC'
                                                            ? Text(
                                                                'usd ${operation.data['result'][i]['usdDebit']}',
                                                                style: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            6,
                                                                            138,
                                                                            20),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                'cdf ${operation.data['result'][i]['cdfDebit']}',
                                                                style: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            6,
                                                                            138,
                                                                            20),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                        const SizedBox(
                                                            height: 6),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 5),
                                                child: Container(
                                                  color: Colors.grey,
                                                  height: 0.2,
                                                ),
                                              )
                                            ],
                                          ));
                                    }));
                              }
                            }
                            if (operation.hasError) {
                              return const Text('has error accured');
                            }
                            if (operation.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('has wait accured');
                            }

                            if (operation.data == 'null') {
                              return const Text('has error null');
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
                child: SingleChildScrollView(
                  child: Column(children: [
                    DropdownButton(
                        hint: const Text('Devise'),
                        value: newDeviseC,
                        items: devise.map((dev) {
                          return DropdownMenuItem(
                            child: Text(dev),
                            value: dev.toString(),
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() {
                            newDeviseC = item.toString();
                            debugPrint(item.toString());
                          });
                        }),
                    inputField(context, operationMount, 'Montant reçu',
                        Icons.balance_sharp, TextInputType.number),
                    inputField(context, operationDescription, 'Description',
                        Icons.density_medium_sharp, TextInputType.text),
                  ]),
                )),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('ANNULER',
                      style: TextStyle(color: greencolor))),
              TextButton(
                  onPressed: () => _oncreateCredit(),
                  child: const Text('CREDITER COMPTE',
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
                child: SingleChildScrollView(
                  child: Column(children: [
                    DropdownButton(
                        hint: const Text('Devise'),
                        value: newDeviseD,
                        items: devise.map((dev) {
                          return DropdownMenuItem(
                            child: Text(dev),
                            value: dev.toString(),
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() {
                            newDeviseD = item.toString();
                            debugPrint(item.toString());
                          });
                        }),
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
                                  String formatted = DateFormat('yyy/MM/dd')
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
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('ANNULER',
                      style: TextStyle(color: greencolor))),
              TextButton(
                  onPressed: () => _oncreateDebit(),
                  child: const Text('DEBITER COMPTE',
                      style: TextStyle(color: greencolor))),
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
