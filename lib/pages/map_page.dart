import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurortny_guide_flutter/model/map_list.dart';
import 'package:kurortny_guide_flutter/widgets/map_filter.dart';
import 'package:kurortny_guide_flutter/widgets/map_sheet.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<MapMarker> markersList = new Set();
  
  BitmapDescriptor markerIcon(String type) {
    if(type == 'museum') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    } else if(type == 'military') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    } else {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    }
  }

  void _addMarkers() {
    locations.forEach((Map<String, dynamic> location) {
      final MapMarker marker = MapMarker(
          location['Location_Name'],
          location['Location_Type'],
          location['Location_Page'],
          id: MarkerId(location['Location_Number']),
          lat: location['coordinates'][1],
          lng: location['coordinates'][0],
          icon: markerIcon(location['Location_Type']),
          onTap:()=> showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context){
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Expanded(
                    child: MapSheet(
                      name: location['Location_Name'],
                      page: location['Location_Page'],
                      coordinates: LatLng(
                        location['coordinates'][1],
                        location['coordinates'][0],
                      ),
                    ),
                  )
                ),
              );
            },
          ),
      );
      markersList.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Карта'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.cyan,),
            onPressed: ()=> showDialog(
                context: context,
                builder: (BuildContext buildContext){
                  return MapFilter();
                }
            ),
          ),
        ],
      ),
      body: GoogleMap(
          initialCameraPosition:
          CameraPosition(target: LatLng(60.0702,30.1120), zoom: 9),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          compassEnabled: false,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          mapToolbarEnabled: true,
          indoorViewEnabled: true,
          mapType: MapType.normal,
          markers: markersList.toSet()),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    _addMarkers();

    LatLngBounds _bounds = FindBoundsCoordinates().getBounds(markersList);

    controller.animateCamera(CameraUpdate.newLatLngBounds(_bounds, 100.0));
  }
}

class FindBoundsCoordinates {
  LatLngBounds getBounds(Set<MapMarker> locations) {
    List<double> latitudes = [];
    List<double> longitude = [];

    locations.toList().forEach((index) {
      latitudes.add(index.position.latitude);
      longitude.add(index.position.longitude);
    });

    return LatLngBounds(
      southwest: LatLng(latitudes.reduce(min), longitude.reduce(min)),
      northeast: LatLng(latitudes.reduce(max), longitude.reduce(max)),
    );
  }
}