import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for coloring statusbar
import 'package:flutter/painting.dart';
import 'loginView.dart';
import 'package:limowien_app/home.dart';

// TODO
// hide logo if keyboard is open for visibility
// implement FireBase Auth
// implement verification
// implement password forgotten feature

class  EmptyAppBar  extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}

class RegisterView extends StatefulWidget {
  RegisterView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterView createState() => new _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xFF221f1c),
    ));

    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: true,
      appBar:  EmptyAppBar (),
      backgroundColor: Color(0xFF221f1c),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            pageTitle(),
            registerScreen(context)
          ],
        )
      )
    );
  }

  Widget pageTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset('assets/images/limowien_color2_nobg.png', width: MediaQuery.of(context).size.width/1.33),
      )
    );
  }

  Widget registerScreen(BuildContext context) {
    bool _value1 = false;
    bool _value2 = false;

    //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
    void _value1Changed(bool value) => setState(() => _value1 = value);
    void _value2Changed(bool value) => setState(() => _value2 = value);

    String selected;
    double _gap = 15;

    return Column(
      children: <Widget>[
        Container(
          //padding: EdgeInsets.only(top: 200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Registrierung",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: _gap),
                DropdownButtonFormField<String>(

                  value: selected,
                  selectedItemBuilder: (context) {
                    return [Text("xyz")];
                  },
                  items: ["Herr", "Frau", "sonstiges"]
                      .map((label) => DropdownMenuItem(
                    child: Text(label),
                    value: label,
                  ))
                      .toList(),
                  onChanged: (value) {setState(() => selected = value);},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    labelText: "Anrede",
                    labelStyle: TextStyle(color: Colors.white), // style of above set
                    hasFloatingPlaceholder: true,
                  )
                ),
                SizedBox(height: _gap),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFFb69862),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                            labelText: "Vorname",
                            labelStyle: TextStyle(color: Colors.white), // style of above set
                            hasFloatingPlaceholder: true,
                          )
                      ),
                    ),
                    SizedBox(width: _gap),
                    Flexible(
                      child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFFb69862),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                            labelText: "Nachname",
                            labelStyle: TextStyle(color: Colors.white), // style of above set
                            hasFloatingPlaceholder: true,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _gap),
                TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFb69862),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                      labelText: "E-Mail",
                      labelStyle: TextStyle(color: Colors.white), // style of above set
                      hasFloatingPlaceholder: true,
                    )
                ),
                SizedBox(height: _gap),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFFb69862),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                            labelText: "+43",
                            labelStyle: TextStyle(color: Colors.white), // style of above set
                            hasFloatingPlaceholder: true,
                          )
                      ),
                    ),
                    SizedBox(width: _gap),
                    Flexible(
                      flex: 3,
                      child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFFb69862),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                            labelText: "Telefonnummer",
                            labelStyle: TextStyle(color: Colors.white), // style of above set
                            hasFloatingPlaceholder: true,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _gap),
                TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFb69862),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                      labelText: "Passwort",
                      labelStyle: TextStyle(color: Colors.white), // style of above set
                      hasFloatingPlaceholder: true,
                    )
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Das Passwort muss mindestens 12 Zeichen lang sein, sowie Sonderzeichen und Zahlen enthalten.",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity, // match_parent
                  child: FlatButton(
                    child: Text("ABSENDEN", style: TextStyle(fontSize: 18)),
                    color: Color(0xFFb69862),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    onPressed: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Home(),));},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Mit der Registrierung akzeptieren Sie die AGB, sowie unsere Datenschutzhinweise.",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Divider(color: Colors.grey,)
              ],
            ),
          ),
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sie haben bereits ein Konto?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginView(),));},
              textColor: Colors.white,
              child: Text("Login"),
            )
          ],
        ),
      ],
    );
  }
}