import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';
import 'package:contact_picker/contact_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future? curstomerData;
  TextEditingController curstomerName = TextEditingController();
  TextEditingController curstomerPhone = TextEditingController();
  TextEditingController curstomerDetails = TextEditingController();

  _onCreateCurstomer() {
    addCurtomer(curstomerName.text, curstomerPhone.text, curstomerDetails.text);
    setState(() {
      curstomerData = getCustomer();
      curstomerName.text = curstomerPhone.text = curstomerDetails.text = '';
    });
  }

  final ContactPicker _contactPicker = ContactPicker();
  late Contact _contact;

  @override
  void initState() {
    setState(() {
      curstomerData = getCustomer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Credit monitoring',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 11, right: 11),
              child: PopupMenuButton<int>(
                  onSelected: (item) => setState(() {
                        if (item == 1) {
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
                                                Contact contact =
                                                    await _contactPicker
                                                        .selectContact();
                                                setState(() {
                                                  curstomerName.text = contact
                                                      .fullName
                                                      .toString();
                                                  curstomerPhone.text = contact
                                                      .phoneNumber
                                                      .toString();
                                                });
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons
                                                        .add_circle_outline_rounded,
                                                    color: greencolor,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Contacts')
                                                ],
                                              )),
                                          inputField(context, curstomerName,
                                              'Noms du client', Icons.person),
                                          inputField(context, curstomerPhone,
                                              'Téléphone', Icons.phone),
                                          inputField(
                                              context,
                                              curstomerDetails,
                                              'Description',
                                              Icons.density_medium_sharp),
                                        ]),
                                      )),
                                  actions: [
                                    TextButton(
                                        onPressed: _onCreateCurstomer,
                                        child: const Text('Ajouter',
                                            style:
                                                TextStyle(color: greencolor)))
                                  ],
                                );
                              });
                        }
                      }),
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                          height: 40,
                          value: 1,
                          child: Text('Nouveau client'),
                          onTap: null,
                        ),
                        const PopupMenuItem(
                            height: 40, value: 2, child: Text('Parametres')),
                        const PopupMenuItem(
                            height: 40, value: 3, child: Text('Profile')),
                      ]),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: fullHeight(context),
            width: fullWidth(context),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Expanded(
                    child: FutureBuilder<dynamic>(
                        future: curstomerData,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> curtomer) {
                          if (curtomer.hasError) {
                            return _error('Erreur, données inaccessible..!');
                          }
                          if (curtomer.connectionState ==
                              ConnectionState.none) {
                            return const Text('No COnnnection');
                          }
                          if (curtomer.connectionState ==
                              ConnectionState.waiting) {
                            return _waiting('Attente des données..');
                          }
                          if (curtomer.connectionState ==
                              ConnectionState.done) {
                            if (curtomer.hasData) {
                              if (curtomer.data['type'] == 'success') {
                                var data = curtomer.data['result'];

                                if (data.length == 0) {
                                  return _empty(
                                      'Désolé, aucun client identifiés...!');
                                }

                                return ListView.builder(
                                    itemCount: curtomer.data['result'].length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () => goto(context,
                                            HomeTransaction(customer: data[i])),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                              height: fullHeight(context) * .1,
                                              width: fullWidth(context),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      data[i]['description']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              child: Text(
                                                                '${data[i]['name'].substring(0, 1)}',
                                                                style: const TextStyle(
                                                                    color:
                                                                        greencolor),
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
                                                                      fontSize:
                                                                          22,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          204,
                                                                          203,
                                                                          203),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                const SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Text(
                                                                  data[i]['phone']
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color:
                                                                          greencolor),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          'CDF ${data[i]['balance'].toString()}',
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      241,
                                                                      39,
                                                                      39),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    )
                                                  ]),
                                            ),
                                            Container(
                                              height: 2,
                                              width: fullWidth(context),
                                              color: const Color.fromARGB(
                                                  255, 78, 77, 77),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }
                            }
                          }
                          return _error('Erreur, données inaccessible..!');
                        })),
                Container(
                  height: 3,
                  width: fullWidth(context),
                  color: Colors.amber,
                ),
              ]),
            ),
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
