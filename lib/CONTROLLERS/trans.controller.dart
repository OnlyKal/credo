import '../EXPORTS/exports.files.dart';

Future addUSDdedit(mountUSD, customerId, datePayement, description,typeOp) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit: 0.0,
      cdfDebit: 0.0,
      usdCredit: double.parse(mountUSD),
      clientId: customerId,
      paymentDate: datePayement ,
      description: description,typeOp:typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}

Future addCDFdebit(mountCDF, customerId, datePayement, description,typeOp) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit: double.parse(mountCDF),
      cdfDebit: 0.0,
      usdCredit: 0.0,
      clientId: customerId,
      paymentDate: datePayement ,
      description: description,typeOp:typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}

Future addUSDcrebit(mountUSD, customerId, description,typeOp) async {
  Transaction transaction = Transaction(
      usdDebit: double.parse(mountUSD),
      cdfCredit: 0.0,
      cdfDebit: 0.0,
      usdCredit: 0.0,
      clientId: customerId,
      paymentDate: ('01/05/2001'),
      description: description,typeOp:typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}

Future addCDFcrebit(mountCDF, customerId, description,typeOp) async {
  Transaction transaction = Transaction(
      usdDebit: 0.0,
      cdfCredit: 0.0,
      cdfDebit: double.parse(mountCDF),
      usdCredit: 0.0,
      clientId: customerId,
      paymentDate: ('01/05/2001'),
      description: description,typeOp:typeOp);
  transaction.add().then((trans) {
    if (trans['type'] == 'success') {
      messageSuccess(trans['message']);
    } else {
      messageError(trans['message']);
    }
  });
}
