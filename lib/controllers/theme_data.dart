import 'package:flutter/material.dart';
import 'package:nx_play/constants.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: PrimaryColor,
      scaffoldBackgroundColor: PrimaryColor,
      //fontFamily: 'xyz',
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        buttonColor: SecondaryColor,
      ),
      textTheme: ThemeData.dark().textTheme,
      iconTheme: ThemeData.dark().iconTheme,
    );
  }
}
