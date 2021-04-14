import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kurortny_guide_flutter/model/map_list.dart';
import 'package:kurortny_guide_flutter/pages/map_page.dart';
import 'package:kurortny_guide_flutter/pages/place_page.dart';

class DataSearch extends SearchDelegate<String> {

  String get searchFieldLabel => "Поиск по карте";

  List<Map<String, dynamic>> architecture_locations = [
    {
      "Location_Number": "1a",
      "Location_Name": "Беседка Шаляпина",
      "Location_Type": "архитектура",
      "Location_Page": 95,
      "Location_Url": "https://en.wikipedia.org/wiki/Kurortny_District",
      "coordinates": [29.951802, 60.109301]
    },
  ];

  final List cites = [
    'lol',
    'kek',
    'cheburek',
    'lavah',
    'shaverma',
  ];

  final List recentCites = [
    'cheburek',
    'lavah',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // app abr actions
    return[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()=> query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //return[IconButton()];
    return IconButton(
      icon: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      //onPressed: onPressed,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the search
    IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  void _addMarkers(List<Map<String, dynamic>> locations) {
    locations.forEach((Map<String, dynamic> location) {
      return ListView.builder(
        itemBuilder: (context, index)=> ListTile(
          leading: Icon(Icons.map_rounded),
          title: Text(location['Location_Name']),
          subtitle: Text(location['Location_Type']),
        ),
        itemCount: locations.length,
      );
    });
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

  @override
  Widget buildSuggestions(BuildContext context) {
    // show someone search for something
    //final suggestionList = cites.where((p) => p.startsWith(query)).toList();
    //final asdad = cites.where((p) => p.startsWith(query)).toList();

    final searchList = search_locations.where((p) => p['Location_Name'].startsWith(query)).toList();

    Icon titleIcon(index) {
      if (searchList[index]['Location_Type'] == 'природный объект') {
        return Icon(Icons.eco, color: Colors.green,);
      } else if (searchList[index]['Location_Type'] == 'религиозный объект') {
        return Icon(Icons.account_balance, color: Colors.deepPurple,);
      } else if (searchList[index]['Location_Type'] == 'захоронение') {
        return Icon(Icons.add, color: Colors.deepPurple,);
      } else if (searchList[index]['Location_Type'] == 'военный объект') {
        return Icon(Icons.military_tech, color: Colors.red,);
      } else if (searchList[index]['Location_Type'] == 'музей') {
        return Icon(Icons.museum, color: Colors.blue,);
      } else if (searchList[index]['Location_Type'] == 'архитектура') {
        return Icon(Icons.architecture, color: Colors.orange,);
      } else if (searchList[index]['Location_Type'] == 'городской объект') {
        return Icon(Icons.location_city, color: Colors.cyan,);
      } else if (searchList[index]['Location_Type'] == 'отдых') {
        return Icon(Icons.airline_seat_individual_suite, color: Colors.pink,);
      }  else if (searchList[index]['Location_Type'] == 'ресторан') {
        return Icon(Icons.food_bank, color: Colors.pink,);
      } else {
        return Icon(Icons.map_rounded);
      }
    }

    search_locations.addAll(nature_locations);
    search_locations.addAll(religion_locations);
    search_locations.addAll(military_locations);
    search_locations.addAll(museum_locations);
    search_locations.addAll(architecture_locations);
    search_locations.addAll(city_locations);
    search_locations.addAll(chill_locations);

    return ListView.builder(
        itemBuilder: (context, index)=> ListTile(
          leading: titleIcon(index),
          title: Text(searchList[index]['Location_Name']),
          subtitle: Text(searchList[index]['Location_Type']),
          onTap:() {
            mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(searchList[index]['coordinates'][1], searchList[index]['coordinates'][0]),
                        zoom: 20,
                    )
                )
            );
            Navigator.pop(context);
          },
        ),
      itemCount: searchList.length,
    );

    /*
    return ListView.builder(
      itemBuilder: (context, index)=> ListTile(
        leading: Icon(Icons.map_rounded),
        title: Text(suggestionList[index]),
        subtitle: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
    */
  }
}

List<Map<String, dynamic>> search_locations = [];


class DataSearchGuide extends SearchDelegate<String> {

  String get searchFieldLabel => "Поиск по путеводителю";

  @override
  List<Widget> buildActions(BuildContext context) {
    // app abr actions
    return[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()=> query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //return[IconButton()];
    return IconButton(
      icon: BackButton(
        onPressed: ()=> Navigator.pop(context),
      ),
      //onPressed: onPressed,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the search
    IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  void _addMarkers(List<Map<String, dynamic>> locations) {
    locations.forEach((Map<String, dynamic> location) {
      return ListView.builder(
        itemBuilder: (context, index)=> ListTile(
          leading: Icon(Icons.map_rounded),
          title: Text(location['Location_Name']),
          subtitle: Text(location['Location_Type']),
        ),
        itemCount: locations.length,
      );
    });
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

  @override
  Widget buildSuggestions(BuildContext context) {

    final searchList = search_locations.where((p) => p['Location_Name'].startsWith(query)).toList();

    Icon titleIcon(index) {
      if (searchList[index]['Location_Type'] == 'природный объект') {
        return Icon(Icons.eco, color: Colors.green,);
      } else if (searchList[index]['Location_Type'] == 'религиозный объект') {
        return Icon(Icons.account_balance, color: Colors.deepPurple,);
      } else if (searchList[index]['Location_Type'] == 'захоронение') {
        return Icon(Icons.add, color: Colors.deepPurple,);
      } else if (searchList[index]['Location_Type'] == 'военный объект') {
        return Icon(Icons.military_tech, color: Colors.red,);
      } else if (searchList[index]['Location_Type'] == 'музей') {
        return Icon(Icons.museum, color: Colors.blue,);
      } else if (searchList[index]['Location_Type'] == 'архитектура') {
        return Icon(Icons.architecture, color: Colors.orange,);
      } else if (searchList[index]['Location_Type'] == 'городской объект') {
        return Icon(Icons.location_city, color: Colors.cyan,);
      } else if (searchList[index]['Location_Type'] == 'отдых') {
        return Icon(Icons.airline_seat_individual_suite, color: Colors.pink,);
      }  else if (searchList[index]['Location_Type'] == 'ресторан') {
        return Icon(Icons.food_bank, color: Colors.pink,);
      } else {
        return Icon(Icons.map_rounded);
      }
    }

    search_locations.addAll(nature_locations);
    search_locations.addAll(religion_locations);
    search_locations.addAll(military_locations);
    search_locations.addAll(museum_locations);
    search_locations.addAll(architecture_locations);
    search_locations.addAll(city_locations);
    search_locations.addAll(chill_locations);

    return ListView.builder(
      itemBuilder: (context, index)=> ListTile(
        leading: titleIcon(index),
        title: Text(searchList[index]['Location_Name']),
        subtitle: Text('страница №' + searchList[index]['Location_Page'].toString()),
        onTap:() {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (_) => PlacePage(page: searchList[index]['Location_Page'],),
            ),
          );
        },
      ),
      itemCount: searchList.length,
    );
  }
}