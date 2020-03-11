import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:async';

class BookView extends StatefulWidget {
  BookView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BookView createState() => new _BookView();
}

class _BookView extends State<BookView> {

  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Color(0xFF221f1c),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("BookView"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              startTimer();
            },
            child: Text("start"),
          ),
          Text("$_start")
        ],
      ),
    );
  }
}