import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MessageTile extends StatefulWidget {
  Message message;
  BuildContext mainPageContext;
  MessageTile({Key? key, required this.message, required this.mainPageContext})
      : super(key: key);

  @override
  MessageTileState createState() =>
      MessageTileState(message: message, mainPageContext: mainPageContext);
}

class MessageTileState extends State<MessageTile> {
  Message message;
  BuildContext mainPageContext;
  late bool isSender;
  MessageTileState({required this.message, required this.mainPageContext});

  @override
  Widget build(BuildContext context) {
    print(message.isread);
    isSender = message.sender_id == Appstate.currentUser.id;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(7.5),
        width: MediaQuery.of(mainPageContext).size.width * 0.5,
        margin: EdgeInsets.only(top: 10.0, right: 12.0, left: 12.0),
        decoration: BoxDecoration(
          color: isSender
              ? CupertinoColors.systemGrey6
              : CupertinoColors.systemBlue,
          shape: BoxShape.rectangle,
          borderRadius: isSender
              ? BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))
              : BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                message.content,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color:
                      isSender ? CupertinoColors.black : CupertinoColors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("dd MMM hh:mm a").format(message.sent.toLocal()),
                    style: TextStyle(
                      color: isSender
                          ? CupertinoColors.inactiveGray
                          : CupertinoColors.extraLightBackgroundGray,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    (isSender ? (' ' + (message.isread ? 'Read' : '')) : ''),
                    style: TextStyle(
                      color: isSender
                          ? CupertinoColors.inactiveGray
                          : CupertinoColors.extraLightBackgroundGray,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
