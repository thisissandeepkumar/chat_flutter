import 'package:chat_flutter/models/appstate.dart';

Map<String, String> getAuthorizationHeaders() {
  String? token = Appstate.authorizationHeaders['Authorization'];
  return {
    "Authorization": token == null ? "notoken" : token,
    "content-type": "application/json"
  };
}
