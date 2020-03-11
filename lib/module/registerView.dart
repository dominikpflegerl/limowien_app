import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for coloring statusbar
import 'package:flutter/painting.dart';

// TODO
// hide logo if keyboard is open for visibility
// implement FireBase Auth
// implement verification
// implement password forgotten feature

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
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

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController phoneInputController;
  TextEditingController passwordInputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    phoneInputController = new TextEditingController();
    passwordInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'E-Mail-Format ist ungültig';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return 'Das Passwort muss länger als 8 Zeichen sein.';
    } else {
      return null;
    }
  }

  String phoneValidator(String value) {
    if (value.length < 8) {
      return 'Die Nummer muss länger als 8 Zeichen sein.';
    } else {
      return null;
    }
  }

  String inputValidator(String value) {
    if (value.length < 8) {
      return 'Die Eingabe ist ungultüg.';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xFF221f1c),
    ));

    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        primary: true,
        appBar: EmptyAppBar(),
        backgroundColor: Color(0xFF221f1c),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[pageTitle(), registerScreen(context)],
        )));
  }

  Widget pageTitle() {
    return Padding(
        padding: EdgeInsets.only(top: 40),
        child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset('assets/images/limowien_color2_nobg.png',
              width: MediaQuery.of(context).size.width / 1.33),
        ));
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
        Form(
          key: _registerFormKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 33, right: 33),
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
//                SizedBox(height: _gap),
//                DropdownButtonFormField<String>(
//
//                  value: selected,
//                  selectedItemBuilder: (context) {
//                    return [Text("xyz")];
//                  },
//                  items: ["Herr", "Frau", "sonstiges"]
//                      .map((label) => DropdownMenuItem(
//                    child: Text(label),
//                    value: label,
//                  ))
//                      .toList(),
//                  onChanged: (value) {setState(() => selected = value);},
//                  decoration: InputDecoration(
//                    border: OutlineInputBorder(),
//                    isDense: true,
//                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
//                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//                    labelText: "Anrede",
//                    labelStyle: TextStyle(color: Colors.white), // style of above set
//                    hasFloatingPlaceholder: true,
//                  )
//                ),
                SizedBox(height: _gap),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                          controller: firstNameInputController,
                          validator: inputValidator,
                          //style
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFFb69862),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFb69862))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Vorname",
                            labelStyle: TextStyle(color: Colors.white),
                            hasFloatingPlaceholder: true,
                          )),
                    ),
                    SizedBox(width: _gap),
                    Flexible(
                      child: TextFormField(
                          controller: lastNameInputController,
                          validator: inputValidator,
                          //style
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFFb69862),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFb69862))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Nachname",
                            labelStyle: TextStyle(color: Colors.white),
                            hasFloatingPlaceholder: true,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: _gap),
                TextFormField(
                    controller: emailInputController,
                    validator: emailValidator,
                    keyboardType: TextInputType.emailAddress,
                    //style
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFb69862),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "E-Mail",
                      labelStyle: TextStyle(color: Colors.white),
                      hasFloatingPlaceholder: true,
                    )),
                SizedBox(height: _gap),
                Row(
                  children: <Widget>[
//                    Flexible(
//                      child: TextFormField(
//                          style: TextStyle(color: Colors.white),
//                          cursorColor: Color(0xFFb69862),
//                          decoration: InputDecoration(
//                            border: OutlineInputBorder(),
//                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
//                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//
//                            labelText: "+43",
//                            labelStyle: TextStyle(color: Colors.white), // style of above set
//                            hasFloatingPlaceholder: true,
//                          )
//                      ),
//                    ),
//                    SizedBox(width: _gap),
                    Flexible(
                      flex: 3,
                      child: TextFormField(
                          controller: phoneInputController,
                          validator: phoneValidator,
                          keyboardType: TextInputType.phone,
                          //style
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFFb69862),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFb69862))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Telefonnummer",
                            labelStyle: TextStyle(color: Colors.white),
                            hasFloatingPlaceholder: true,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: _gap),
                TextFormField(
                    controller: passwordInputController,
                    validator: passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    //style
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFb69862),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Passwort",
                      labelStyle: TextStyle(color: Colors.white),
                      hasFloatingPlaceholder: true,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Das Passwort muss mindestens 8 Zeichen lang sein, sowie Sonderzeichen und Zahlen enthalten.",
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
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/homeView', (Route<dynamic> route) => false);
                    },
                    //onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home(),));},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Mit der Registrierung akzeptieren Sie die AGB, sowie unsere Datenschutzhinweise.",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.grey,
                )
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
              onPressed: () {
                Navigator.of(context).pushNamed('/loginView');
              },
              textColor: Colors.white,
              child: Text("Login"),
            )
          ],
        ),
      ],
    );
  }
}
