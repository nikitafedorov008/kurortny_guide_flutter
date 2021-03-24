import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurortny_guide_flutter/model/map_list.dart';
import 'package:kurortny_guide_flutter/model/map_marker.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<MapMarker> markersList = new Set();

  List<Map<String, dynamic>> locations = [
    {
      "Location_Number": "29.86569360.02899",
      "Location_Name": "Дамба",

      "coordinates": [29.865693, 60.028998]
    },
    {
      "Location_Number": "29.86569360.028998",
      "Location_Name": "Аэродром",
      "coordinates": [30.015883, 60.030205]
    },
    {
      "Location_Number": "29.86569360.028998",
      "Location_Name": "Кладбище",
      "coordinates": [29.986544, 60.034729]
    },
    {
      "Location_Number": "29.86569360.028998",
      "Location_Name": "Горская",
      "coordinates": [29.980015, 60.042399]
    },
    {
      "Location_Number": "-76.97892538.882767",
      "Location_Name": "John Dean and Hannibal Hamlin Burial Sites",
      "coordinates": [-76.978923660098019, 38.882767398397789]
    },
    {
      "Location_Number": "-77.16515878125193238.938782583950172",
      "Location_Name": "Camp Greene",
      "coordinates": [-77.165158781251932, 38.938782583950172]
    },
    {
      "Location_Number": "-77.04500938.919531",
      "Location_Name": "John Little Farm Site",
      "coordinates": [-77.045009, 38.919531]
    },
  ];

  void _addMarkers() {
    locations.forEach((Map<String, dynamic> location) {
      final MapMarker marker = MapMarker(
          location['Location_Name'],
          location['Location_Type'],
          id: MarkerId(location['Location_Number']),
          lat: location['coordinates'][1],
          lng: location['coordinates'][0],
          onTap: null
      );
      markersList.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта'),
        actions: [
          IconButton(
              //onPressed: onPressed,
              icon: Icon(Icons.settings),
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