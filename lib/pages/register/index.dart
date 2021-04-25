import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/widgets/textInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late bool isUsernameTriggered;
  late bool isEmailTriggered;
  late bool isUsernameLoading;
  late bool isUsernameAvailale;
  late bool isEmailLoading;
  late bool isEmailAvailable;
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  @override
  void initState() {
    super.initState();
    firstnameController = new TextEditingController();
    lastnameController = new TextEditingController();
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmPasswordController = new TextEditingController();
    emailController = new TextEditingController();
    isUsernameTriggered = false;
    isEmailTriggered = false;
    isUsernameLoading = false;
    isUsernameAvailale = false;
    isEmailLoading = false;
    isEmailAvailable = false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset.fromDirection(5.0),
                      color: CupertinoColors.extraLightBackgroundGray),
                ],
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: CupertinoColors.lightBackgroundGray,
                )),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomInputField(
                  placeHolderText: 'First Name',
                  context: context,
                  controller: firstnameController,
                  textInputType: TextInputType.text,
                ),
                CustomInputField(
                  placeHolderText: 'Last Name',
                  context: context,
                  controller: lastnameController,
                  textInputType: TextInputType.text,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: CupertinoTextField(
                    placeholder: 'Username (Unique)',
                    suffix: isUsernameTriggered
                        ? isUsernameLoading
                            ? Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(10.0),
                                child: CupertinoActivityIndicator(
                                  animating: true,
                                ),
                              )
                            : isUsernameAvailale
                                ? Icon(CupertinoIcons.checkmark_alt_circle_fill)
                                : Icon(CupertinoIcons.multiply_circle_fill)
                        : SizedBox(),
                    controller: usernameController,
                    onChanged: (String value) async {
                      if (value == '') {
                        setState(() {
                          isUsernameTriggered = false;
                        });
                      } else {
                        setState(() {
                          isUsernameTriggered = true;
                          isUsernameLoading = true;
                        });
                        isUsernameAvailale =
                            await checkUnique('username', value);
                        setState(() {
                          isUsernameLoading = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: CupertinoTextField(
                    placeholder: 'Email (Unique)',
                    suffix: isEmailTriggered
                        ? isEmailLoading
                            ? Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(10.0),
                                child: CupertinoActivityIndicator(
                                  animating: true,
                                ),
                              )
                            : isEmailAvailable
                                ? Icon(CupertinoIcons.checkmark_alt_circle_fill)
                                : Icon(CupertinoIcons.multiply_circle_fill)
                        : SizedBox(),
                    controller: emailController,
                    onChanged: (String value) async {
                      if (value == '' || !RegExp(pattern).hasMatch(value)) {
                        setState(() {
                          isEmailTriggered = false;
                        });
                      } else {
                        setState(() {
                          isEmailTriggered = true;
                          isEmailLoading = true;
                        });
                        isEmailAvailable = await checkUnique('email', value);
                        setState(() {
                          isEmailLoading = false;
                        });
                      }
                    },
                  ),
                ),
                CustomInputField(
                  placeHolderText: 'Password',
                  context: context,
                  controller: passwordController,
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                CustomInputField(
                  placeHolderText: 'Confirm Password',
                  context: context,
                  controller: confirmPasswordController,
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                Container(
                  child: CupertinoButton.filled(
                    child: Text('Register'),
                    onPressed: () async {
                      if (firstnameController.text.isNotEmpty &&
                          lastnameController.text.isNotEmpty &&
                          usernameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty) {
                        if (isUsernameAvailale && isEmailAvailable) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            bool result = await registerUser({
                              'firstname': firstnameController.text,
                              'lastname': lastnameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                              'username': usernameController.text
                            });
                            if (result) {
                              Navigator.pop(context);
                            }
                          } else {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return CupertinoAlertDialog(
                                    actions: [
                                      CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.pop(dialogContext);
                                          },
                                          child: Text(
                                            'Dismiss',
                                          ))
                                    ],
                                    content: Text(
                                      'Passwords don\'t match!',
                                    ),
                                    title: Text(
                                      'Error',
                                    ),
                                  );
                                });
                          }
                        }
                      }
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
