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
import 'package:limowien_app/screens/welcome.dart';
import 'package:limowien_app/screens/auth/loginView.dart';
import 'package:limowien_app/screens/auth/registerView.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder> {
      // Launch Views ?
      '/welcomeView': (BuildContext context) => new WelcomeView(),
      '/loginView': (BuildContext context) => new LoginView(),
      '/registerView' : (BuildContext context) => new RegisterView(),
      // Home
      '/home' : (BuildContext context) => new Home(),
      // Module
      '/bookView' : (BuildContext context) => new BookView(),
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