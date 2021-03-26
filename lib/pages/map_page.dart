import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurortny_guide_flutter/model/map_list.dart';

Completer<GoogleMapController> _controller = Completer();

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Карта"),
        actions: [
          IconButton(
              //onPressed: onPressed,
              icon: Icon(Icons.settings, color: Colors.cyan,),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[_googleMaps(context)],
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToNextLocation,
        label: Text('To the Next Location'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }
}

Widget _googleMaps(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition:
      CameraPosition(target: LatLng(60.1000, 29.5400), zoom: 10),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      //markers: {m1, m2, m3},
      markers: Set<Marker>.of(
          museumList
              + religionList
              + militaryList
      ),
    ),
  );
}

/*Marker m1 = Marker(
  markerId: MarkerId("1"),
  position: LatLng(15.841461, 74.512202),
  infoWindow: InfoWindow(title: "Дамба"),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
);*/

Future<void> _goToNextLocation() async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 19.151926040649414,
          tilt: 59.440717697143555,
          bearing: 192.8334901395799),
    ),
  );
}