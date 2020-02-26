import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';

class AboutView extends StatefulWidget {
  AboutView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AboutView createState() => new _AboutView();
}

class _AboutView extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      //backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("Help & About"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        children: <Widget>[
          Card(
            color: Color(0xFF221f1c),
            elevation: 0,
            child: ListTile(
              onTap: () => print("tapped faq"),
              leading: new Icon(MdiIcons.frequentlyAskedQuestions ,color: Colors.white),
              title: Text('FAQ', style: new TextStyle(color: Colors.white)),
            ),
          ),
          Card(
            color: Color(0xFF221f1c),
            elevation: 0,
            child: ListTile(
              onTap: () => print("tapped contact"),
              leading: new Icon(MdiIcons.contactMail ,color: Colors.white),
              title: Text('Kontakt', style: new TextStyle(color: Colors.white)),
            ),
          ),
          Card(
            color: Color(0xFF221f1c),
            elevation: 0,
            child: ListTile(
              onTap: () => print("tapped legal"),
              leading: new Icon(MdiIcons.informationOutline ,color: Colors.white),
              title: Text('Rechtliches', style: new TextStyle(color: Colors.white)),
            ),
          ),
          new Divider(color: Colors.white),
          new Container(
            padding: EdgeInsets.only(top: 0),
            //child: Text("Version 0.1", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
            child: ListTile(
              enabled: false,
              title: FutureBuilder(
                future: getVersionNumber(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                    Text(
                      snapshot.hasData ? snapshot.data : "Loading ...",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    )
              ),
              trailing: Text("© Limowien GmbH", style: TextStyle(color: Colors.grey, fontSize: 11)),
            )
          )
        ],
      )
    );
  }
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;

    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    //	String buildNumber = packageInfo.buildNumber;
  }

}

