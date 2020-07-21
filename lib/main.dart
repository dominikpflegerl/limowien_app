import 'dart:io';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
// home
import 'package:limowien_app/screens/home.dart';
import 'package:limowien_app/views/aboutView.dart';
import 'package:limowien_app/views/accountView.dart';
import 'package:limowien_app/screens/order.dart';
import 'package:limowien_app/views/faqView.dart';
import 'package:limowien_app/views/fleetView.dart';
import 'package:limowien_app/views/historyView.dart';
import 'package:limowien_app/views/paymentView.dart';
import 'package:limowien_app/views/settingsView.dart';
// AUTH
import 'package:limowien_app/services/firebase_auth.dart';
import 'package:limowien_app/screens/welcome.dart';
import 'package:limowien_app/screens/auth/loginView.dart';
import 'package:limowien_app/screens/auth/registerView.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder> {
      '/home' : (BuildContext context) => new Home(),
      // Auth Views
      '/welcomeView': (BuildContext context) => new WelcomeView(),
      '/loginView': (BuildContext context) => new LoginView(),
      '/registerView' : (BuildContext context) => new RegisterView(),
      // Views for Home & NavigationDrawer
      '/bookView' : (BuildContext context) => new BookView(),
      '/accountView' : (BuildContext context) => new AccountView(),
      '/paymentView' : (BuildContext context) => new PaymentView(),
      '/historyView' : (BuildContext context) => new HistoryView(),
      '/fleetView' : (BuildContext context) => new FleetView(),
      '/settingsView' : (BuildContext context) => new SettingsView(),
      '/aboutView' : (BuildContext context) => new AboutView(),
      '/faqView' : (BuildContext context) => new FAQView(),
    },
    theme: ThemeData(
      textSelectionHandleColor: Color(0xFFb69862)
    ),
    //home: new Home(userID: "1", userMail: "test@test", userTitle: 1, userFirstName: "Dominik", userLastName: "Pflegerl") // use it to skip auth
    //home: new RootPage(auth: new Auth())
    home: new LoginView(),
  )
  );
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userID = "";
  String _userMail = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userID = user?.uid;
          _userMail = user?.email;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
    sleep(Duration(seconds: 2));
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userID = "";
      _userMail = "";
    });
  }

  Widget buildWaitingScreen() {
    return SplashScreen(
      seconds: 100,
      title: new Text('limowien',
        style: new TextStyle(
          color: Color(0xFFdfddde),
          fontFamily: 'TimesNewRoman',
          //fontWeight: FontWeight.bold,
          fontSize: 50.0,
          height: 2,
        ),
      ),
      image: new Image.asset('assets/images/logo.png'),
      backgroundColor: Color(0xFF221f1c),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 80.0,
      loaderColor: Color(0xFFE2E0E1FF),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        print('AuthStatus.NOT_DETERMINED');
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        print('AuthStatus.NOT_LOGGED_IN');
        return new WelcomeView();
        break;
      case AuthStatus.LOGGED_IN:
        if (_userID.length > 0 && _userID != null) {
          print('AuthStatus.LOGGED_IN');
          return new Home(
            userID: _userID,
            userMail: _userMail,
            userTitle: 2,
            userFirstName: " ",
            userLastName: "main.dart",
            userPhone: "+436769684405",
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          print('AuthStatus.LOGGED_IN');
          return buildWaitingScreen();
        break;
      default:
        print('AuthStatus.NOT_DETERMINED_LOOP');
        return buildWaitingScreen();
    }
  }
}