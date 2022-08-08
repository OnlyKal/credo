import 'package:credo/EXPORTS/exports.files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

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
  TextEditingController dateControllerD = TextEditingController();
  TextEditingController dateControllerC = TextEditingController();
  Transaction transaction = const Transaction();
  Client newClient = const Client();

  var devise = ['CDF', 'USD'];
  String newDeviseC = 'USD';
  String newDeviseD = 'USD';

  _oncreateDebit() {
    if (operationMount.text != '') {
      if (dateControllerD.text != '') {
        if (newDeviseD == 'USD') {
          addUSDebit(operationMount.text, widget.customer['id'],
              operationDescription.text, 'usdD', dateControllerD.text);
        } else {
          addCDFDebit(operationMount.text, widget.customer['id'],
              dateControllerD.text, operationDescription.text, 'cdfD');
        }
        setState(() {
          operationMount.text = dateControllerD.text = '';
        });
        Navigator.of(context).pop();
      } else {
        messageError("Ajouter une date d'echeance!");
      }
    } else {
      messageError("Ajouter un montant !");
    }
  }

  _oncreateCredit() {
    if (operationMount.text != '') {
      if (dateControllerC.text != '') {
        if (newDeviseC == 'USD') {
          addUSDCredit(operationMount.text, widget.customer['id'],
              operationDescription.text, 'usdC', dateControllerC.text);
        } else {
          addCDFCredit(operationMount.text, widget.customer['id'],
              dateControllerC.text, operationDescription.text, 'cdfC');
        }
        setState(() {
          operationMount.text = dateControllerC.text = '';
        });
        Navigator.of(context).pop();
      } else {
        messageError("Ajouter une date d'echeance!");
      }
    } else {
      messageError("Ajouter un montant !");
    }
  }

  TextEditingController mountUpdate = TextEditingController();
  TextEditingController dateUpdate = TextEditingController();

  _onUpdate() {
    if (mountUpdate.text != '') {
      if (dateUpdate.text != '') {
        if (newDeviseC == 'USD') {
          addUSDCredit(operationMount.text, widget.customer['id'],
              operationDescription.text, 'usdC', dateControllerC.text);
        } else {
          addCDFCredit(operationMount.text, widget.customer['id'],
              dateControllerC.text, operationDescription.text, 'cdfC');
        }
        setState(() {
          operationMount.text = dateControllerC.text = '';
        });
        Navigator.of(context).pop();
      } else {
        messageError("Ajouter une date d'echeance!");
      }
    } else {
      messageError("Ajouter un montant !");
    }
  }

  _sendSMS(message, List<String> clientNumbers) async {
    String _result = await sendSMS(message: message, recipients: clientNumbers);
    debugPrint(_result.toString());
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
          leading: IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/home'),
            icon: const Icon(Icons.arrow_back_ios),
          ),
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
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.transparent,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        // height: fullHeight(context) * 0.14,
                                        width: fullWidth(context),
                                        decoration: BoxDecoration(
                                            color: greencolor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Situation des opérations',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      195,
                                                                      251,
                                                                      245)),
                                                        ),
                                                        // Image.asset(
                                                        //   'assets/images/45000.png',
                                                        //   height: 52,
                                                        // )
                                                        IconButton(
                                                            onPressed: () {
                                                              _sendSMS(
                                                                  'Cher client , ... ',
                                                                  [
                                                                    widget
                                                                        .customer[
                                                                            'phoneNumber']
                                                                        .toString()
                                                                  ]);
                                                            },
                                                            icon: const Icon(Icons
                                                                .message_rounded))
                                                      ]),
                                                  Row(
                                                    children: [
                                                      balanceCDF(
                                                          context,
                                                          widget
                                                              .customer['id']),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      balanceUSD(
                                                          context,
                                                          widget
                                                              .customer['id']),
                                                    ],
                                                  )
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
                            if (operation.hasData) {
                              if (operation.data['type'] == 'success') {
                                // debugPrint(operation.data.toString());
                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: operation.data['result'].length,
                                    itemBuilder: ((context, i) {
                                      var dateop = operation.data['result'][i]
                                              ['dateRecord']
                                          .toString();
                                      var splitedDate = dateop.split(' ');

                                      return InkWell(
                                        onTap: _updateTrans,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
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
                                                          MainAxisAlignment
                                                              .start,
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
                                                                'Debit ',
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
                                                        const SizedBox(
                                                            height: 3),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .calendar_month_outlined,
                                                                size: 13,
                                                                color: Colors
                                                                    .grey),
                                                            const SizedBox(
                                                                width: 06),
                                                            Text(
                                                              (splitedDate[0]
                                                                  .toString()
                                                                  .replaceAll(
                                                                      '-',
                                                                      '/')),
                                                              style: const TextStyle(
                                                                  fontSize: 10,
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
                                                                  'usd ${operation.data['result'][i]['usdDebit']}',
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          183,
                                                                          23,
                                                                          12),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : Text(
                                                                  'cdf ${operation.data['result'][i]['cdfDebit']}',
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
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
                                                                    fontSize:
                                                                        10,
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
                                                                  'usd ${operation.data['result'][i]['usdCredit']}',
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          6,
                                                                          138,
                                                                          20),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : Text(
                                                                  'cdf ${operation.data['result'][i]['cdfCredit']}',
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
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
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, bottom: 5),
                                                  child: Container(
                                                    color: Colors.grey,
                                                    height: 0.2,
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    }));
                              }
                            }
                            if (operation.hasError) {
                              return const Text('');
                            }
                            if (operation.connectionState ==
                                ConnectionState.waiting) {
                              return _waiting('Attente..!');
                            }

                            if (operation.data == 'null') {
                              return const Text('');
                            }

                            return const Text('');
                          },
                        ),
                      ),
                    )
                  ],
                ))));
  }

  Widget _chart(context, cdfBalance) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: PieChart(PieChartData(
              sectionsSpace: 2.0,
              sections: [
                PieChartSectionData(
                    color: Colors.blueGrey,
                    value: 4.4,
                    radius: 20.0,
                    title: ''),
                PieChartSectionData(
                  color: Colors.amber,
                  value: 4.4,
                  radius: 20.0,
                  title: '',
                )
              ],
              centerSpaceRadius: 5.0)),
        ),
        cdfBalance,
      ],
    );
  }

  Widget balanceCDF(context, cusromerId) {
    return FutureBuilder<dynamic>(
        future: transaction.getCdf(cusromerId),
        builder: ((context, AsyncSnapshot<dynamic> cdf) {
          if (cdf.hasData) {
            // debugPrint(cdf.data['result'].toString());
            if (cdf.data['result'][0]['balance'] != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 70,
                  //   width: 70,
                  //   child: PieChart(PieChartData(
                  //       sectionsSpace: 2.0,
                  //       sections: [
                  //         PieChartSectionData(
                  //             color: const Color.fromARGB(255, 207, 6, 6),
                  //             value: 33.0,
                  // value: cdf.data['result'][0]['cdfDebit'],
                  //     radius: 20.0,
                  //     title: ''),
                  // PieChartSectionData(
                  //   color: Colors.amber,
                  // value: cdf.data['result'][0]['cdfCredit'],
                  //           value: 89.0,
                  //           radius: 20.0,
                  //           title: '',
                  //         )
                  //       ],
                  //       centerSpaceRadius: 5.0)),
                  // ),
                  Text(
                    "CDF ${cdf.data['result'][0]['balance'].toString()}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ],
              );
            }
          }
          return const Text('CDF 0.0',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
        }));
  }

  Widget balanceUSD(context, customerId) {
    return FutureBuilder<dynamic>(
        future: transaction.getUsd(customerId),
        builder: ((context, AsyncSnapshot<dynamic> usd) {
          if (usd.hasData) {
            // debugPrint(usd.data['result'].toString());
            if (usd.data['result'][0]['balance'] != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 70,
                  //   width: 70,
                  //   child: PieChart(PieChartData(
                  //       sectionsSpace: 2.0,
                  //       sections: [
                  //         PieChartSectionData(
                  // color: const Color.fromARGB(255, 206, 4, 4),
                  // value: usd.data['result'][0]['usdDebit'],
                  // value: 13,
                  // radius: 20.0,
                  // title: ''),
                  // PieChartSectionData(
                  //   color: Colors.amber,
                  // value: usd.data['result'][0]['usdCredit'],
                  //           value: 14,
                  //           radius: 20.0,
                  //           title: '',
                  //         )
                  //       ],
                  //       centerSpaceRadius: 5.0)),
                  // ),
                  Text(
                    "USD ${usd.data['result'][0]['balance'].toString()}",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w900),
                  ),
                ],
              );
            }
          }

          return const Text('USD 0.0',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
        }));
  }

  _updateTrans() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text('Modifier Transaction'),
              content: SizedBox(
                  width: fullWidth(context),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      inputField(context, operationMount, 'Montant',
                          Icons.balance_sharp, TextInputType.number),
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
                                      dateControllerC.text = formatted;
                                    });
                                  }
                                },
                                controller: dateControllerC,
                                cursorColor: greencolor,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month),
                                  filled: true,
                                  hintText: 'Date écheance',
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: greencolor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: greencolor)),
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
                    onPressed: () => _oncreateCredit(),
                    child: const Text('MODIFIER',
                        style: TextStyle(color: greencolor)))
              ],
            );
          }));
        });
  }

  _addCredit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text('Créditer compte'),
              content: SizedBox(
                  width: fullWidth(context),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        width: fullHeight(context),
                        child: DropdownButton(
                            isExpanded: true,
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
                                // debugPrint(item.toString());
                              });
                            }),
                      ),
                      inputField(context, operationMount, 'Montant reçu',
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
                                      dateControllerC.text = formatted;
                                    });
                                  }
                                },
                                controller: dateControllerC,
                                cursorColor: greencolor,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month),
                                  filled: true,
                                  hintText: 'Date écheance',
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: greencolor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: greencolor)),
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
                    onPressed: () => _oncreateCredit(),
                    child: const Text('CREDITER COMPTE',
                        style: TextStyle(color: greencolor)))
              ],
            );
          }));
        });
  }

  _addDebit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text("Décaisser l'argent"),
              content: SizedBox(
                  width: fullWidth(context),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        width: fullHeight(context),
                        child: DropdownButton(
                            isExpanded: true,
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
                                // debugPrint(item.toString());
                              });
                            }),
                      ),
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
                                      dateControllerD.text = formatted;
                                    });
                                  }
                                },
                                controller: dateControllerD,
                                cursorColor: greencolor,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month),
                                  filled: true,
                                  hintText: 'Date écheance',
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: greencolor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: greencolor)),
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
          }));
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

  _waiting(message) {
    return SizedBox(
      width: fullWidth(context),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
                width: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
              const SizedBox(
                width: 9,
              ),
              Text(message)
            ],
          )),
    );
  }

  _error(message) {
    return SizedBox(
        width: fullWidth(context),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.cancel,
                size: 30,
                color: Color.fromARGB(255, 158, 158, 158),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(message)
            ],
          ),
        ));
  }

  _empty(message) {
    return SizedBox(
        width: fullWidth(context),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.person_add_disabled_outlined,
                  size: 34,
                  color: Color.fromARGB(255, 158, 158, 158),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(message)
              ],
            )));
  }
}
