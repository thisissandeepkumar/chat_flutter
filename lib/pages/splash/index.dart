import 'dart:convert';

import 'package:chat_flutter/constants.dart';
import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      http.Response response = await http
          .get(Uri.parse(verifyURL), headers: {'Authorization': token});
      if (response.statusCode == 200) {
        User user = User.fromJSON(jsonDecode(response.body));
        setState(() {
          Appstate.authorizationHeaders = {'Authorization': token};
          Appstate.currentUser = user;
        });
        Navigator.pushReplacementNamed(context, 'dashboard');
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    } else {
      Navigator.pushReplacementNamed(context, 'login');
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
