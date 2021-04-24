import 'package:chat_flutter/models/chatroom.dart';
import 'package:chat_flutter/pages/dashboard/tiles.dart';
import 'package:chat_flutter/services/chatroom_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController(keepScrollOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              trailing: GestureDetector(
                onTap: () {
                  TextEditingController searchController =
                      new TextEditingController();
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'New Chatroom',
                          ),
                          content: StatefulBuilder(builder:
                              (BuildContext stateFulBuilderContext,
                                  StateSetter setDialogState) {
                            return Container(
                              child: CupertinoTextField(
                                controller: searchController,
                                keyboardType: TextInputType.text,
                              ),
                            );
                          }),
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: Text(
                                  'Dismiss',
                                )),
                            CupertinoDialogAction(
                                onPressed: () async {
                                  if (searchController.text.isNotEmpty) {
                                    int result = await startChatroom(
                                        context, searchController.text);
                                    setState(() {});
                                    Navigator.pop(dialogContext);
                                  }
                                },
                                child: Text(
                                  'Create',
                                ))
                          ],
                        );
                      });
                },
                child: Icon(CupertinoIcons.add),
              ),
              largeTitle: Text(
                'Messages',
              ),
            ),
          ];
        },
        body: Container(
          child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                  ),
                );
              } else {
                List<Chatroom> chatroomList = snapshot.data;
                return Center(
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: scrollController,
                      itemCount: chatroomList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatroomTile(
                          chatroom: chatroomList[index],
                        );
                      },
                    ),
                  ),
                );
              }
            },
            future: getAllChatrooms(context),
          ),
        ),
      ),
    );
  }
}
