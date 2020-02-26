import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FleetView extends StatefulWidget {
  FleetView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FleetView createState() => new _FleetView();
}

class _FleetView extends State<FleetView> {
  var data = [
    {
      "category": "Standard Class",
      "car": "Skoda Octavia, oder ähnlich",
      "image": "assets/images/vehicle/skoda.png",
      "seatCount": "3",
      "bagCount": "4"
    },
    {
      "category": "Business Class",
      "car": "Mercedes-Benz E-Klasse, oder ähnlich",
      "image": "assets/images/vehicle/mbe.png",
      "seatCount": "3",
      "bagCount": "2"
    },
    {
      "category": "Green Class",
      "car": "Tesla Model S (garantiert)",
      "image": "assets/images/vehicle/tesla.png",
      "seatCount": "3",
      "bagCount": "3"
    },
    {
      "category": "First Class",
      "car": "Mercedes-Benz S-Klasse, oder ähnlich",
      "image": "assets/images/vehicle/mbs.png",
      "seatCount": "3",
      "bagCount": "2"
    },
    {
      "category": "Business Van",
      "car": "Mercedes-Benz V-Klasse, Mercedes-Benz Vito",
      "image": "assets/images/vehicle/mbv.png",
      "seatCount": "7",
      "bagCount": "6"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF221f1c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFb69862),
        iconTheme: new IconThemeData(color: Colors.white, size: 100),
        title: Text("Flottenübersicht"),
      ),
      //drawer: NavigationDrawer(),
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
                  category: data[index]["category"],
                  car: data[index]["car"],
                  image: data[index]["image"],
                  seatCount: data[index]["seatCount"],
                  bagCount: data[index]["bagCount"]
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class AwesomeListItem extends StatefulWidget {
  String category;
  String car;
  String image;
  String seatCount;
  String bagCount;

  AwesomeListItem({this.category, this.car, this.image, this.seatCount, this.bagCount});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child:  Row(
        children: <Widget>[
          new Container(width: 0.0, height: 180.0,color: Color(0xFFb69862)),
          new Expanded(
            child: new Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Color(0xFFb69862),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: widget.category),
//                        WidgetSpan(
//                          child: Padding(
//                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
//                            child: Icon(MdiIcons.informationOutline, color: Colors.white, size: 9),
//                          ),
//                        ),
                      ],
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: new Text(
                      widget.car,
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                          //fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(MdiIcons.accountMultipleOutline, color: Colors.white, size: 14),
                            ),
                          ),
                          TextSpan(text: widget.seatCount + " Sitze"),
                        ],
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                          //fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(MdiIcons.bagChecked, color: Colors.white, size: 14),
                            ),
                          ),
                          TextSpan(text: widget.bagCount + " Koffer"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container( // CONTAINER RECHTS
            height: 150.0,
            width: 200.0,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                new Transform.translate(
                  offset: new Offset(50.0, 20.0),
                  child: new Container(
                    height: 100.0,
                    width: 150.0,
                    color: Color(0xFFb69862),
                  ),
                ),
                new Transform.translate(
                  offset: Offset(0.0, 15.0),
                  child: new Card(
                    elevation: 80.0,
                    color: Colors.transparent,
                    child: new Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.image)
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


