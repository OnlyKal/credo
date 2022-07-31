
import 'package:intl/intl.dart';

 String setDateTime(formattedString) {
    DateTime date = DateTime.parse(formattedString);
    String fdate = DateFormat('dd MMMM,yyyy | HH:mm a').format(date);
    return fdate;
  }
 String setDate(formattedString) {
    DateTime date = DateTime.parse(formattedString);
    String fdate = DateFormat('dd/MMMM/yyyy').format(date);
    return fdate;
  }