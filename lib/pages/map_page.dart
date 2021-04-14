import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kurortny_guide_flutter/model/map_list.dart';
import 'package:kurortny_guide_flutter/model/map_marker.dart';
import 'package:kurortny_guide_flutter/pages/search_page.dart';
import 'package:kurortny_guide_flutter/widgets/map_sheet.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

GoogleMapController mapController;

class _MapPageState extends State<MapPage> {
  Set<MapMarker> markersList = new Set();
  List<bool> _isSwitched = [true, true, true, true, true, true, true,];
  FloatingSearchBarController controller;
  
  BitmapDescriptor markerIcon(String type) {
    if (type == 'природный объект') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    } else if(type == 'религиозный объект') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    } else if(type == 'захоронение') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    } else if(type == 'военный объект') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    } else if(type == 'музей') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    } else if(type == 'архитектура') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    } else if(type == 'городской объект') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    } else if(type == 'отдых') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    } else if(type == 'ресторан') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    } else {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    }
  }

  changeMarkers() {
    if (_isSwitched[0] == true) {
      setState(() {
        _addMarkers(nature_locations);
      });
    }
    if (_isSwitched[1] == true) {
      setState(() {
        _addMarkers(religion_locations);
      });
    }
    if (_isSwitched[2] == true){
      setState(() {
        _addMarkers(military_locations);
      });
    }
    if (_isSwitched[3] == true) {
      setState(() {
        _addMarkers(museum_locations);
      });
    }
    if (_isSwitched[4] == true) {
      setState(() {
        _addMarkers(architecture_locations);
      });
    }
    if (_isSwitched[5] == true) {
      setState(() {
        _addMarkers(city_locations);
      });
    }
    if (_isSwitched[6] == true) {
      setState(() {
        _addMarkers(chill_locations);
      });
    }
  }

  onStartMarkers(){
    _addMarkers(nature_locations);
    _addMarkers(religion_locations);
    _addMarkers(military_locations);
    _addMarkers(museum_locations);
    _addMarkers(architecture_locations);
    _addMarkers(city_locations);
    _addMarkers(chill_locations);
  }

  void _addMarkers(List<Map<String, dynamic>> locations) {
    locations.forEach((Map<String, dynamic> location) {
      final MapMarker marker = MapMarker(
          location['Location_Name'],
          location['Location_Type'],
          location['Location_Url'],
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
                  child: MapSheet(
                    name: location['Location_Name'],
                    url: location['Location_Url'],
                    page: location['Location_Page'],
                    coordinates: LatLng(
                      location['coordinates'][1],
                      location['coordinates'][0],
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

  Widget myPopMenu() {
    return PopupMenuButton(
        onSelected: (value) {
          Fluttertoast.showToast(
              msg: "You have selected " + value.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    child: Icon(Icons.print),
                  ),
                  Text('Print')
                ],
              )),
          PopupMenuItem(
              value: 2,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    child: Icon(Icons.share),
                  ),
                  Text('Share')
                ],
              )),
          PopupMenuItem(
              value: 3,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    child: Icon(Icons.add_circle),
                  ),
                  Text('Add')
                ],
              )),
        ]);
  }

  var mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Карта'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: HexColor('#8E9C80'),),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.settings, color: HexColor('#8E9C80'),),
            itemBuilder: (BuildContext buildContext) => [
              /*PopupMenuItem(
                value: "/military",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.article_outlined),
                        Text('Все места'),
                        Switch(
                          activeColor: Colors.grey,
                          value: _isSwitched[1],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[0] = val;
                              _isSwitched[1] = val;
                              setState(() {
                                markersList.clear();
                                changeMarkers();
                              });
                              Navigator.pop(context);
                              //changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),*/
              PopupMenuItem(
                value: "/nature",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.eco),
                        Text('Природа'),
                        Switch(
                          activeColor: Colors.green,
                          value: _isSwitched[0],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[0] = val;
                              setState(() {
                                markersList.clear();
                                changeMarkers();
                              });
                              //changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: "/religion",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.account_balance),
                        Text('Религия'),
                        Switch(
                          activeColor: Colors.deepPurple,
                          value: _isSwitched[1],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[1] = val;
                              setState(() {
                                markersList.clear();
                                changeMarkers();
                              });
                              //changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: "/military",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.military_tech),
                        Text('Военные'),
                        Switch(
                          activeColor: Colors.red,
                          value: _isSwitched[2],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[2] = val;
                              setState(() {
                                markersList.clear();
                                changeMarkers();
                              });
                              //changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
              value: "/museum",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.museum),
                        Text('Музеи'),
                        Switch(
                          activeColor: Colors.blue,
                          value: _isSwitched[3],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[3] = val;
                              setState(() {
                                markersList.clear();
                              });
                              changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: "/architecture",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.architecture),
                        Text('Архитектура'),
                        Switch(
                          activeColor: Colors.amber,
                          value: _isSwitched[4],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[4] = val;
                              setState(() {
                                markersList.clear();
                                changeMarkers();
                              });
                              //changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: "/city",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.location_city),
                        Text('Город'),
                        Switch(
                          activeColor: Colors.cyan,
                          value: _isSwitched[5],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[5] = val;
                              setState(() {
                                markersList.clear();
                                changeMarkers();
                              });
                              //changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: "/chill",
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.airline_seat_individual_suite),
                        Text('Отдых'),
                        Switch(
                          activeColor: Colors.pink,
                          value: _isSwitched[6],
                          onChanged: (val) {
                            stateSetter(() {
                              _isSwitched[6] = val;
                              setState(() {
                                markersList.clear();
                                changeMarkers();
                              });
                              //changeMarkers();
                            });
                          },),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.map, color: HexColor('#8E9C80'),),
                        Text('Поменять стиль карты', style: TextStyle(color: HexColor('#8E9C80'),),),
                      ],
                    ),
                    onPressed: (){
                      if (mapType == MapType.hybrid) {
                        setState(() {
                          this.mapType = MapType.normal;
                          // markersList.toSet();
                        });
                      }  else {
                        setState(() {
                          this.mapType = MapType.hybrid;
                          // markersList.toSet();
                        });
                      }
                    },
                  ),
              ),
            ],
            onSelected: (route) {
              print(route);
              // Note You must create respective pages for navigation
              Navigator.pushNamed(context, route);
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(60.0702,30.1120), zoom: 9),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapType: mapType,
        mapToolbarEnabled: true,
        indoorViewEnabled: true,
        markers: markersList.toSet(),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    onStartMarkers();

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