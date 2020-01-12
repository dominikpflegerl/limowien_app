import 'dart:ui';

import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:limowien_app/main.dart';

class AppLaunch extends StatefulWidget {
  @override
  AppSplashScreen createState() => new AppSplashScreen();
}

class AppSplashScreen extends State<AppLaunch> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new Home(),
        title: new Text('limowien',
          style: new TextStyle(
              color: Color(0xFFdfddde),
              fontFamily: 'TimesNewRoman',
              //fontWeight: FontWeight.bold,
              fontSize: 60.0,
              height: 1
          ),),
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Color(0xFF221f1c),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 125.0,
        loaderColor: Color(0xFFb69862),
    );
  }
}