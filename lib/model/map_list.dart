import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Marker {
  final String name;
  final String type;
  final int page;

  MapMarker(this.name, this.type, this.page, {MarkerId id, lat, lng, onTap, icon})
      : super(
    markerId: id,
    consumeTapEvents: false,
    position: LatLng(
      lat,
      lng,
    ),
    icon: icon,
    infoWindow: InfoWindow(title: name, snippet: type),
    onTap: onTap,
  );
}

List<Map<String, dynamic>> locations = [
  {
    "Location_Number": "4",
    "Location_Name": "Дамба",
    "Location_Type": "museum",
    "Location_Page": 120,
    "coordinates": [29.865693, 60.028998]
  },
  {
    "Location_Number": "3",
    "Location_Name": "Аэродром",
    "Location_Type": "military",
    "Location_Page": 124,
    "coordinates": [30.015883, 60.030205]
  },
  {
    "Location_Number": "2",
    "Location_Name": "Кладбище",
    "Location_Type": "museum",
    "Location_Page": 126,
    "coordinates": [29.986544, 60.034729]
  },
  {
    "Location_Number": "1",
    "Location_Name": "Горская",
    "Location_Type": "military",
    "Location_Page": 118,
    "coordinates": [29.980015, 60.042399]
  },
  {
    "Location_Number": "13",
    "Location_Name": "Зеленогорское кладбище. Могила Герценштейна",
    "Location_Type": "military",
    "Location_Page": 102,
    "coordinates": [29.730898, 60.213689]
  }
];