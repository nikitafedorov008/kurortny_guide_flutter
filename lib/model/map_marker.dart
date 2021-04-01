import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Marker {
  final String name;
  final String type;
  final String url;
  final int page;

  MapMarker(this.name, this.type, this.url, this.page, {MarkerId id, lat, lng, onTap, icon})
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