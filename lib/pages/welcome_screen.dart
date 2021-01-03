import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nx_play/constants.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, '/login');
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/cover_assets/$assetName.png', width: 200, height: 200,),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 16.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero, //fromLTRB(0, 40, 0, 0),
      //imageFlex: 2,
      //bodyFlex: 1,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: introOneTitle,
          body: introOneText,
          image: Center(
            child: _buildImage('cover_one_light'),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: introTwoTitle,
          body: introTwoText,
          image: _buildImage('cover_two_light'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: introThreeTitle,
          body: introThreeText,
          image: _buildImage('cover_three_light'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: introFourTitle,
          body: introFourText,
          image: _buildImage('cover_four_light'),
          footer: TextButton(
            child: Text(
              'Read More',
              style: TextStyle(color: Colors.yellow),
            ),
            onPressed: () {},
          ),
          decoration: pageDecoration,
        ),
      ],

      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        'Skip',
        style: TextStyle(color: Colors.white),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Accept',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      curve: Curves.easeInCubic,
    );
  }
}
