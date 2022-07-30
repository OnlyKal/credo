import 'package:credo/EXPORTS/exports.files.dart';

void newCustomer(custumerName, customerPhone, customerDetail) {
  Client customer = Client(
      name: custumerName,
      phoneNumber: customerPhone,
      description: customerDetail);

  customer.add().then((customer) {
    
  });
}
