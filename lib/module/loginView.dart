import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for coloring statusbar
import 'package:flutter/painting.dart';
import 'signupView.dart';
import 'package:limowien_app/home.dart';

import 'package:firebase_auth/firebase_auth.dart';

// TODO
// hide logo if keyboard is open for visibilitgiy
// implement FireBase Auth
// implement verification
// implement password forgotten feature

class  EmptyAppBar  extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);
  final String title;
  final _formKey = new GlobalKey<FormState>();

  @override
  _LoginView createState() => new _LoginView();
}

class _LoginView extends State<LoginView> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xFF221f1c),
    ));

    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: true,
      appBar:  EmptyAppBar (),
      backgroundColor: Color(0xFF221f1c),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            pageTitle(),
            loginScreen(context)
            ],
          )
      )
    );
  }

  Widget pageTitle() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset('assets/images/limowien_color2_nobg.png', width: MediaQuery.of(context).size.width/1.33),
        )
    );
  }

  Widget loginScreen(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    //onSaved: (value) => _email = value.trim(),

                    style: TextStyle(color: Colors.white),
                    autocorrect: true,
                    cursorColor: Color(0xFFb69862),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                      labelText: "E-Mail",
                      labelStyle: TextStyle(color: Colors.white), // style of above set
                      hasFloatingPlaceholder: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                    //onSaved: (value) => _password = value.trim(),

                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFb69862),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusColor: Colors.white,

                      labelText: "Passwort",
                      labelStyle: TextStyle(color: Colors.white), // style of above set
                      hasFloatingPlaceholder: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text("Passwort vergessen?", style: TextStyle(color: Colors.white),),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("LOGIN", style: TextStyle(fontSize: 18)),
                        color: Color(0xFFb69862),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(left: 40, right: 40, top: 13, bottom: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed: () {Navigator.of(context).pushNamedAndRemoveUntil('/homeView', (Route<dynamic> route) => false);},
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kein Konto?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      FlatButton(
                        onPressed: () {Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new SignUpView(),));},
                        textColor: Colors.white,
                        child: Text("Registrieren"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}