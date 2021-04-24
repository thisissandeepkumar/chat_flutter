import 'dart:convert';
import 'package:chat_flutter/constants.dart';
import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/message.dart';
import 'package:chat_flutter/services/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<Message>> getAllMessages(int id, BuildContext context) async {
  Uri finalURL = Uri.parse(getChatroomMessagesURL + id.toString());
  http.Response response =
      await http.get(finalURL, headers: getAuthorizationHeaders());
  if (response.statusCode == 200) {
    List tempList = jsonDecode(response.body);
    List<Message> returnList = [];
    tempList.forEach((element) {
      returnList.add(Message.fromJSON(element));
    });
    return returnList;
  } else if (errorTokenStatusCodes.contains(response.statusCode)) {
    Navigator.pushReplacementNamed(context, 'login');
    return [];
  } else {
    return [];
  }
}

Future<void> sendMessage(BuildContext context, String message) async {
  Uri finalURL = Uri.parse(
      sendChatroomMessageURL + Appstate.currentChatroom.id.toString());
  http.Response response = await http.post(finalURL,
      headers: getAuthorizationHeaders(),
      body: jsonEncode({"content": message}));
  if (response.statusCode == 201) {
    return null;
  } else if (errorTokenStatusCodes.contains(response.statusCode)) {
    Navigator.pushReplacementNamed(context, 'login');
  } else {
    return null;
  }
}
