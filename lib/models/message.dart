class Message {
  int id;
  int chatroom_id;
  int sender_id;
  String content;
  bool delivered;
  bool isread;
  DateTime sent;

  Message({
    required this.id,
    required this.chatroom_id,
    required this.sender_id,
    required this.content,
    required this.delivered,
    required this.isread,
    required this.sent,
  });

  factory Message.fromJSON(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        chatroom_id: json['chatroom_id'],
        sender_id: json['sender_id'],
        content: json['content'],
        delivered: json['delivered'] == 0 ? false : true,
        isread: json['isread'] == 0 ? false : true,
        sent: DateTime.parse(json['sent']));
  }

  Map<String, dynamic> toJSON() {
    return {
      "content": content,
    };
  }
}
