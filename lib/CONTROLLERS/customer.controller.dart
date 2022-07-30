import 'package:credo/EXPORTS/exports.files.dart';
import 'package:flutter/cupertino.dart';

void newCustomer(custumerName, customerPhone, customerDetail) {
  Client customer = Client(
      name: custumerName,
      phoneNumber: customerPhone,
      description: customerDetail);

  customer.add().then((customer) {
    debugPrint(customer.toString());
  });
}
