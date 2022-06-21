import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedMenu = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Credit monitoring',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          leading: const Icon(
            Icons.more_vert_sharp,
            color: Colors.transparent,
            size: 1,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 11, right: 11),
              child: PopupMenuButton<int>(
                  onSelected: (item) => setState(() {
                        if (item == 1) {
                          _addCurstomer(context);
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
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_filled),
              ),
              Tab(icon: Icon(Icons.people_rounded)),
              Tab(
                icon: Icon(Icons.history_toggle_off_sharp),
              )
            ],
          ),
        ),
        body: const TabBarView(children: [FirstTab(), SecondTab(), FirstTab()]),
      ),
    );
  }
}

Widget lastTransaction(context) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: greencolor,
      ),
      height: fullHeight(context) * .09,
      width: fullWidth(context) * .28,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Justin Bihango Stark',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(184, 233, 253, 249)),
            ),
            Text(
              'Mer.12.03.2022',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
            SizedBox(
              height: 9,
            ),
            Text(
              '300000.00 £',
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

_addCurstomer(BuildContext context) {
  TextEditingController curstomerName = TextEditingController();
  TextEditingController curstomerPhone = TextEditingController();
  TextEditingController curstomerDetails = TextEditingController();

  _onCreateCurstomer() => addCurtomer(
      curstomerName.text, curstomerPhone.text, curstomerDetails.text);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nouveau client'),
          content: SizedBox(
              width: fullWidth(context),
              height: fullHeight(context) * 0.23,
              child: SingleChildScrollView(
                child: Column(children: [
                  inputField(
                      context, curstomerName, 'Noms du client', Icons.person),
                  inputField(context, curstomerPhone, 'Télephone', Icons.phone),
                  inputField(context, curstomerDetails, 'Détails',
                      Icons.density_medium_sharp),
                ]),
              )),
          actions: [button(context, _onCreateCurstomer, 'Enregistrer')],
        );
      });
}

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);
  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: paddingTop(context),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
          child: Text('Les Transactions récentes'),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              height: fullHeight(context) * 0.1,
              width: fullWidth(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: null,
                    child: lastTransaction(context),
                  );
                },
              ),
            ))
      ],
    );
  }
}

class SecondTab extends StatefulWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 200,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: greencolor,
                            borderRadius:
                                BorderRadius.circular(fullHeight(context))),
                        child: const Center(
                            child: Icon(
                          Icons.person_outline_rounded,
                          size: 30,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Justin Bihango',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      '10.000 FC',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(206, 25, 144, 240),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      '0 FC',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(245, 221, 43, 43),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  const Icon(Icons.addchart_rounded)
                ]),
          );
        }));
  }
}
