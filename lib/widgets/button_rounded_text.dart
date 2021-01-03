import 'package:flutter/material.dart';
import 'package:nx_play/constants.dart';

class RoundedTextButton extends StatelessWidget {
  const RoundedTextButton(
      {Key key,
      @required this.buttonName,
      @required this.height,
      @required this.width,
      @required this.onPressed})
      : super(key: key);

  final String buttonName;
  final double height, width;
  final VoidCallback onPressed;

  String getName() => this.buttonName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: TextFieldColor,
      ),
      child: FlatButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
