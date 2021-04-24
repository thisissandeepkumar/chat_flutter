import 'dart:convert';
import 'package:chat_flutter/constants.dart';
import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/widgets/button.dart';
import 'package:chat_flutter/widgets/textInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  late SharedPreferences preferences;

  void initializeSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> onButtonPress() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black,
        )),
        alignment: Alignment.center,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
        // margin: EdgeInsets.only(
        //   top: MediaQuery.of(context).size.height * 0.4,
        //   bottom: MediaQuery.of(context).size.height * 0.4,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomInputField(
              context: context,
              textInputType: TextInputType.name,
              controller: loginController,
            ),
            CustomInputField(
              context: context,
              textInputType: TextInputType.name,
              controller: passwordController,
              obscureText: true,
            ),
            Container(
              height: MediaQuery.of(context).size.height *
                  (MediaQuery.of(context).orientation == Orientation.landscape
                      ? 0.05
                      : 0.05),
              child: CupertinoButton.filled(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                  ),
                ),
                onPressed: () async {
                  if (loginController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    http.Response response = await http.post(
                        Uri.parse(loginURL),
                        headers: {"content-type": "application/json"},
                        body: jsonEncode({
                          'login': loginController.text,
                          'password': passwordController.text
                        }));
                    if (response.statusCode == 200) {
                      Map dataMap = jsonDecode(response.body);
                      setState(() {
                        Appstate.authorizationHeaders = {
                          'Authorization': dataMap['token']
                        };
                      });
                      preferences.setString('token', dataMap['token']);
                      Navigator.pushNamed(context, 'dashboard');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
