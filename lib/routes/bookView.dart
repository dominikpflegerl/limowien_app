import 'dart:async';
import 'package:limowien_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../widgets/drawerWidget.dart';


class BookView extends StatefulWidget {
  BookView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BookView createState() => new _BookView();
}

class _BookView extends State<BookView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("BookView"),
      ),
      body: new Text("I belong to BookView Page", style: TextStyle(color: Colors.white, fontSize: 18,)),
    );
  }
}