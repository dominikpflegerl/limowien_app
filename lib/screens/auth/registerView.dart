import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for coloring statusbar
import 'package:flutter/painting.dart';
import 'dart:async';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:limowien_app/screens/home.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splashscreen/splashscreen.dart';

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
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController phoneNumberInputController;
  TextEditingController passwordInputController;

  bool _isLoading;

  @override
  initState() {
    firstNameInputController = new TextEditingController(text: "Dominik");
    lastNameInputController = new TextEditingController(text: "Pflegerl");
    emailInputController = new TextEditingController(text: "auth12345@neus.xyz");
    phoneNumberInputController = new TextEditingController(text: "+436769684405");
    passwordInputController = new TextEditingController(text: "Ebid5Aho54#!");

    _isLoading = false;
    super.initState();
  }

  String titleValidator(int value) {
    if (value == null) {
      return 'Bitte wählen Sie eine Anrede aus.';
    } else {
      return null;
    }
  }
  String inputValidator(String value) {
    if (value.length < 3) {
      return 'Eingabe ist ungultüg.';
    } else {
      return null;
    }
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
  String phoneNumberValidator(String value) {
    Pattern pattern =
        r'^[+]((\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,6})|(\(?\d{2,6}\)?))(-| )?(\d{3,4})(-| )?(\d{4})(( x| ext)\d{1,5}){0,1}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Telefonnummer ist ungültig';
    } else {
      return null;
    }
  }
  String passwordValidator(String value) {
    Pattern pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!"§$%&/()=?{[\]}\\@€*+~#,.\-;:_´`<>|µ^°])[A-Za-z\d!"§$%&/()=?{[\]}\\@€*+~#,.\-;:_´`<>|µ^°]{8,64}$'; // without '
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Das Passwort muss mindestens 8 Zeichen lang sein, sowie Sonderzeichen und Zahlen enthalten.';
    } else {
      return null;
    }
  }

  int _selectedTitle = 1;
  List<DropdownMenuItem<int>> titleList = [];
  void loadTitleList() {
    titleList = [];
    titleList.add(new DropdownMenuItem(
      child: new Text('Herr', style: TextStyle(color: Colors.white, fontSize: 16)),
      value: 1,
    ));
    titleList.add(new DropdownMenuItem(
      child: new Text('Frau', style: TextStyle(color: Colors.white, fontSize: 16)),
      value: 2,
    ));
    titleList.add(new DropdownMenuItem(
      child: new Text('keine Anrede', style: TextStyle(color: Colors.white, fontSize: 16)),
      value: 0,
    ));
  }
  void errorAlert(String errorMessage){
    showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF221f1c),
        title: Text("Fehler:", style: TextStyle(color: Colors.white),),
        content: Text(errorMessage, style: TextStyle(color: Colors.white),),
        actions: [
          FlatButton(
            child: Text("OK", style: TextStyle(color: Colors.white)),
            onPressed: () {Navigator.of(context).pop();},
            padding: EdgeInsets.only(right: 10),
          )
        ],
        elevation: 0,
        titlePadding: EdgeInsets.only(left: 20, top: 15),
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
      );
    });
  }

  void progressAlert(){
    if(_isLoading) {
      showDialog(context: context,builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF221f1c),
          content: Text("WHOA", style: TextStyle(color: Colors.white),),
          elevation: 0,
          titlePadding: EdgeInsets.only(left: 20, top: 15),
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
        );
      });
    } else {
      Container(width: 0, height: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xFF221f1c),
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      primary: true,
      appBar: EmptyAppBar(),
      backgroundColor: Color(0xFF221f1c),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            pageTitle(),
            registerForm(context),
          ],
        )
      )
    );
  }

  Widget pageTitle() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10, left: 33, right: 33),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/limowien_color2_nobg.png', width: MediaQuery.of(context).size.width/1),
          )
      );
    } else {
      return new Container(height: 0.0);
    }
  }

  Widget registerForm(BuildContext context) {
    loadTitleList();
    double _gap = 15;
    double _contentPaddingVertical = 15;
    double _contentPaddingHorizontal = 15;

    return
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 33, right: 33),
        child: Form(
          key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: _gap), // START TITLE
                Theme(
                  data: Theme.of(context).copyWith(canvasColor: Color(0xFF221f1c)),
                  child: DropdownButtonFormField(
                      items: titleList,
                      value: _selectedTitle,
                      validator: titleValidator,
                      isDense: true,
                      onChanged: (value) {setState(() => _selectedTitle = value);},
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        labelText: "Anrede",
                        labelStyle: TextStyle(color: Colors.white), // style of above set
                        hasFloatingPlaceholder: true,
                        contentPadding: new EdgeInsets.symmetric(vertical: _contentPaddingVertical-2.5, horizontal: _contentPaddingHorizontal),
                      )
                  ),
                ),
                SizedBox(height: _gap), // START FIRST LASTNAME
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                          controller: firstNameInputController,
                          validator: inputValidator,
                          //style
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
                            contentPadding: new EdgeInsets.symmetric(vertical: _contentPaddingVertical, horizontal: _contentPaddingHorizontal),
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
                            contentPadding: new EdgeInsets.symmetric(vertical: _contentPaddingVertical, horizontal: _contentPaddingHorizontal),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: _gap), // START E-MAIL
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
                      contentPadding: new EdgeInsets.symmetric(vertical: _contentPaddingVertical, horizontal: _contentPaddingHorizontal),
                    )),
                SizedBox(height: _gap), // START PHONE
                TextFormField(
                    controller: phoneNumberInputController,
                    validator: phoneNumberValidator,
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
                      contentPadding: new EdgeInsets.symmetric(vertical: _contentPaddingVertical, horizontal: _contentPaddingHorizontal),
                    )
                ),
                SizedBox(height: _gap), // START PASSWORD
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
                      contentPadding: new EdgeInsets.symmetric(vertical: _contentPaddingVertical, horizontal: _contentPaddingHorizontal),
                    )),
                SizedBox(height: 10),
                Text(
                  "Mit der Registrierung akzeptieren Sie die AGB, sowie unsere Datenschutzhinweise.",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: _gap),
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
                      if (_registerFormKey.currentState.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text).then((currentUser) {
                          print('------------------------');
                          print('------------------------');
                          print('----init FirebaseAuth---');
                          print('------------------------');
                          print('------------------------');
                          print(currentUser.user.uid);
                          print(_selectedTitle);
                          print(firstNameInputController.text);
                          print(lastNameInputController.text);
                          print(emailInputController.text);
                          print(phoneNumberInputController.text);
                          print('------------------------');
                          print('------------------------');
                          print('------------------------');
                          print('----init Firestore------');
                          Firestore.instance.collection("users").document(currentUser.user.uid).setData({
                            "uid": currentUser.user.uid,
                            "title": _selectedTitle,
                            "firstname": firstNameInputController.text,
                            "lastname": lastNameInputController.text,
                            "email": emailInputController.text,
                            "phone": phoneNumberInputController.text,
                          }).then((result) => {
                            print('------------------------'),
                            print('----push to home--------'),
                            print('------------------------'),
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
                                Home(
                                    userID: currentUser.user.uid,
                                    userMail: currentUser.user.email,
                                    userTitle: _selectedTitle,
                                    userFirstName: firstNameInputController.text,
                                    userLastName: lastNameInputController.text,
                                    userPhone: phoneNumberInputController.text
                                )), (Route<dynamic> route) => false),
                          }).catchError((err) {
                            setState(() {
                              _isLoading = false;
                            });
                            errorAlert(err.message);
                          });
                        }).catchError((error) {
                          switch(error.code) {
                            case 'ERROR_EMAIL_ALREADY_IN_USE':
                              errorAlert("Die E-Mail-Adresse ist bereits vorhanden.");
                              break;
                            case 'ERROR_INVALID_EMAIL':
                              errorAlert("Die E-Mail-Adresse ist ungültig.");
                              break;
                            case 'ERROR_OPERATION_NOT_ALLOWED':
                              errorAlert("Die Registrierung mit E-Mail und Passwort ist nicht aktiviert.");
                              break;
                            case 'ERROR_WEAK_PASSWORD':
                              errorAlert("Das Passwort muss mindestens 8 Zeichen lang sein, sowie Sonderzeichen und Zahlen enthalten.");
                              break;
                            default:
                              errorAlert("Es ist ein undefinierter Fehler aufgetreten.");
                          }
                        }
                        );
                      }},
                    //onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home(),));},
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
                        Navigator.of(context).pushNamed('/loginView');},
                      textColor: Colors.white,
                      child: Text("Login"),
                    )
                  ],
                ),
              ],
            ),
        ),
      );
  }
}
