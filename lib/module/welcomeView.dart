import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // statusbar color
import 'delayed_animation.dart';

import 'loginView.dart';
import 'registerView.dart';

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
                Column(
                  children: <Widget>[
                    AvatarGlow(
                      repeat: true,
                      endRadius: 120,
                      showTwoGlows: true,
                      glowColor: Color(0xFFb69862),
                      duration: Duration(seconds: 4), // AVD: 4 -> 4 sec, Mi A2: 40 -> 4 sec ??? NIGGA?
                      repeatPauseDuration: Duration(seconds: 2),
                      startDelay: Duration(seconds: 2),
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
                      curve: Curves.fastOutSlowIn,
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
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
                            color: Color(0xFFE2E0E1FF),
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
                  delay: delayedAmount + 1000,
                ),
                DelayedAnimation(
                  child: Text(
                    "more than a limousine",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman',
                        fontSize: 20.0,
                        color: Color(0xFFE2E0E1FF),
                        letterSpacing: 2
                    ),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(height: 120.0),
                DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new RegisterView(),));},
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(height: 50.0,),
                DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginView(),));},
                    child: Text(
                    "Ich habe bereits ein Konto".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0,
                        //fontWeight: FontWeight.bold,
                        color: Color(0xFFE2E0E1FF)),
                    ),
                  ),
                  delay: delayedAmount + 2000,
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
              color: Color(0xFFE2E0E1FF),
            ),
          ),
        ),
      ),
    ],
  );
}
