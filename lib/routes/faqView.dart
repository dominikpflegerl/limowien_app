import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart'; // statusbar color
import 'aboutView.dart';


class FAQView extends StatefulWidget {
  FAQView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FAQView createState() => new _FAQView();
}

class _FAQView extends State<FAQView> {
  var data = [
    {
      "q": "Wovon hängt der Preis ab?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Gibt es Spezialraten?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Wann wird meine Kreditkarte belastet?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Welche Kreditkarten werden akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Werden Debitkarten akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Welche Kreditkarten werden akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Werden Debitkarten akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Welche Kreditkarten werden akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Werden Debitkarten akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Welche Kreditkarten werden akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Werden Debitkarten akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Welche Kreditkarten werden akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Werden Debitkarten akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Welche Kreditkarten werden akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Werden Debitkarten akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Welche Kreditkarten werden akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
    {
      "q": "Werden Debitkarten akzeptiert?",
      "a": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tortor diam, lobortis eu leo sed, finibus malesuada tellus. Mauris diam ipsum, tincidunt non mollis quis, convallis eget dui. Praesent at erat quis est fringilla condimentum nec et lacus."
    },
  ];

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
        //iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("Frequently Asked Quesions"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {Navigator.pop(context); Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new AboutView(),));}, //fix this shit
          )
      ),
      body: new Stack(
        children: <Widget>[
          new Transform.translate(
            offset: new Offset(0.0, 0.0),
            child: new ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              primary: true,
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return AwesomeListItem(
                    q: data[index]["q"],
                    a: data[index]["a"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AwesomeListItem extends StatefulWidget {
  String q;
  String a;

  AwesomeListItem({this.q, this.a});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: new Card(
        color: Color(0xFF221f1c),
        elevation: 0,
        child: ExpansionTile(
          trailing: Icon(MdiIcons.dotsVertical, color: Colors.white),
          title: Text(widget.q, style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          children: <Widget>[
            ListTile(
              title: new Text(
                  widget.a,
                  style: new TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )
    );
  }
}