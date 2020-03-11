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
import 'package:firebase_auth/firebase_auth.dart';
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
    home: Auth(),
  ));
}

class Auth extends StatefulWidget{
  @override
  _Auth createState() => new _Auth();
}

class _Auth extends State<Auth> {

  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
      if (currentUser == null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/welcomeView', (Route<dynamic> route) => false),
        print('You are *NOT* logged in, navigate to welcome'),
        print('You are *NOT* logged in, navigate to welcome'),
        print('You are *NOT* logged in, navigate to welcome'),
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false),
        print('You are logged in, navigate to home'),
        print('You are logged in, navigate to home'),
        print('You are logged in, navigate to home'),
      }
    })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}