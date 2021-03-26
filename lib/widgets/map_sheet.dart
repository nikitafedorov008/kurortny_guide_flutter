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
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              widget.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(
                color: Colors.cyan,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                child: Container(
                  width: 104,
                  child: Row(
                    children: [
                      Icon(Icons.book),
                      Text('Подробнее'),
                    ],
                  ),
                ),
                onPressed: ()=> Navigator.push(context,
                  MaterialPageRoute(
                    builder: (_) => GuidePage(),
                  ),
                ),
              ),
              SizedBox(width: 4,),
              OutlineButton(
                color: Colors.cyan,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                child: Container(
                  width: 90,
                  child: Row(
                    children: [
                      Icon(Icons.navigation),
                      Text('Маршрут'),
                    ],
                  ),
                ),
                onPressed:()=> launchYandexTaxi(widget.coordinates),
              ),
              SizedBox(width: 4,),
              OutlineButton(
                color: Colors.cyan,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                child: Container(
                  width: 80,
                  child: Row(
                    children: [
                      Icon(Icons.link_sharp),
                      Text('Ссылки'),
                    ],
                  ),
                ),
                onPressed:()=> launchYandexTaxi(widget.coordinates),
              ),
            ],
          ),
          MaterialButton(
            //minWidth: 20,
            color: Colors.yellow,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Container(
              width: 184,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_taxi),
                  Text('Заказать яндекс такси'),
                ],
              ),
            ),
            onPressed:()=> launchYandexTaxi(widget.coordinates),
          ),
        ],
      ),
    );
  }
}
