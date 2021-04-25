import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class CustomInputField extends StatefulWidget {
  BuildContext context;
  TextEditingController? controller;
  bool? obscureText;
  TextInputType? textInputType;
  String? placeHolderText;
  CustomInputField(
      {Key? key,
      this.placeHolderText,
      required this.context,
      @required this.controller,
      this.obscureText,
      @required this.textInputType})
      : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState(
      mainScreenContext: context,
      placeHolderText: placeHolderText,
      controller: controller,
      textInputType: textInputType,
      obscureText: obscureText);
}

class _CustomInputFieldState extends State<CustomInputField> {
  TextEditingController? controller;
  TextInputType? textInputType;
  bool? obscureText;
  BuildContext mainScreenContext;
  String? placeHolderText;
  _CustomInputFieldState(
      {required this.mainScreenContext,
      @required this.controller,
      this.textInputType,
      this.placeHolderText,
      this.obscureText});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: MediaQuery.of(mainScreenContext).size.height * 0.05,
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      child: CupertinoTextField(
        placeholder: placeHolderText == null ? '' : placeHolderText,
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText == null ? false : true,
      ),
    );
  }
}
