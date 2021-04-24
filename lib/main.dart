import 'package:chat_flutter/pages/chatpage/index.dart';
import 'package:chat_flutter/pages/dashboard/index.dart';
import 'package:chat_flutter/pages/login/index.dart';
import 'package:chat_flutter/pages/splash/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

// final WebSocketChannel channel =
//       WebSocketChannel.connect(Uri.parse('ws://192.168.29.174:4546'));

class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: SplashScreen(),
  //     routes: {
  //       'splash': (context) => SplashScreen(),
  //       'login': (context) => LoginScreen(),
  //       'dashboard': (context) => DashBoard(),
  //     },
  //     theme: ThemeData(
  //       textTheme: GoogleFonts.ubuntuTextTheme(),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: SplashScreen(),
      routes: {
        'splash': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'dashboard': (context) => DashBoard(),
        'chatroom': (context) => ChatPage(),
      },
      theme: CupertinoThemeData(),
    );
  }
}
