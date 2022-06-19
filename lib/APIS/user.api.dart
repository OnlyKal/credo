import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../STATICS/data.static.dart';

Future signin(data) async {
  var response = await http.post(Uri.parse('$serverAddress/login'),body: data);
  debugPrint(jsonDecode(response.body));
}


Future signup(data) async {
  var response = await http.post(Uri.parse('$serverAddress/add'),body: data);
  debugPrint(jsonDecode(response.body));
}

