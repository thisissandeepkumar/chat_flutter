import 'dart:convert';
import 'package:chat_flutter/constants.dart';
import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/chatroom.dart';
import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/services/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Chatroom>> getAllChatrooms(BuildContext context) async {
  http.Response response = await http.get(Uri.parse(getMyChatroomsURL),
      headers: getAuthorizationHeaders());
  if (response.statusCode == 200) {
    List tempList = jsonDecode(response.body);
    List<Chatroom> returnList = [];
    tempList.forEach((element) {
      returnList.add(Chatroom.fromJSON(element));
    });
    return returnList;
  } else if (errorTokenStatusCodes.contains(response.statusCode)) {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool clearResult = await preferences.clear();
    if (clearResult || !clearResult) {
      Navigator.pushReplacementNamed(context, 'login');
    }
    return [];
  } else {
    print(response.statusCode);
    return [];
  }
}

User getOtherUser(Chatroom chatroom) {
  User currentUser = Appstate.currentUser;
  if (currentUser.id == chatroom.user1.id) {
    return chatroom.user2;
  } else {
    return chatroom.user1;
  }
}

Future<int> startChatroom(BuildContext context, String query) async {
  Uri finalURL = Uri.parse(startChatroomURL);
  http.Response response = await http.post(finalURL,
      headers: getAuthorizationHeaders(), body: jsonEncode({"query": query}));
  if (response.statusCode == 201) {
    return 1;
  } else if (response.statusCode == 408) {
    return 2;
  } else if (errorTokenStatusCodes.contains(response.statusCode)) {
    Navigator.pushReplacementNamed(context, 'login');
    return 4;
  } else {
    return 3;
  }
}
