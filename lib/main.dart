import 'package:flutter/material.dart';
import 'package:nx_play/controllers/theme_data.dart';
import 'package:nx_play/pages/pages.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/login': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/app': (context) => SignUpScreen(),
        },
        theme: CustomTheme.darkTheme,
        debugShowCheckedModeBanner: true,
      ),
    );
