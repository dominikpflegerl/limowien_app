import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:limowien_app/screens/home.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key key, this.userID, this.userMail, this.userTitle, this.userFirstName, this.userLastName, this.userPhone}) : super(key: key);
  final String userID;
  final String userMail;
  final int userTitle;
  final String userFirstName;
  final String userLastName;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: Container(
          color: Color(0xFFb69862),
          child: new ListView(
            padding: EdgeInsets.only(bottom: 0),
            children: <Widget>[
              new UserAccountsDrawerHeader(
                decoration: new BoxDecoration(color: Color(0xFFb69862)),
                currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/46.jpg")),
                accountName: new Text(userFirstName + " " + userLastName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                accountEmail: new Text(userMail + " | " + userPhone, style: TextStyle(fontSize: 15)),
              ),
              // Menu Structure
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 7),
                    height: MediaQuery.of(context).size.height,
                    color: Color(0xFF221f1c),
                    child: Column(
                      children: <Widget>[
                        new ListTile(
                          leading: new Icon(MdiIcons.history,color: Colors.white),
                          title: new Text("Deine Fahrten", style: new TextStyle(color: Colors.white),),
                          onTap: () {Navigator.pop(context); Navigator.pushNamed(context, '/historyView');},
                        ),
                        new ListTile(
                          leading: new Icon(MdiIcons.carMultiple,color: Colors.white),
                          title: new Text("Flottenübersicht", style: new TextStyle(color: Colors.white),),
                          onTap: () {Navigator.pop(context); Navigator.pushNamed(context, '/fleetView');},
                        ),
                        new Divider(color: Colors.white),
                        new ListTile(
                          leading: new Icon(MdiIcons.account,color: Colors.white),
                          title: new Text("Konto", style: new TextStyle(color: Colors.white),),
                          onTap: () {Navigator.pop(context); Navigator.pushNamed(context, '/accountView');},
                        ),
                        new ListTile(
                          leading: new Icon(MdiIcons.cash,color: Colors.white),
                          title: new Text("Bezahlung", style: new TextStyle(color: Colors.white),),
                          onTap: () {Navigator.pop(context); Navigator.pushNamed(context, '/paymentView');},
                        ),
                        new ListTile(
                          leading: new Icon(MdiIcons.settings,color: Colors.white),
                          title: new Text("Einstellungen", style: new TextStyle(color: Colors.white),),
                          onTap: () {Navigator.pop(context); Navigator.pushNamed(context, '/settingsView');},
                        ),
                        new Divider(color: Colors.white),






                        new ListTile(
                          leading: new Icon(MdiIcons.logout,color: Colors.white),
                          title: new Text("Abmelden", style: new TextStyle(color: Colors.white),),
                          onTap: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut().then((res) {
                              Navigator.pop(context); Navigator.of(context).pushNamedAndRemoveUntil('/welcomeView', (Route<dynamic> route) => false);
                              print('User has been logged out!');
                            });
                          },
                        ),













                        new Divider(color: Colors.white),
                        new ListTile(
                          leading: new Icon(MdiIcons.information,color: Colors.white),
                          title: new Text("Hilfe & Kontakt", style: new TextStyle(color: Colors.white),),
                          onTap: () {Navigator.pop(context); Navigator.pushNamed(context, '/aboutView');},
                        ),
                        new ListTile(
                          title: new Text("© Limowien GmbH", style: new TextStyle(color: Colors.white, fontSize: 9),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}