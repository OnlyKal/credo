import 'package:flutter/material.dart';

import '../EXPORTS/exports.files.dart';

Future addUSDdedit(
    mountUSD, customerId, datePayement, description, typeOp) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit: 0.0,
      cdfDebit: 0.0,
      usdCredit: double.parse(mountUSD),
      clientId: customerId,
      paymentDate: datePayement,
      description: description,
      typeOp: typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}

Future addCDFdebit(
    mountCDF, customerId, datePayement, description, typeOp) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit: double.parse(mountCDF),
      cdfDebit: 0.0,
      usdCredit: 0.0,
      clientId: customerId,
      paymentDate: datePayement,
      description: description,
      typeOp: typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}

Future addUSDcrebit(mountUSD, customerId, description, typeOp,datePayement) async {
  Transaction transaction = Transaction(
      usdDebit: double.parse(mountUSD),
      cdfCredit: 0.0,
      cdfDebit: 0.0,
      usdCredit: 0.0,
      clientId: customerId,
      paymentDate: datePayement,
      description: description,
      typeOp: typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}

Future addCDFcrebit(mountCDF, customerId, description, typeOp,datePayement) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit: 0.0,
      cdfDebit: double.parse(mountCDF),
      usdCredit: 0.0,
      clientId: customerId,
      paymentDate: datePayement,
      description: description,
      typeOp: typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}

void getUSDbalance(customerID) {
  double balance = 0.0;
  Transaction transaction = const Transaction();
  transaction.getUsd(customerID).then((value) {
    debugPrint(value['result'][0]['balance'].toString());
  });
}
