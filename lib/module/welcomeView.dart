import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // statusbar color

import 'package:limowien_app/module/loginView.dart';
import 'package:limowien_app/module/signupView.dart';

import 'delayed_animation.dart';
import 'package:avatar_glow/avatar_glow.dart';

class WelcomeView extends StatefulWidget {
  WelcomeView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WelcomeView createState() => new _WelcomeView();
}

class _WelcomeView extends State<WelcomeView> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFF221f1c),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                DelayedAnimation(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AvatarGlow(
                          repeat: true,
                          endRadius: 100,
                          showTwoGlows: false,
                          glowColor: Color(0xFFb69862),
                          duration: const Duration(seconds: 40),
                          repeatPauseDuration: Duration(milliseconds: 500),
                          startDelay: Duration(seconds: 0),
                          child: Material(
                              elevation: 0.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Color(0xFF000000),
                                child: Image.asset('assets/images/logo.png', width: 70,),
                                radius: 60.0,
                              )
                          ),
                          animate: true,
                          curve: Curves.fastOutSlowIn
                      ),
                    ],
                  ),
                  delay: delayedAmount + 500, // Avatar
                ),
                SizedBox(height: 30.0),
                DelayedAnimation(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "limo",
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman',
                            fontSize: 44.0,
                            color: Colors.white70,
                            letterSpacing: 7
                        ),
                      ),
                      Text(
                        "wien",
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman',
                            fontSize: 44.0,
                            color: Color(0xFFb69862),
                            letterSpacing: 7
                        ),
                      ),
                    ],
                  ),
                  delay: delayedAmount + 750, // limowien
                ),
                DelayedAnimation(
                  child: Text(
                    "more than a limousine",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman',
                        fontSize: 20.0,
                        color: Colors.white70,
                        letterSpacing: 2
                    ),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(height: 130.0),
                DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new SignUpView(),));},
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 1500,
                ),
                SizedBox(height: 50.0),
                DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginView(),));},
                    child: Text(
                    "Ich habe bereits ein Konto".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0,
                        //fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  delay: delayedAmount + 1500,
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget get _animatedButtonUI => Column(
    children: <Widget>[
      Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(88.0),
          color: Color(0xFFb69862),
        ),
        child: Center(
          child: Text(
            'REGISTRIEREN',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    ],
  );
}
