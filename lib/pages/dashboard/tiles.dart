import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/chatroom.dart';
import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/services/chatroom_service.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class ChatroomTile extends StatefulWidget {
  Chatroom chatroom;
  ChatroomTile({Key? key, required this.chatroom}) : super(key: key);

  @override
  _ChatroomTileState createState() => _ChatroomTileState(chatroom: chatroom);
}

class _ChatroomTileState extends State<ChatroomTile> {
  Chatroom chatroom;
  late User otherUser;
  _ChatroomTileState({required this.chatroom});
  @override
  Widget build(BuildContext context) {
    otherUser = getOtherUser(chatroom);
    return GestureDetector(
      onTap: () {
        setState(() {
          Appstate.currentChatroom = chatroom;
          Appstate.otherUser = otherUser;
        });
        Navigator.pushNamed(context, 'chatroom');
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: double.infinity,
              // decoration:
              //     BoxDecoration(border: Border.all(color: CupertinoColors.black)),
              child: Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.inactiveGray,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    otherUser.firstname[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.07,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(
                left: 8.0,
              ),
              child: Center(
                child: Text(
                  '${otherUser.firstname} ${otherUser.lastname}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
