import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// Plugins
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:limowien_app/module/welcomeView.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// OWN
import 'module/splashScreen.dart';
import 'widgets/drawerWidget.dart';
import 'routes/bookView.dart';
import 'module/loginView.dart';
import 'module/registerView.dart';


void main(){
  runApp(new MaterialApp(
    color: Colors.black,
    debugShowCheckedModeBanner: false,
    home: WelcomeView(), // slpashscreen.dart
  ));
}

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Position position;
  Widget _child;
  Container fabBook;
  Container fabLocation;
  Completer<GoogleMapController> _controller = Completer();
  @override

  void initState() {
    // TODO: implement initState
   // _child = RippleIndicator("Getting Location");
    getCurrentLocationOnStartup();
    super.initState();
  }

  void getCurrentLocationOnStartup() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 16.0,

      ),
    ));
  }

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //statusBarColor: Color(0xFFb69862),
      //statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      //systemNavigationBarColor: Color(0xFFb69862),
      //systemNavigationBarColor: Colors.transparent,
      //systemNavigationBarIconBrightness: Brightness.light,
      )
    );

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: new IconThemeData(color: Colors.black, size: 100),
        leading: IconButton(
          iconSize: 32.0,
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),

      drawer: NavigationDrawer(),
      body: _child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: <Widget>[
          // FAB for BOOKING
          Align(
            alignment: Alignment.bottomCenter,
            child: fabBook = Container(
              padding: EdgeInsets.only(bottom: 20),
              height: 84,
              width: MediaQuery.of(context).size.width * 0.925,
              child: FloatingActionButton.extended(
                onPressed: () {Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new BookView(),));},
                heroTag: null,
                label: new Text(
                  "FAHRT BUCHEN",
                  style: new TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )
                ),
                //icon: const Icon(MdiIcons.plus),
                backgroundColor: Color(0xFFb69862),
                elevation: 0.0,
                highlightElevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                //splashColor: Colors.transparent,
              )
            )
          ),
          // FAB for LOCATION
          Align(
            alignment: Alignment.bottomRight,
            child: fabLocation = Container(
              //height: 50,
              padding: EdgeInsets.only(bottom: 94, right: MediaQuery.of(context).size.width * 0.02),
              child: FloatingActionButton(
                onPressed: _currentLocation,
                highlightElevation: 0,
                elevation: 0,
                mini: true,
                child: Icon(MdiIcons.crosshairsGps),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
              )
            )
          ),
        ]
      ),
    );
  } // Widget build

  Widget mapWidget()=> GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      padding: EdgeInsets.only(bottom: 500, left: 500),
      // markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );



}
