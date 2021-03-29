import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurortny_guide_flutter/model/map_list.dart';
import 'package:kurortny_guide_flutter/pages/home_page.dart';
import 'package:kurortny_guide_flutter/pages/place_page.dart';
import 'package:kurortny_guide_flutter/widgets/map_sheet.dart';

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
            icon: Icon(Icons.settings, color: Colors.cyan,),
            onPressed: ()=> showDialog(
                context: context,
                builder: (BuildContext buildContext){
                  return SimpleDialog(
                    title: Text('Выберите фильтры'),
                    children: [
                      SimpleDialogOption(
                        child: Row(
                          children: [
                            Icon(Icons.museum),
                            SizedBox(width: 2,),
                            Text('Музеи'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        child: Row(
                          children: [
                            Icon(Icons.change_history_rounded),
                            SizedBox(width: 2,),
                            Text('Религия'),
                          ],
                        ),
                      ),
                    ],
                  );
                }
            ),
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

List<Marker> religionList = [
  Marker(
    markerId: MarkerId("1"),
    position: LatLng(60.200121, 29.688443),
    infoWindow: InfoWindow(title: "Храм Покрова Божией матери"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("2"),
    position: LatLng(60.103617, 29.971210),
    infoWindow: InfoWindow(title: "Храм святых апостолов Петра и Павла"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("3"),
    position: LatLng(60.171635, 29.869983),
    infoWindow: InfoWindow(title: "Храм-часовня Преображения Господня"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("4"),
    position: LatLng(60.192398, 29.706222),
    infoWindow: InfoWindow(title: "Храм Казанской иконы Божией матери"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("5"),
    position: LatLng(60.125738, 30.160218),
    infoWindow: InfoWindow(title: "Храм Серафима Саровского"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("6"),
    position: LatLng(60.184690, 29.813569),
    infoWindow: InfoWindow(title: "Церковь Святого духа и новая церковь"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("7"),
    position: LatLng(60.123718, 30.122091),
    infoWindow: InfoWindow(title: "Церковь Петра и Павла"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("8"),
    position: LatLng(60.101304, 30.209253),
    infoWindow: InfoWindow(title: "Церковь Святого Николая Чудотворца"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("9"),
    position: LatLng(60.195830, 29.706692),
    infoWindow: InfoWindow(title: "Лютеранская Кирха Преображения Господня"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("10"),
    position: LatLng(60.125417, 30.147307),
    infoWindow: InfoWindow(title: "Часовня Серафима Саровского"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("11"),
    position: LatLng(60.089561, 29.965577),
    infoWindow: InfoWindow(title: "Часовня Николая Чудотворца"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("12"),
    position: LatLng(60.196749, 29.531765),
    infoWindow: InfoWindow(title: "Могила Крестовской в поселке Молодежное. Марьина гора"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("13"),
    position: LatLng(60.213689, 29.730898),
    infoWindow: InfoWindow(title: "Зеленогорское кладбище. Могила Герценштейна"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("14"),
    position: LatLng(60.095171, 30.190954),
    infoWindow: InfoWindow(title: "Левашовское мемориальное кладбище"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("15"),
    position: LatLng(60.034729, 29.986544),
    infoWindow: InfoWindow(title: "Кладбище в Горской"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("16"),
    position: LatLng(60.066926, 29.974975),
    infoWindow: InfoWindow(title: "Тарховское кладбище"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("17"),
    position: LatLng(60.203942, 29.799603),
    infoWindow: InfoWindow(title: "Комаровское кладбище"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("18"),
    position: LatLng(60.108471, 29.971036),
    infoWindow: InfoWindow(title: "Сестрорецкое кладбище"),
    icon: religionIcon,
  ),
  Marker(
    markerId: MarkerId("19"),
    position: LatLng(60.204525, 29.799806),
    infoWindow: InfoWindow(title: "Могила Анны Ахматовой"),
    icon: religionIcon,
  ),
];
List<Marker> militaryList = [
  Marker(
    markerId: MarkerId("1"),
    position: LatLng(60.030205, 30.015883),
    infoWindow: InfoWindow(title: "Аэродром в Горской"),
    icon: militaryIcon,
  ),
  Marker(
    markerId: MarkerId("2"),
    position: LatLng(60.090518, 30.195451),
    infoWindow: InfoWindow(title: "Военный аэродром в Левашово"),
    icon: militaryIcon,
  ),
  Marker(
    markerId: MarkerId("3"),
    position: LatLng(60.099072, 30.213370),
    infoWindow: InfoWindow(title: "Военный мемориал и памятник дважды Герою СССР А. Т. Карпова"),
    icon: militaryIcon,
  ),
  Marker(
    markerId: MarkerId("4"),
    position: LatLng(60.184712, 29.818013),
    infoWindow: InfoWindow(title: "Братская могила воинов Советской Армии/погибших "
        "в боях Советско-финской и Великой Отечественной войны 1941-1945гг"),
    icon: militaryIcon,
  ),
];


Widget _googleMaps(BuildContext context) {

  showMapSheet(LatLng coordinates, String name, int page) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              height: 200,
              child: Expanded(child: MapSheet(coordinates: coordinates, name: name, page: page,)),
            ),
          ),
        );
      },
    );
  }

  List<Marker> religionList = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(60.200121, 29.688443),
      infoWindow: InfoWindow(title: "Храм Покрова Божией матери"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(60.103617, 29.971210),
      infoWindow: InfoWindow(title: "Храм святых апостолов Петра и Павла"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(60.171635, 29.869983),
      infoWindow: InfoWindow(title: "Храм-часовня Преображения Господня"),
      icon: religionIcon,
    ),
    Marker(
        markerId: MarkerId("4"),
        position: LatLng(60.192398, 29.706222),
        infoWindow: InfoWindow(title: "Храм Казанской иконы Божией матери"),
        icon: religionIcon,
        onTap: ()=> Navigator.push(context,
          MaterialPageRoute(
            builder: (_) => PlacePage(),
          ),
        ),
    ),
    Marker(
      markerId: MarkerId("5"),
      position: LatLng(60.125738, 30.160218),
      infoWindow: InfoWindow(title: "Храм Серафима Саровского"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("6"),
      position: LatLng(60.184690, 29.813569),
      infoWindow: InfoWindow(title: "Церковь Святого духа и новая церковь"),
      icon: religionIcon,
      onTap: ()=> Navigator.push(context,
        MaterialPageRoute(
          builder: (_) => PlacePage(),
        ),
      ),
    ),
    Marker(
      markerId: MarkerId("7"),
      position: LatLng(60.123718, 30.122091),
      infoWindow: InfoWindow(title: "Церковь Петра и Павла"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("8"),
      position: LatLng(60.101304, 30.209253),
      infoWindow: InfoWindow(title: "Церковь Святого Николая Чудотворца"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("9"),
      position: LatLng(60.195830, 29.706692),
      infoWindow: InfoWindow(title: "Лютеранская Кирха Преображения Господня"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("10"),
      position: LatLng(60.125417, 30.147307),
      infoWindow: InfoWindow(title: "Часовня Серафима Саровского"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("11"),
      position: LatLng(60.089561, 29.965577),
      infoWindow: InfoWindow(title: "Часовня Николая Чудотворца"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("12"),
      position: LatLng(60.196749, 29.531765),
      infoWindow: InfoWindow(title: "Могила Крестовской в поселке Молодежное. Марьина гора"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("13"),
      position: LatLng(60.213689, 29.730898),
      infoWindow: InfoWindow(title: "Зеленогорское кладбище. Могила Герценштейна"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("14"),
      position: LatLng(60.095171, 30.190954),
      infoWindow: InfoWindow(title: "Левашовское мемориальное кладбище"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("15"),
      position: LatLng(60.034729, 29.986544),
      infoWindow: InfoWindow(title: "Кладбище в Горской"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("16"),
      position: LatLng(60.066926, 29.974975),
      infoWindow: InfoWindow(title: "Тарховское кладбище"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("17"),
      position: LatLng(60.203942, 29.799603),
      infoWindow: InfoWindow(title: "Комаровское кладбище"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("18"),
      position: LatLng(60.108471, 29.971036),
      infoWindow: InfoWindow(title: "Сестрорецкое кладбище"),
      icon: religionIcon,
    ),
    Marker(
      markerId: MarkerId("19"),
      position: LatLng(60.204525, 29.799806),
      infoWindow: InfoWindow(title: "Могила Анны Ахматовой"),
      icon: religionIcon,
    ),
  ];
  List<Marker> militaryList = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(60.030205, 30.015883),
      infoWindow: InfoWindow(title: "Аэродром в Горской"),
      icon: militaryIcon,
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(60.090518, 30.195451),
      infoWindow: InfoWindow(title: "Военный аэродром в Левашово"),
      icon: militaryIcon,
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(60.099072, 30.213370),
      infoWindow: InfoWindow(title: "Военный мемориал и памятник дважды Герою СССР А. Т. Карпова"),
      icon: militaryIcon,
      onTap:(){ showMapSheet(LatLng(60.099072, 30.213370), 'Военный мемориал и памятник дважды Герою СССР А. Т. Карпова', 5);}
    ),
    Marker(
      markerId: MarkerId("4"),
      position: LatLng(60.184712, 29.818013),
      infoWindow: InfoWindow(
          title: "Братская могила воинов Советской Армии/погибших "
          "в боях Советско-финской и Великой Отечественной войны 1941-1945гг",
        snippet: 'military'
      ),
      icon: militaryIcon,
      onTap: () {
        return showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context){
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  height: 200,
                  child: MapSheet(name: 'Братская могила воинов Советской Армии/погибших в боях Советско-финской и Великой Отечественной войны 1941-1945гг', page: 5, coordinates: LatLng(60.184712, 29.818013),),
                ),
              ),
            );
          },
        );
      }
    ),
  ];


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