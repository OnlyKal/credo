import 'package:credo/EXPORTS/exports.files.dart';

void newCustomer(custumerName, customerPhone, customerDetail, context) {
  Client customer = Client(
      name: custumerName,
      phoneNumber: customerPhone,
      description: customerDetail);

  customer.add().then((customer) {
    if (customer['type'] == 'success') {
      snackSuccess(context, customer['message']);
    } else {
      snackError(context, customer['message']);
    }
  });
}
