import 'package:chat_flutter/pages/chatpage/index.dart';
import 'package:chat_flutter/pages/dashboard/index.dart';
import 'package:chat_flutter/pages/login/index.dart';
import 'package:chat_flutter/pages/register/index.dart';
import 'package:chat_flutter/pages/splash/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
  //   NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: Color(0xFF9D50DD),
  //       ledColor: Colors.white)
  // ]);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  // Use this method to automatically convert the push data, in case you gonna use our data standard
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

// final WebSocketChannel channel =
//       WebSocketChannel.connect(Uri.parse('ws://192.168.29.174:4546'));

// class MyApp extends StatelessWidget {
//   // @override
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     home: SplashScreen(),
//   //     routes: {
//   //       'splash': (context) => SplashScreen(),
//   //       'login': (context) => LoginScreen(),
//   //       'dashboard': (context) => DashBoard(),
//   //     },
//   //     theme: ThemeData(
//   //       textTheme: GoogleFonts.ubuntuTextTheme(),
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
//     return CupertinoApp(
//       home: SplashScreen(),
//       routes: {
//         'splash': (context) => SplashScreen(),
//         'login': (context) => LoginScreen(),
//         'dashboard': (context) => DashBoard(),
//         'chatroom': (context) => ChatPage(),
//         'register': (context) => Registration(),
//       },
//     );
//   }
// }

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  late String? token;
  late FirebaseMessaging firebaseMessaging;
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      firebaseMessaging = FirebaseMessaging.instance;
      token = await firebaseMessaging.getToken();

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return CupertinoApp(
        home: CupertinoPageScaffold(
          child: Center(
            child: Container(
              child: Text('Something Went Wrong!'),
            ),
          ),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CupertinoApp(
        home: CupertinoPageScaffold(
            child: Center(
          child: CupertinoActivityIndicator(),
        )),
      );
    }
    return CupertinoApp(
      home: SplashScreen(),
      routes: {
        'splash': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'dashboard': (context) => DashBoard(),
        'chatroom': (context) => ChatPage(),
        'register': (context) => Registration(),
      },
    );
  }
}
