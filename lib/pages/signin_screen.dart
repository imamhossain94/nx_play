import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nx_play/constants.dart';
import 'package:nx_play/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:nx_play/controllers/secret_keys.dart' as SecretKey;
import 'package:url_launcher/url_launcher.dart';

void onClickGitHubLoginButton() async {
  const String url = "https://github.com/login/oauth/authorize" +
      "?client_id=" +
      SecretKey.GITHUB_CLIENT_ID +
      "&scope=public_repo%20read:user%20user:email";
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    print("CANNOT LAUNCH THIS URL!");
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

//keytool -exportcert -alias androiddebugkey -keystore "C:\Users\Redman\.android\debug.keystore" | "C:\openssl-0.9.8k_X64\bin\openssl" sha1 -binary | "C:\openssl-0.9.8k_X64\bin\openssl" base64
//$ keytool -exportcert -alias androiddebugkey -keystore "C:\Users\imamh\.android\debug.keystore" | "C:\OpenSSL\bin\openssl" sha1 -binary |"C:\OpenSSL\bin\openssl" base64

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
  }

  Future<void> _checkIfIsLogged() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken.toJson()),
    );
  }

  Future<void> _login() async {
    try {
      // show a circular progress indicator
      setState(() {
        _checking = true;
      });
      _accessToken = await FacebookAuth.instance
          .login(); // by the fault we request the email and the public profile
      // loginBehavior is only supported for Android devices, for ios it will be ignored
      // _accessToken = await FacebookAuth.instance.login(
      //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      //   loginBehavior:
      //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
      // );
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    } finally {
      // update the view
      setState(() {
        _checking = false;
      });
    }
  }

  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

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
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "SIGN IN",
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
            flex: 1,
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
                    icon: FontAwesomeIcons.lock,
                    hint: 'Password',
                    inputAction: TextInputAction.done,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Don\'t have an account?'),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign up!',
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
                          onPressed: () {
                            _login();
                          },
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
                          onPressed: () {
                            onClickGitHubLoginButton();
                          },
                        ),
                        Spacer(),
                        Builder(
                          builder: (context) => RoundedTextButton(
                            buttonName: 'SIGN IN',
                            height: 55,
                            width: 100,
                            onPressed: () {
                              _handleSignOut();
                              _showToast(context);
                            },
                          ),
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
