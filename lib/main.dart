import 'package:flutter/material.dart';
// home
import 'package:limowien_app/home.dart';
import 'package:limowien_app/module/welcomeView.dart';
import 'package:limowien_app/routes/aboutView.dart';
import 'package:limowien_app/routes/accountView.dart';
import 'package:limowien_app/routes/bookView.dart';
import 'package:limowien_app/routes/faqView.dart';
import 'package:limowien_app/routes/fleetView.dart';
import 'package:limowien_app/routes/historyView.dart';
import 'package:limowien_app/routes/paymentView.dart';
import 'package:limowien_app/routes/settingsView.dart';
// AUTH
import 'package:limowien_app/module/loginView.dart';
import 'package:limowien_app/module/registerView.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder> {
      // Launch Views ?
      '/welcomeView': (BuildContext context) => new WelcomeView(),
      '/loginView': (BuildContext context) => new LoginView(),
      '/registerView' : (BuildContext context) => new RegisterView(),
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