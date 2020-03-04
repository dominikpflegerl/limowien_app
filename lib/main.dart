import 'package:flutter/material.dart';
// home
import 'package:limowien_app/module/welcomeView.dart';
import 'package:limowien_app/home.dart';
import 'package:limowien_app/routes/aboutView.dart';
import 'package:limowien_app/routes/accountView.dart';
import 'package:limowien_app/routes/bookView.dart';
import 'package:limowien_app/routes/faqView.dart';
import 'package:limowien_app/routes/fleetView.dart';
import 'package:limowien_app/routes/historyView.dart';
import 'package:limowien_app/routes/paymentView.dart';
import 'package:limowien_app/routes/settingsView.dart';
// AUTH
import 'package:limowien_app/services/auth.dart';
import 'package:limowien_app/module/loginView.dart';
import 'package:limowien_app/module/signupView.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder> {
      // Launch Views ?
      '/welcomeView': (BuildContext context) => new WelcomeView(),
      '/loginView': (BuildContext context) => new LoginView(),
      '/signupView' : (BuildContext context) => new SignUpView(),
      // Home
      '/homeView' : (BuildContext context) => new Home(),
      // Module
      '/bookingView' : (BuildContext context) => new BookView(),
      '/accountView' : (BuildContext context) => new AccountView(),
      '/paymentView' : (BuildContext context) => new PaymentView(),
      '/historyView' : (BuildContext context) => new HistoryView(),
      '/fleetView' : (BuildContext context) => new FleetView(),
      '/settingsView' : (BuildContext context) => new SettingsView(),
      '/aboutView' : (BuildContext context) => new AboutView(),
      '/faqView' : (BuildContext context) => new FAQView(),
    },
    home: WelcomeView(),
  ));
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
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginView(
//          auth: widget.auth,
//          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new Home(
//            userId: _userId,
//            auth: widget.auth,
//            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}