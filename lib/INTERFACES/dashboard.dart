import 'package:credo/CONFIG/colors.dart';
import 'package:credo/CONFIG/media.query.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: fullHeight(context),
        width: fullHeight(context),
        child: Column(
          children: [
            _cardSold(),
            const SizedBox(
              height: 29,
            ),
          ],
        ),
      )),
    );
  }

  Widget _cardSold() {
    return Container(
      padding: EdgeInsets.only(top: paddingTop(context)),
      width: fullWidth(context),
      height: 120,
      decoration: BoxDecoration(
          color: greencolor, borderRadius: BorderRadius.circular(0)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '35.000',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Solde CDF',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(213, 232, 253, 254)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '15.0',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Solde USD',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(213, 232, 253, 254)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ]),
    );
  }
}
