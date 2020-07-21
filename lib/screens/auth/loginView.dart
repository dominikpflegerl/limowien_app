import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for coloring statusbar
import 'package:flutter/painting.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:limowien_app/screens/home.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

// TODO
// hide logo if keyboard is open for visibilitgiy
// implement verification
// implement password forgotten feature

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginView createState() => new _LoginView();
}

class _LoginView extends State<LoginView> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController passwordInputController;

  String _errorMessage;

  String uid;
  String email;
  int title;
  String firstname;
  String lastname;
  String phone;

  @override
  initState() {
    emailInputController = new TextEditingController(text: 'me@neus.xyz');
    passwordInputController = new TextEditingController(text: 'Ebid5Aho54#!');
    _errorMessage = "";
    super.initState();
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
          new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void login(stopLoading) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text).then((user) {
      Firestore.instance.collection('users').document(user.user.uid).get().then((result) => {
        if (result.exists) {
          uid = result.data['uid'].toString(),
          email = result.data['email'].toString(),
          title = result.data['title'],
          firstname = result.data['firstname'].toString(),
          lastname = result.data['lastname'].toString(),
          phone = result.data['phone'].toString(),

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home(
              userID: uid,
              userMail: email,
              userTitle: title,
              userFirstName: firstname,
              userLastName: lastname,
              userPhone: phone,
            ))
          ),
          print('User has been logged in!')
         } else errorAlert("User existiert nicht!")
      }).catchError((error) {errorAlert(error.message);});
    }).catchError((error) {
      ///  * `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
      ///  * `ERROR_WRONG_PASSWORD` - If the [password] is wrong.
      ///  * `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
      ///  * `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
      ///  * `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
      ///  * `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
      switch(error.code) {
        case 'ERROR_INVALID_EMAIL':
          errorAlert("E-Mail-Format ist ungültig");
          break;
        case 'ERROR_WRONG_PASSWORD':
          errorAlert("Das eingegebene Passwort ist falsch.");
          break;
        case 'ERROR_USER_NOT_FOUND':
          errorAlert("Unter dieser E-Mail Adresse wurde kein Kundenkonto gefunden.");
          break;
        case 'ERROR_USER_DISABLED':
          errorAlert("Das Benutzerkonto ist deaktiviert.");
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          errorAlert("Zu viele Anmeldungsversuche!");
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          errorAlert("Die Anmeldung ist derzeit nicht möglich. Bitte versuchen Sie es später.");
          break;
        default:
          errorAlert("Es ist ein unbekannter Fehler aufgetreten.");
      }
      stopLoading();
    });
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

  void errorAlert(String errorMessage){
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF221f1c),
        title: Text("Fehler!", style: TextStyle(color: Colors.white),),
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
            loginScreen(context)
            ],
          )
      )
    );
  }

  Widget pageTitle() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return Padding(
          padding: EdgeInsets.only(top: 40),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/limowien_color2_nobg.png', width: MediaQuery.of(context).size.width/1.33),
          )
      );
    } else {
      return new Container(height: 0.0);
    }
  }

  Widget loginScreen(BuildContext context) {
    double _gap = 20;

    return Column(
      children: <Widget>[
        Form(
          key: _loginFormKey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 33, right: 33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                      labelText: "E-Mail",
                      labelStyle: TextStyle(color: Colors.white), // style of above set
                      hasFloatingPlaceholder: true,
                    ),
                  ),
                  SizedBox(height: _gap),
                  TextFormField(
                    controller: passwordInputController,
                    validator: passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    //style
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFb69862),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFb69862))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusColor: Colors.white,

                      labelText: "Passwort",
                      labelStyle: TextStyle(color: Colors.white), // style of above set
                      hasFloatingPlaceholder: true,
                    ),
                  ),
                  SizedBox(height: _gap),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text("Passwort vergessen?", style: TextStyle(color: Colors.white),),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: ArgonButton(
                          height: 40,
                          width: 100,
                          borderRadius: 5.0,
                          roundLoadingShape: false,
                          color: Color(0xFFb69862),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                            ),
                          ),
                          loader: Container(
                            padding: EdgeInsets.all(0),
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          onTap: (startLoading, stopLoading, btnState) {
                            if (_loginFormKey.currentState.validate() && btnState == ButtonState.Idle) {
                              startLoading();
                              login(stopLoading);
                            } else {
                              stopLoading();
                            }
                          },
                        ),
//                        child: FlatButton(
//                          child: Text("LOGIN", style: TextStyle(fontSize: 14)),
//                          //child: Center(child: CircularProgressIndicator()),
//                          color: Color(0xFFb69862),
//                          textColor: Colors.white,
//                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                          onPressed: () {login();},
//                        ),
                      )
                    ],
                  ),
                  SizedBox(height: _gap),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kein Konto?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      FlatButton(
                        onPressed: () {Navigator.of(context).pushNamed('/registerView');},
                        textColor: Colors.white,
                        child: Text("Registrieren"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}