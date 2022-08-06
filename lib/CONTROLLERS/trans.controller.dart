import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

Future addCDFDebit(
    mountUSD, customerId, datePayement, description, typeOp) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit:0.0,
      cdfDebit:double.parse(mountUSD) ,
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

Future addCDFCredit(
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

Future addUSDebit(mountUSD, customerId, description, typeOp,datePayement) async {
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

Future addUSDCredit(mountCDF, customerId, description, typeOp,datePayement) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit: 0.0,
      cdfDebit: 0.0,
      usdCredit: double.parse(mountCDF),
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
