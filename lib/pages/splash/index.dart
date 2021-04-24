import 'package:chat_flutter/models/appstate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    if (token != null) {
      setState(() {
        Appstate.authorizationHeaders = {'Authorization': token};
      });
      Navigator.pushNamed(context, 'dashboard');
    } else {
      Navigator.pushNamed(context, 'login');
    }
  }

  @override
  void initState() {
    super.initState();
    checkCredentials();
    Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Chat',
        ),
      ),
    );
  }
}
