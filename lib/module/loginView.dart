import 'package:flutter/material.dart';
import 'delayed_animation.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:limowien_app/main.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginView createState() => new _LoginView();
}

class _LoginView extends State<LoginView> with SingleTickerProviderStateMixin {
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
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFFb69862),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 120,
                      duration: Duration(seconds: 5),
                      glowColor: Colors.white24,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 0),
                      startDelay: Duration(seconds: 0),
                      child: Material(
                          elevation: 10,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF221f1c),
                            child: Image.asset('assets/images/logo.png', width: 70,),
                            radius: 60.0,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                DelayedAnimation(
                  child: Text(
                    "Limowien",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27.0,
                        color: Colors.white),
                  ),
                  delay: delayedAmount + 1000,
                ),
                DelayedAnimation(
                  child: Text(
                    "more than a limosine",
                    style: TextStyle(
                       // fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.white),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(height: 150.0),
                DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Home(),));},
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
                    onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Home(),));},
                    child: Text(
                    "Ich habe bereits ein Konto".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0,
                        //fontWeight: FontWeight.bold,
                        color: color),
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
          color: Color(0xFF221f1c),
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
