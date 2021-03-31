import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

Future<void> launchRoute(LatLng coordinates, String name) async {
  final availableMaps = await MapLauncher.installedMaps;
  print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

  await availableMaps.first.showDirections(
    destination: Coords(
      coordinates.latitude,
      coordinates.longitude,
    ),
  );
}