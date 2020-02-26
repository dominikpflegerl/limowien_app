import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/services.dart'; // statusbar color
import 'package:url_launcher/url_launcher.dart';
import 'faqView.dart';

class AboutView extends StatefulWidget {
  AboutView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AboutView createState() => new _AboutView();
}

class _AboutView extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("Hilfe & Kontakt"),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            Card(
              color: Color(0xFF221f1c),
              elevation: 0,
              child: ListTile(
                onTap: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new FAQView(),));},
                leading: new Icon(MdiIcons.frequentlyAskedQuestions ,color: Colors.white),
                title: Text('FAQ', style: new TextStyle(color: Colors.white)),
              ),
            ),
            Card(
              color: Color(0xFF221f1c),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                child: ExpansionTile(
                  backgroundColor: Color(0xFFb69862),
                  leading: new Icon(MdiIcons.contactMail, color: Colors.white),
                  trailing: Icon(MdiIcons.arrowDown, color: Colors.transparent),
                  title: Text('Kontakt', style: new TextStyle(color: Colors.white)),
                  children: <Widget>[
                    ListTile(
                      onTap: _launchPhone,
                      leading: new Icon(MdiIcons.phone, color: Colors.white),
                      title: new Text('Anruf', style: new TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      onTap: _launchMail,
                      leading: new Icon(MdiIcons.email, color: Colors.white),
                      title: new Text('E-Mail', style: new TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      onTap: _launchWA,
                      leading: new Icon(MdiIcons.whatsapp, color: Colors.white),
                      title: new Text('WhatsApp', style: new TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xFF221f1c),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                child: ExpansionTile(
                  backgroundColor: Color(0xFFb69862),
                  leading: new Icon(MdiIcons.information, color: Colors.white),
                  trailing: Icon(MdiIcons.arrowDown, color: Colors.transparent),
                  title: Text('Rechtliches', style: new TextStyle(color: Colors.white)),
                  children: <Widget>[
                    ListTile(
                      onTap: _launchPhone,
                      leading: new Icon(MdiIcons.informationVariant, color: Colors.white),
                      title: new Text('AGB', style: new TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      onTap: _launchMail,
                      leading: new Icon(MdiIcons.informationVariant, color: Colors.white),
                      title: new Text('Impressum', style: new TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Version ", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  FutureBuilder(
                      future: getVersionNumber(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                          Text(
                            snapshot.hasData ? snapshot.data : "Loading ...",
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchPhone() async {
    const phone  = 'tel:+43 676 3473554';
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not launch $phone';
    }
  }

  _launchMail() async {
    const url = 'mailto:office@limowien.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWA() async {
    const phone  = 'tel:+43 676 3473554';
    const url = 'whatsapp://send?phone=$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

