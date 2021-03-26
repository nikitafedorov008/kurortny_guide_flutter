import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurortny_guide_flutter/pages/guide_page.dart';
import 'package:kurortny_guide_flutter/utilities/launch_taxi.dart';

class MapSheet extends StatefulWidget {
  MapSheet({this.name, this.page, this.coordinates});

  final String name;
  final int page;
  final LatLng coordinates;

  @override
  _MapSheetState createState() => _MapSheetState();
}

class _MapSheetState extends State<MapSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.name),
          Row(
            children: [
              MaterialButton(
                child: Text('Инфо'),
                onPressed: ()=> Navigator.push(context,
                  MaterialPageRoute(
                    builder: (_) => GuidePage(),
                  ),
                ),
              ),
              MaterialButton(
                child: Text('Такси'),
                onPressed:()=> launchYandexTaxi(widget.coordinates),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
