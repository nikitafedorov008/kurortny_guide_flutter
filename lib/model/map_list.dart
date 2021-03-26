import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurortny_guide_flutter/widgets/map_sheet.dart';

//show bottom sheet
showMapSheet(context, LatLng coordinates, String name) {
  showModalBottomSheet(
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
            height: 700,
            child: Expanded(child: MapSheet()),
          ),
        ),
      );
    },
  );
}

//icons for lists
BitmapDescriptor museumIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
BitmapDescriptor religionIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
BitmapDescriptor militaryIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

//lists of markers
List<Marker> museumList = [
  Marker(
    markerId: MarkerId("1"),
    position: LatLng(60.082630, 30.031255),
    infoWindow: InfoWindow(title: "Музей «Шалаш»"),
    icon: museumIcon,
  ),
  Marker(
    markerId: MarkerId("2"),
    position: LatLng(60.079895, 29.976921),
    infoWindow: InfoWindow(title: "Музей «Сарай»"),
    icon: museumIcon,
  ),
  Marker(
    markerId: MarkerId("3"),
    position: LatLng(60.113087, 29.971866),
    infoWindow: InfoWindow(title: "Музей «Сестрорецкий рубеж»"),
    icon: museumIcon,
  ),
  Marker(
    markerId: MarkerId("4"),
    position: LatLng(60.155804, 29.896731),
    infoWindow: InfoWindow(title: "Музей-усадьба И. Е. Репина «Пенаты»"),
    icon: museumIcon,
  ),
  Marker(
    markerId: MarkerId("5"),
    position: LatLng(60.184223, 29.789947),
    infoWindow: InfoWindow(title: "Музей «Келломяки – Комарово»"),
    icon: museumIcon,
  ),
  Marker(
    markerId: MarkerId("6"),
    position: LatLng(60.191687, 29.703867),
    infoWindow: InfoWindow(title: "Музей ретро-автомобилей"),
    icon: museumIcon,
  ),
  Marker(
    markerId: MarkerId("7"),
    position: LatLng(60.122125, 30.156579),
    infoWindow: InfoWindow(title: "Малый Садовый сквер"),
    icon: museumIcon,
  ),
  Marker(
    markerId: MarkerId("8"),
    position: LatLng(60.167917, 29.860979),
    infoWindow: InfoWindow(title: "Репино"),
    icon: museumIcon,
  ),
];
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