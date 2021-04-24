import 'package:chat_flutter/models/user.dart';

class Chatroom {
  int id;
  User user1;
  User user2;
  DateTime created;

  Chatroom({
    required this.id,
    required this.created,
    required this.user1,
    required this.user2,
  });

  factory Chatroom.fromJSON(Map<String, dynamic> json) {
    return Chatroom(
        id: json['id'],
        created: DateTime.parse(json['created']),
        user1: User(
            id: json['user1'],
            firstname: json['firstname_sender'],
            lastname: json['lastname_sender'],
            email: json['email_sender'],
            username: json['username_sender']),
        user2: User(
            id: json['user2'],
            firstname: json['firstname_receiver'],
            lastname: json['lastname_receiver'],
            email: json['email_receiver'],
            username: json['username_receiver']));
  }

  Map<String, dynamic> toJSON() {
    return {"user2": user2.id};
  }
}
