import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  BuildContext context;
  String displayText;
  Function onTap;
  CustomButton(
      {Key? key,
      required this.context,
      required this.displayText,
      required this.onTap})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState(
      mainScreenContext: context, displayText: displayText, onTap: onTap);
}

class _CustomButtonState extends State<CustomButton> {
  String displayText;
  Function onTap;
  BuildContext mainScreenContext;
  _CustomButtonState(
      {required this.displayText,
      required this.onTap,
      required this.mainScreenContext});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(mainScreenContext).size.height * 0.05,
      width: MediaQuery.of(mainScreenContext).size.width *
          (MediaQuery.of(mainScreenContext).orientation == Orientation.landscape
              ? 0.08
              : 0.35),
      child: CupertinoButton.filled(
          disabledColor: CupertinoColors.systemBlue,
          child: Text(
            displayText,
            style: TextStyle(
              height: MediaQuery.of(mainScreenContext).size.height * 0.03,
              color: Colors.black,
            ),
          ),
          onPressed: onTap()),
    );
  }
}
