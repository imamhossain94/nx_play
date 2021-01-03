import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nx_play/constants.dart';
import 'package:nx_play/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  //Future<void> _handleSignOut() => _googleSignIn.disconnect();

  bool isChacked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Transparent,
        elevation: 0,
        title: Text(appName),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInputField(
                    icon: FontAwesomeIcons.at,
                    hint: 'Email',
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  PasswordInput(
                    icon: FontAwesomeIcons.unlock,
                    hint: 'Password',
                    inputAction: TextInputAction.done,
                  ),
                  PasswordInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Confirm Password',
                    inputAction: TextInputAction.done,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Theme(
                      // data: ThemeData(unselectedWidgetColor: Colors.yellow),
                      // child: Checkbox(
                      //     value: isChacked,
                      //     onChanged: (bool value) {
                      //       setState(() {
                      //         isChacked = value;
                      //       });
                      //     },
                      //     checkColor: TextFieldColor,
                      //     activeColor: Colors.yellow,
                      //   ),
                      // ),
                      Text('Already have an account?'),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign in!',
                            style: TextStyle(color: Colors.yellow),
                          ))
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      children: <Widget>[
                        RoundedIconButton(
                          height: 55,
                          width: 55,
                          icon: Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(width: 20),
                        RoundedIconButton(
                          height: 55,
                          width: 55,
                          icon: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            _handleSignIn();
                          },
                        ),
                        SizedBox(width: 20),
                        RoundedIconButton(
                          height: 55,
                          width: 55,
                          icon: Icon(
                            FontAwesomeIcons.githubAlt,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Spacer(),
                        RoundedTextButton(
                          buttonName: 'SIGN UP',
                          height: 55,
                          width: 100,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
