import 'dart:async';
import 'package:limowien_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../widgets/drawerWidget.dart';


class PaymentView extends StatefulWidget {
  PaymentView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PaymentView createState() => new _PaymentView();
}

class _PaymentView extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("PaymentView"),
      ),
      body: new Text("I belong to PaymentView Page", style: TextStyle(color: Colors.white, fontSize: 18,)),
    );
  }
}