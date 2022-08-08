import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

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
          newCustomer(
              curstomerName.text, curstomerPhone.text, curstomerDetails.text);
          setState(() {
            curstomerName.text = curstomerPhone.text = '';
          });
        } else {
          messageError('Ajouter une description..!');
        }
      } else {
        messageError('Ajouter un numéro de téléphone..!');
      }
    } else {
      messageError('Ajouter un nom..!');
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

  Client customer = const Client();
  Transaction transaction = const Transaction();
  @override
  void initState() {
    setState(() {
      customer.get(_filter, _inverse);
    });
    super.initState();
  }

  bool searchBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: fullHeight(context),
            width: fullWidth(context),
            child: Column(children: [
              StatefulBuilder(builder: ((context, setState) {
                return SizedBox(
                  width: fullWidth(context),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: paddingTop(context),
                        ),
                        SizedBox(
                          height: fullHeight(context) * 0.07,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Credo',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 24,
                                          color: greencolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    if (searchBar == false)
                                      IconButton(
                                          onPressed: () => setState(
                                              () => searchBar = !searchBar),
                                          icon: const Icon(
                                            Icons.search_rounded,
                                            color: Color.fromARGB(
                                                255, 179, 178, 178),
                                          )),
                                  ])
                                ],
                              )),
                        ),
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
                                            _searchResult = value.toString();
                                            if (seachcontroller.text == '') {}
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Recherche....',
                                            prefixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    searchBar = !searchBar;
                                                    if (searchBar == false) {
                                                      seachcontroller.text = '';
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
                                            border: const UnderlineInputBorder(
                                                borderSide: BorderSide.none),
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
                );
              })),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: FutureBuilder<dynamic>(
                    future: _searchResult != ''
                        ? customer.getLike(_searchResult)
                        : customer.get(_filter, _inverse),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> curtomer) {
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
                              return _empty(
                                  'Désolé, aucun client identifié...!');
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
                                        SizedBox(
                                          height: fullHeight(context) * .06,
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
                                                          CrossAxisAlignment
                                                              .end,
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
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Nouveau client'),
                    content: SizedBox(
                        width: fullWidth(context),
                        height: fullHeight(context) * 0.28,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            GestureDetector(
                                onTap: () async {
                                  final PhoneContact contact =
                                      await FlutterContactPicker
                                          .pickPhoneContact();

                                  setState(() {
                                    curstomerName.text =
                                        (contact.fullName).toString();
                                    curstomerPhone.text =
                                        (contact.phoneNumber!.number)
                                            .toString()
                                            .replaceAll(' ', '');
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
          },
          child: const Icon(
            Icons.person_add_alt_outlined,
            color: Colors.white,
          ),
        ));
  }

  Widget searchBtn(icon, title, event) {
    return SizedBox(
        height: 35,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                elevation: 0.3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Color.fromARGB(181, 62, 242, 224)),
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
