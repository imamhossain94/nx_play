import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/constants.dart';

class PasswordInput extends StatefulWidget {
  PasswordInput({
    Key key,
    @required this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isShown = false;

  @override
  void initState() {
    
    super.initState();
    isShown = false;

  }

  @override
  Widget build(BuildContext context) {
    Icon passIcon = isShown
        ? Icon(FontAwesomeIcons.eyeSlash, color: Colors.grey)
        : Icon(FontAwesomeIcons.eye, color: Colors.grey);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Color(0xff212028),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  widget.icon,
                  size: 20,
                  color: kWhite,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: IconButton(
                  icon: passIcon,
                  focusColor: PrimaryColor,
                  highlightColor: TextFieldColor,
                  onPressed: () {
                    setState(() {
                      if (isShown) {
                        isShown = false;
                      } else {
                        isShown = true;
                      }
                    });
                  },
                ),
              ),
              hintText: widget.hint,
              hintStyle: kBodyText,
            ),
            obscureText: !isShown,
            style: kBodyText,
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
          ),
        ),
      ),
    );
  }
}
