
import 'package:intl/intl.dart';

 String setDate(formattedString) {
    DateTime date = DateTime.parse(formattedString);
    String fdate = DateFormat('dd MMMM,yyyy | HH:mm a').format(date);
    return fdate;
  }