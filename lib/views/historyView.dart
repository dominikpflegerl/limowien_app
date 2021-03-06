import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HistoryView createState() => new _HistoryView();
}

class _HistoryView extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("HistoryView"),
      ),
      body: new Text("I belong to HistoryView Page", style: TextStyle(color: Colors.white, fontSize: 18,)),
    );
  }
}