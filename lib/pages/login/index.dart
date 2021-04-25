import 'dart:convert';
import 'package:chat_flutter/constants.dart';
import 'package:chat_flutter/models/appstate.dart';
import 'package:chat_flutter/models/user.dart';
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
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset.fromDirection(5.0),
                    color: CupertinoColors.extraLightBackgroundGray,
                  )
                ],
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: CupertinoColors.lightBackgroundGray,
                )),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.4,
            // margin: EdgeInsets.only(
            //   top: MediaQuery.of(context).size.height * 0.4,
            //   bottom: MediaQuery.of(context).size.height * 0.4,
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInputField(
                  placeHolderText: 'Email or Username',
                  context: context,
                  textInputType: TextInputType.name,
                  controller: loginController,
                ),
                CustomInputField(
                  placeHolderText: 'Password',
                  context: context,
                  textInputType: TextInputType.name,
                  controller: passwordController,
                  obscureText: true,
                ),
                Container(
                  height: MediaQuery.of(context).size.height *
                      (MediaQuery.of(context).orientation ==
                              Orientation.landscape
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
                            Appstate.currentUser =
                                User.fromJSON(dataMap['user']);
                          });
                          preferences.setString('token', dataMap['token']);
                          Navigator.pushReplacementNamed(context, 'dashboard');
                        }
                      }
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height *
                      (MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 0.05
                          : 0.05),
                  child: CupertinoButton.filled(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
