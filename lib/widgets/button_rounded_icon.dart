import 'package:flutter/material.dart';
import 'package:nx_play/constants.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key key,
    @required this.height,
    @required this.width,
    @required this.onPressed,
    @required this.icon,
  }) : super(key: key);

  final double height, width;
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: TextFieldColor,
      ),
      child: IconButton(
        icon: icon,
        highlightColor: TextFieldColor,
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
