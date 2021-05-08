import 'dart:convert';

import 'package:chat_flutter/constants.dart';
import 'package:http/http.dart' as http;

Future<bool> checkUnique(String query, String value) async {
  Uri finalURL = Uri.parse(uniqueCheckURL);
  Map<String, String> sendMap = {"query": query, "value": value};
  http.Response response = await http.post(finalURL,
      headers: {"content-type": "application/json"}, body: jsonEncode(sendMap));
  if (response.statusCode == 200) {
    Map tempMap = jsonDecode(response.body);
    int count = tempMap['value'];
    if (count >= 1) {
      return false;
    } else {
      return true;
    }
  } else {
    return false;
  }
}

Future<bool> registerUser(Map<String, String> map) async {
  Uri finalURL = Uri.parse(registerURL);
  http.Response response = await http.post(finalURL,
      headers: {"content-type": "application/json"}, body: jsonEncode(map));
  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}
