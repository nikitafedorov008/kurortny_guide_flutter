import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

//
// extending the google map marker to add more information
// to it
class MapMarker extends Marker {
  final String name;
  final String type;
  BitmapDescriptor bitColor;

  MapMarker(this.name, this.type, {MarkerId id, lat, lng, onTap})
      : super(
    markerId: id,
    consumeTapEvents: false,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    position: LatLng(
      lat,
      lng,
    ),
    infoWindow: InfoWindow(title: name, snippet: type),
    onTap: onTap,
  );
}