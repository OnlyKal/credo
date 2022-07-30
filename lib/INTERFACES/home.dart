import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:intl/intl.dart';

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
  TextEditingController curstomerDetails = TextEditingController();

  _onCreateCurstomer() {
    newCustomer(curstomerName.text, curstomerPhone.text, curstomerDetails.text);
    setState(() {
      curstomerName.text = curstomerPhone.text = curstomerDetails.text = '';
    });
  }

  @override
  void initState() {
    setState(() {
      getCustomer();
    });
    super.initState();
  }

  String _setDate(formattedString) {
    DateTime date = DateTime.parse(formattedString);
    String fdate = DateFormat('dd MMMM,yyyy | HH:mm a').format(date);
    return fdate;
  }

  Client customer = const Client();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: fullHeight(context),
            width: fullWidth(context),
            child: Column(children: [
              SizedBox(
                height: fullHeight(context) * 0.19,
                width: fullWidth(context),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: paddingTop(context),
                      ),
                      SizedBox(
                        height: fullHeight(context) * 0.06,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Cre',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 31,
                                    color: greencolor),
                              ),
                              Text(
                                'do',
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 31,
                                    color: greencolor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: greencolor,
                        height: fullHeight(context) * 0.06,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 13, right: 13),
                          child: TextField(
                            controller: seachcontroller,
                            onChanged: (value) {
                              setState(() {
                                _searchResult = value.toString();
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: 'Recherche client',
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      )
                    ]),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: FutureBuilder<dynamic>(
                    future: _searchResult != ''
                        ? customer.getLike(_searchResult)
                        : customer.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> curtomer) {
                      if (curtomer.hasError) {
                        return _error('Erreur, données inaccessible..!');
                      }
                      if (curtomer.connectionState == ConnectionState.none) {
                        return const Text('No COnnnection');
                      }
                      if (curtomer.connectionState == ConnectionState.waiting) {
                        return _waiting('Attente des données..');
                      }
                      if (curtomer.connectionState == ConnectionState.done) {
                        if (curtomer.hasData) {
                          if (curtomer.data['type'] == 'success') {
                            var data = curtomer.data['result'];
                            debugPrint(data.toString());
                            if (data.length == 0) {
                              return _empty(
                                  'Désolé, aucun client identifiés...!');
                            }

                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: curtomer.data['result'].length,
                                itemBuilder: (context, i) {
                                  List list = data.toList();
                                  list.sort((a, b) {
                                    return a['name']
                                        .toLowerCase()
                                        .compareTo(b['name'].toLowerCase());
                                  });

                                  return GestureDetector(
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
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              greencolor,
                                                          child: Text(
                                                            '${list[i]['name'].substring(0, 1)}',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
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
                                                              list[i]['name']
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
                                                              list[i]['phone']
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
                                                    int.parse(list[i]['balance']
                                                                .toString()) ==
                                                            0
                                                        ? const Text('')
                                                        : Text(
                                                            'CDF ${list[i]['balance'].toString()}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: list[i][
                                                                            'balance'] >=
                                                                        0
                                                                    ? const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        36,
                                                                        198,
                                                                        68)
                                                                    : const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        241,
                                                                        39,
                                                                        39),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
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
                      return _error('Erreur, données inaccessible..!');
                    }),
              )),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
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
            Icons.add,
            color: Colors.white,
          ),
        ));
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  _error(message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.cloud_off,
          size: 26,
          color: Color.fromARGB(255, 158, 158, 158),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(message)
      ],
    );
  }

  _empty(message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
