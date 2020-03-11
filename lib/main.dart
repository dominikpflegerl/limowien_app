import 'package:flutter/material.dart';
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
    home: new RootPage(auth: new Auth())
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
    //
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userID = user?.uid;
          _userMail = user?.email;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userID = user.uid.toString();
        _userMail = user.email.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userID = "";
      _userMail = "";
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