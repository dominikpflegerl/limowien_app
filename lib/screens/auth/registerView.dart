import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for coloring statusbar
import 'package:flutter/painting.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:limowien_app/screens/home.dart';

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
  TextEditingController titleInputController;
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController phoneNumberInputController;
  TextEditingController passwordInputController;
  String _errorMessage;
  bool _isLoading;

  @override
  initState() {
    firstNameInputController = new TextEditingController(text: "testVorname");
    lastNameInputController = new TextEditingController(text: "testNachname");
    emailInputController = new TextEditingController(text: "test2@neus.xyz");
    phoneNumberInputController = new TextEditingController(text: "+436769684405");
    passwordInputController = new TextEditingController(text: "Ebid5Aho54#!");

    _errorMessage = "";
    _isLoading = true;
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
  String phoneNumberValidator(String value) {
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

  int _selectedGender;
  List<DropdownMenuItem<int>> genderList = [];
  void loadGenderList() {
    genderList = [];
    genderList.add(new DropdownMenuItem(
      child: new Text('Herr', style: TextStyle(color: Colors.white)),
      value: 1,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Frau', style: TextStyle(color: Colors.white)),
      value: 2,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('keine Anrede', style: TextStyle(color: Colors.white)),
      value: 0,
    ));
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
            //pageTitle(),
            registerForm(context)
          ],
        )
      )
    );
  }

  Widget pageTitle() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return Padding(
          padding: EdgeInsets.only(top: 30, bottom: 15),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/limowien_color2_nobg.png', width: MediaQuery.of(context).size.width/1.33),
          )
      );
    } else {
      return new Container(height: 0.0);
    }
  }



  Widget registerForm(BuildContext context) {
    loadGenderList();
    double _gap = 15;

    return
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 33, right: 33),
        child: Form(
          key: _registerFormKey,
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
                 Theme(
                   data: Theme.of(context).copyWith(canvasColor: Color(0xFF221f1c)),
                   child: DropdownButtonFormField(
                     items: genderList,
                     value: _selectedGender,
                     isDense: true,
                     onChanged: (value) {setState(() => _selectedGender = value);},

                      style: TextStyle(color: Colors.white),
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
                  ),
                    SizedBox(height: _gap), // START FIRST LASTNAME
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
                        )),
                    SizedBox(height: _gap), // START PHONE
                    TextFormField(
                        controller: phoneNumberInputController,
                        //validator: phoneValidator,
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
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Das Passwort muss mindestens 8 Zeichen lang sein, sowie Sonderzeichen und Zahlen enthalten.",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: _gap),
                    Divider(color: Colors.grey),
                    SizedBox(height: _gap),
                    Text(
                      "Mit der Registrierung akzeptieren Sie die AGB, sowie unsere Datenschutzhinweise.",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
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
                            FirebaseAuth.instance
                              .createUserWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text)
                              .then((currentUser) {
                                print('------------------------');
                                print('------------------------');
                                print('------------------------');
                                print(currentUser.user.uid);
                                print(_selectedGender);
                                print(firstNameInputController);
                                print(lastNameInputController);
                                print(emailInputController);
                                print(phoneNumberInputController);
                                print('------------------------');
                                print('------------------------');
                                print('------------------------');

                                Firestore.instance
                                .collection("users")
                                .document(currentUser.user.uid)
                                .setData({
                                  "uid": currentUser.user.uid,
                                  "title": _selectedGender,
                                  "firstname": firstNameInputController.text,
                                  "lastname": lastNameInputController.text,
                                  "email": emailInputController.text,
                                  "phone": phoneNumberInputController.text,
                                })
                                .then((result) => {
                                  print('posted data'),
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(userID: currentUser.user.uid, userMail: currentUser.user.email, userFirstName: firstNameInputController.text, userLastName: lastNameInputController.text,))),
//                              firstNameInputController.clear(),
//                              lastNameInputController.clear(),
//                              emailInputController.clear(),
//                              phoneInputController.clear(),
//                              passwordInputController.clear(),
                                }).catchError((err) => print(err));
                                print('User has registerd and data pushed to firestore!');
                              }).catchError((err) => print(err));
                          }
                        },
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
                            Navigator.of(context).pushNamed('/loginView');
                          },
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
