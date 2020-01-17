import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingsView createState() => new _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("SettingsView"),
      ),
      body: new Text("I belong to SettingsView Page", style: TextStyle(color: Colors.white, fontSize: 18,)),
    );
  }
}