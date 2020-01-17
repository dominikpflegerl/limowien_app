import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../routes/fleetView.dart';
import '../routes/historyView.dart';
import '../routes/accountView.dart';
import '../routes/paymentView.dart';
import '../routes/settingsView.dart';
//import '../routes/logoutView.dart';
import '../routes/aboutView.dart';
import '../module/loginView.dart';


class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: Container(
          color: Color(0xFF221f1c),
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Dominik"),
                accountEmail: new Text("dominik@limowien.com"),
                decoration: new BoxDecoration(
                  color: Color(0xFFb69862),
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/lake.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/46.jpg")),
              ),
              // Menu Structure
              new ListTile(
                leading: new Icon(MdiIcons.history,color: Colors.white),
                title: new Text("Deine Fahrten", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new HistoryView(),));},
              ),
              new ListTile(
                leading: new Icon(MdiIcons.history,color: Colors.white),
                title: new Text("LoginView", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginView(),));},
              ),
              new ListTile(
                leading: new Icon(MdiIcons.carMultiple,color: Colors.white),
                title: new Text("Flottenübersicht", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new FleetView(),));},
              ),
              new Divider(color: Colors.white),
              new ListTile(
                leading: new Icon(MdiIcons.account,color: Colors.white),
                title: new Text("Konto", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new AccountView(),));},
              ),
              new ListTile(
                leading: new Icon(MdiIcons.cash,color: Colors.white),
                title: new Text("Bezahlung", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PaymentView(),));},
              ),
              new ListTile(
                leading: new Icon(MdiIcons.settings,color: Colors.white),
                title: new Text("Einstellungen", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new SettingsView(),));},
              ),
              new Divider(color: Colors.white),
              new ListTile(
                leading: new Icon(MdiIcons.logout,color: Colors.white),
                title: new Text("Abmelden", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginView(),));},
              ),              new Divider(color: Colors.white),
              new ListTile(
                leading: new Icon(MdiIcons.information,color: Colors.white),
                title: new Text("About", style: new TextStyle(color: Colors.white),),
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new AboutView(),));},
              ),
              new ListTile(
                title: new Text("© Limowien GmbH", style: new TextStyle(color: Colors.white, fontSize: 9),),
              ),
            ],
          ),
        )
    );
  }
}