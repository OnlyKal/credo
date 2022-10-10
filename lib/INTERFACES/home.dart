import 'package:credo/CONFIG/func.dart';
import 'package:credo/INTERFACES/history.dart';
import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController seachcontroller = TextEditingController();
  String _searchResult = '';
  TextEditingController curstomerName = TextEditingController();
  TextEditingController curstomerPhone = TextEditingController();
  TextEditingController curstomerDetails =
      TextEditingController(text: 'Partenaire');

  _onCreateCurstomer() {
    if (curstomerName.text != '') {
      if (curstomerPhone.text != '') {
        if (curstomerDetails.text != '') {
          newCustomer(curstomerName.text, curstomerPhone.text,
              curstomerDetails.text, context);
          setState(() {
            curstomerName.text = curstomerPhone.text = '';
          });
        } else {
          ('Ajouter une description..!');
        }
      } else {
        snackError(context, 'Ajouter un numéro de téléphone..!');
      }
    } else {
      snackError(context, 'Ajouter un nom..!');
    }
  }

  var _filter = 'name';
  _onFilterClientByName() {
    setState(() {
      _filter = 'name';
    });
  }

  _onFilterClientById() {
    setState(() {
      _filter = 'Id';
    });
  }

  _onFilterClientByDetail() {
    setState(() {
      _filter = 'description';
    });
  }

  var _inverse = 'ASC';
  _onFilter() {
    setState(() {
      _inverse == 'ASC' ? _inverse = 'DESC' : _inverse = 'ASC';
    });
  }

  var _checkSession;

  Client customer = const Client();
  Transaction transaction = const Transaction();

  @override
  void initState() {
    setState(() {
      customer.get(_filter, _inverse);
    });

    super.initState();
  }

  onpenDrw() {
    setState(() {
      session();
    });
    _scaffoldKey.currentState?.openDrawer();
    createFolders();
  }

  Future<void> session() async {
    _checkSession = await readSession();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool searchBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SizedBox(
          height: fullHeight(context),
          width: fullWidth(context),
          child: Column(children: [
            SizedBox(
              height: paddingTop(context),
            ),
            StatefulBuilder(builder: (context, localState) {
              return Container(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 0, bottom: 0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => onpenDrw(),
                                  icon: const Icon(Icons.format_align_justify)),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                'Credo',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: greencolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (searchBar == false)
                          IconButton(
                              onPressed: () =>
                                  localState(() => searchBar = !searchBar),
                              icon: const Icon(
                                Icons.search_rounded,
                                color: Color.fromARGB(255, 179, 178, 178),
                              )),
                      ],
                    ),
                    SizedBox(
                      width: fullWidth(context),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (searchBar != true)
                              Container(
                                color: greencolor,
                                height: 4,
                              )
                            else
                              Container(
                                  color: greencolor,
                                  height: fullHeight(context) * 0.18,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13, right: 13),
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: seachcontroller,
                                            onChanged: (value) {
                                              setState(() {
                                                _searchResult =
                                                    value.toString();
                                                if (seachcontroller.text ==
                                                    '') {}
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'Recherche....',
                                                prefixIcon: IconButton(
                                                    onPressed: () {
                                                      localState(() {
                                                        searchBar = !searchBar;
                                                        if (searchBar ==
                                                            false) {
                                                          seachcontroller.text =
                                                              '';
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white,
                                                    )),
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                border:
                                                    const UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              searchBtn(
                                                  _inverse == 'ASC'
                                                      ? Icons
                                                          .vertical_align_bottom_sharp
                                                      : Icons
                                                          .vertical_align_top_sharp,
                                                  _inverse == 'ASC'
                                                      ? 'Ascendent'
                                                      : 'Descendant',
                                                  _onFilter),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              searchBtn(
                                                  Icons.card_membership_rounded,
                                                  'Identification',
                                                  _onFilterClientById),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              searchBtn(
                                                  Icons.align_vertical_center,
                                                  'Détail',
                                                  _onFilterClientByDetail),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              searchBtn(
                                                  Icons.person_outline_rounded,
                                                  'Noms',
                                                  _onFilterClientByName),
                                            ],
                                          )
                                        ],
                                      )))
                          ]),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: FutureBuilder<dynamic>(
                  future: _searchResult != ''
                      ? customer.getLike(_searchResult)
                      : customer.get(_filter, _inverse),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> curtomer) {
                    if (curtomer.hasError) {
                      return _error('Données inaccessibles..!');
                    }
                    if (curtomer.connectionState == ConnectionState.none) {
                      return _error('Une erreur est produite...!');
                    }
                    if (curtomer.connectionState == ConnectionState.waiting) {
                      return const Text('');
                    }
                    if (curtomer.connectionState == ConnectionState.done) {
                      if (curtomer.hasData) {
                        if (curtomer.data['type'] == 'success') {
                          var data = curtomer.data['result'];

                          if (data.length == 0) {
                            return _empty('Désolé, aucun client identifié...!');
                          }

                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: curtomer.data['result'].length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () => goto(context,
                                      HomeTransaction(customer: data[i])),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 60,
                                        width: fullWidth(context),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const CircleAvatar(
                                                        backgroundColor:
                                                            greencolor,
                                                        child: Icon(
                                                          Icons
                                                              .folder_shared_rounded,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data[i]['name']
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        204,
                                                                        203,
                                                                        203),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            data[i]['phoneNumber']
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        104,
                                                                        104,
                                                                        104)),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      balanceCDF(context,
                                                          data[i]['id']),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      balanceUSD(context,
                                                          data[i]['id'])
                                                    ],
                                                  )
                                                ],
                                              )
                                            ]),
                                      ),
                                      Container(
                                        height: 1,
                                        width: fullWidth(context),
                                        color: const Color.fromARGB(
                                            228, 74, 73, 73),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      }
                    }
                    return _error('Aucune donnée trouvée...!');
                  }),
            )),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: greencolor,
        onPressed: () => addClientLog(),
        child: const Icon(
          Icons.person_add_alt_outlined,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: greencolor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Credo',
                        style: TextStyle(
                            fontSize: 44, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Text(
                    'Crédit management',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add_alt,
                color: greencolor,
              ),
              title: const Text(
                'Nouveau Client',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                back(context);
                addClientLog();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_forward_ios,
                color: greencolor,
              ),
              title: const Text(
                'Solde Franc',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              trailing: FutureBuilder(
                  future: _checkSession != null
                      ? transaction.getCdf(int.parse(_checkSession['SESSION']))
                      : null,
                  builder: ((context, AsyncSnapshot soldF) {
                    if (soldF.hasData) {
                      if (soldF.data != null) {
                        var balance = soldF.data['result'][0]['balance'];
                        return Text(
                          'CDF ${balance == null ? '0.0' : balance.toString()}',
                          style: TextStyle(
                              color: balance == null
                                  ? Colors.grey
                                  : balance < 1
                                      ? Colors.red
                                      : const Color.fromARGB(255, 87, 176, 248),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        );
                      }
                    }
                    return const Text('');
                  })),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_forward_ios,
                color: greencolor,
              ),
              title: const Text(
                'Solde Dollars',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              trailing: FutureBuilder(
                  future: _checkSession != null
                      ? transaction.getUsd(int.parse(_checkSession['SESSION']))
                      : null,
                  builder: ((context, AsyncSnapshot soldF) {
                    if (soldF.hasData) {
                      if (soldF.data != null) {
                        var balance = soldF.data['result'][0]['balance'];
                        return Text(
                          'USD ${balance == null ? '0.0' : balance.toString()}',
                          style: TextStyle(
                              color: balance == null
                                  ? Colors.grey
                                  : balance < 1
                                      ? Colors.red
                                      : const Color.fromARGB(255, 87, 176, 248),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        );
                      }
                    }
                    return const Text('');
                  })),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.history,
                color: greencolor,
              ),
              title: const Text(
                'Historiques',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                // localRestoreDb();

                // back(context);
                // goto(context, const History());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.screen_rotation_alt,
                color: greencolor,
              ),
              title: const Text(
                'Backup & Restore',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                localBackupDb();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: greencolor,
              ),
              title: const Text(
                'Paramétres',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(
                Icons.help_outline,
                size: 20,
                color: Colors.grey,
              ),
              title: const Text(
                'A Propos',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void addClientLog() {
    curstomerName.text = '';
    curstomerPhone.text = '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, localState) {
            return AlertDialog(
              title: const Text('Nouveau client'),
              content: SizedBox(
                  width: fullWidth(context),
                  height: fullHeight(context) * 0.28,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      InkWell(
                          onTap: () async {
                            final contact =
                                await FlutterContacts.openExternalPick();
                            localState(() {
                              if (contact != null) {
                                curstomerName.text =
                                    (contact.displayName).toString();
                                curstomerPhone.text =
                                    (contact.phones.first.number)
                                        .toString()
                                        .replaceAll(' ', '');
                              } else {
                                snackError(
                                    context, 'Ce contact est invalide ..!');
                              }
                            });
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add_circle_outline_rounded,
                                color: greencolor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Contacts')
                            ],
                          )),
                      inputField(context, curstomerName, 'Noms du client',
                          Icons.person, TextInputType.text),
                      inputField(context, curstomerPhone, 'Téléphone',
                          Icons.phone, TextInputType.number),
                      inputField(context, curstomerDetails, 'Description',
                          Icons.density_medium_sharp, TextInputType.text),
                    ]),
                  )),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('ANNULER',
                        style: TextStyle(color: greencolor))),
                TextButton(
                    onPressed: _onCreateCurstomer,
                    child: const Text('AJOUTER',
                        style: TextStyle(color: greencolor)))
              ],
            );
          });
        });
  }

  Widget searchBtn(icon, title, event) {
    return SizedBox(
        height: 35,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                elevation: 0.3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: const Color.fromARGB(181, 62, 242, 224)),
            onPressed: event,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: const Color.fromARGB(255, 182, 250, 242),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )));

    // GestureDetector(
    //   behavior: HitTestBehavior.translucent,
    //   onTap: event,
    //   child: Container(
    //     height: 35,
    //     decoration: BoxDecoration(
    //         color: const Color.fromARGB(181, 7, 234, 211),
    //         borderRadius: BorderRadius.circular(15)),
    //     child: Padding(
    //         padding: const EdgeInsets.only(left: 10, right: 10),
    //         child: Row(
    //           children: [
    //             Icon(
    //               icon,
    //               size: 16,
    //               color: const Color.fromARGB(255, 162, 245, 236),
    //             ),
    //             const SizedBox(
    //               width: 6,
    //             ),
    //             Text(title)
    //           ],
    //         )),
    //   ),
    // );
  }

  Widget balanceCDF(context, cusromerId) {
    return FutureBuilder<dynamic>(
        future: transaction.getCdf(cusromerId),
        builder: ((context, AsyncSnapshot<dynamic> cdf) {
          if (cdf.hasData) {
            if (cdf.data['result'][0]['balance'] != null) {
              return cdf.data['result'][0]['balance'] == 0.0776877
                  ? const Text('')
                  : Text(
                      'CDF ${cdf.data['result'][0]['balance'].toString()}',
                      style: TextStyle(
                          fontSize: 12,
                          color: cdf.data['result'][0]['balance'] >= 0.0
                              ? Colors.amber
                              : const Color.fromARGB(255, 241, 39, 39),
                          fontWeight: FontWeight.w500),
                    );
            }
          }

          return const Text(
            'CDF 0.0',
            style: TextStyle(
                color: Color.fromARGB(255, 104, 104, 104), fontSize: 12),
          );
        }));
  }

  Widget balanceUSD(context, customerId) {
    return FutureBuilder<dynamic>(
        future: transaction.getUsd(customerId),
        builder: ((context, AsyncSnapshot<dynamic> usd) {
          if (usd.hasData) {
            if (usd.data['result'][0]['balance'] != null) {
              return usd.data['result'][0]['balance'] == 0.070987654567
                  ? const Text('')
                  : Text(
                      'USD ${usd.data['result'][0]['balance'].toString()}',
                      style: TextStyle(
                          fontSize: 12,
                          color: usd.data['result'][0]['balance'] >= 0.0
                              ? Colors.blueAccent
                              : const Color.fromARGB(255, 241, 39, 39),
                          fontWeight: FontWeight.w500),
                    );
            }
          }

          return const Text(
            'USD 0.0',
            style: TextStyle(
                color: Color.fromARGB(255, 104, 104, 104), fontSize: 12),
          );
        }));
  }

  Widget cursotmerForder(context, customerName, curstomerBalance) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.create_new_folder,
              color: Colors.amber,
              size: 32,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              '$customerName',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '$curstomerBalance FC',
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: greencolor),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 29, 29),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  _waiting(message) {
    return Padding(
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
        ));
  }

  _error(message) {
    return Padding(
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
    );
  }

  _empty(message) {
    return Padding(
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
        ));
  }
}
