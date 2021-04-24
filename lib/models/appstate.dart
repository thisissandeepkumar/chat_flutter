import 'package:chat_flutter/models/chatroom.dart';
import 'package:chat_flutter/models/user.dart';

class Appstate {
  static Map<String, String> authorizationHeaders = Map();
  static User currentUser =
      User(id: 0, username: '', email: '', firstname: '', lastname: '');
  static User otherUser =
      User(id: 0, username: '', email: '', firstname: '', lastname: '');
  static Chatroom currentChatroom = Chatroom(
      id: 0,
      created: DateTime(1970, 1, 1, 0, 0, 0, 0),
      user1: User(id: 0, username: '', email: '', firstname: '', lastname: ''),
      user2: User(id: 0, username: '', email: '', firstname: '', lastname: ''));
}
