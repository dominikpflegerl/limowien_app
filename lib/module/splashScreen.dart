import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart'; // statusbar color


import 'package:splashscreen/splashscreen.dart';

import 'package:limowien_app/module/welcomeView.dart';

class AppLaunch extends StatefulWidget {
  @override
  AppSplashScreen createState() => new AppSplashScreen();
}

class AppSplashScreen extends State<AppLaunch> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new WelcomeView(),
        title: new Text('limowien',
          style: new TextStyle(
              color: Color(0xFFdfddde),
              fontFamily: 'TimesNewRoman',
              //fontWeight: FontWeight.bold,
              fontSize: 50.0,
              height: 2,
          ),),
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Color(0xFF221f1c),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 80.0,
        loaderColor: Color(0xFFE2E0E1FF),
    );
  }
}