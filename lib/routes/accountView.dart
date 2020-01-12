import 'dart:async';
import 'package:limowien_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../widgets/drawerWidget.dart';


class AccountView extends StatefulWidget {
  AccountView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AccountView createState() => new _AccountView();
}

class _AccountView extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("AccountView"),
      ),
      body: new Text("I belong to AccountView Page", style: TextStyle(color: Colors.white, fontSize: 18,)),
    );
  }
}