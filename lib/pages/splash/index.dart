import 'dart:convert';

import 'package:chat_flutter/constants.dart';
import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';
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
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, 'dashboard');
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, 'login');
      }
    } else {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  void initState() {
    super.initState();
    checkCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              CupertinoIcons.chat_bubble_2,
              size: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Text(
                'Developed by SK',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
