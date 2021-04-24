import 'dart:convert';

import 'package:chat_flutter/constants.dart';
import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/message.dart';
import 'package:chat_flutter/pages/chatpage/tiles.dart';
import 'package:chat_flutter/services/message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController scrollController;
  late TextEditingController messageController;
  late var channel;
  late List<Message> messagesList;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    messageController = new TextEditingController();
    messagesList = [];
    channel = IOWebSocketChannel.connect(Uri.parse(websocketURL));
    channel.stream.listen((message) {
      if (message != 'connected') {
        Map tempMap = jsonDecode(message);
        if (tempMap['chatroom'] == Appstate.currentChatroom.id &&
            tempMap['sender'] != Appstate.currentUser.id) {
          Message newMessage = Message(
              chatroom_id: Appstate.currentChatroom.id,
              id: tempMap['id'],
              sender_id: tempMap['sender'],
              delivered: false,
              isread: false,
              content: tempMap['content'],
              sent: DateTime.now());
          messagesList.add(newMessage);
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '${Appstate.otherUser.firstname} ${Appstate.otherUser.lastname}',
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 11,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: FutureBuilder(
                      future:
                          getAllMessages(Appstate.currentChatroom.id, context),
                      builder: (BuildContext futureBuildercontext,
                          AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CupertinoActivityIndicator(
                              animating: true,
                            ),
                          );
                        } else {
                          messagesList = snapshot.data;
                          return ListView.builder(
                              itemCount: messagesList.length,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: MessageTile(
                                    message: messagesList[index],
                                    mainPageContext: context,
                                  ),
                                );
                              });
                        }
                      }),
                )),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: CupertinoColors.lightBackgroundGray,
                )),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: 45.0,
                          margin: EdgeInsets.only(
                            left: 15.0,
                            right: 5.0,
                          ),
                          child: Center(
                            child: CupertinoTextField(
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.multiline,
                              controller: messageController,
                            ),
                          ),
                        ),
                      ),
                      flex: 8,
                    ),
                    Expanded(
                      child: Container(
                        child: GestureDetector(
                          onTap: () async {
                            if (messageController.text.isNotEmpty) {
                              // await sendMessage(
                              //     context, messageController.text);
                              channel.sink.add(jsonEncode({
                                "content": messageController.text,
                                "token": Appstate
                                    .authorizationHeaders['Authorization'],
                                "chatroom": Appstate.currentChatroom.id
                              }));
                              messageController.clear();
                              setState(() {});
                            }
                          },
                          child: Icon(
                            CupertinoIcons.arrow_up_circle_fill,
                            size: 40.0,
                          ),
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
