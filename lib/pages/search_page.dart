import 'package:flutter/material.dart';
import 'package:kurortny_guide_flutter/model/map_list.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  _addMarkers(List<Map<String, dynamic>> locations) {
    locations.forEach((Map<String, dynamic> location) {
      ListView.builder(
          itemBuilder: (BuildContext buildContext, int index){
            return ListTile(
              title: Text(location['Location_Name']),
              subtitle: Text(location['Location_Type']),
            );
          }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('искать'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: _addMarkers(religion_locations),
      ),
    );
  }
}


class DataSearch extends SearchDelegate<String> {

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

    search_locations.addAll(nature_locations);
    search_locations.addAll(religion_locations);
    search_locations.addAll(military_locations);
    search_locations.addAll(museum_locations);
    search_locations.addAll(architecture_locations);
    search_locations.addAll(city_locations);
    search_locations.addAll(chill_locations);

    final searchList = search_locations.where((p) => p['Location_Name'].startsWith(query)).toList();

    return ListView.builder(
        itemBuilder: (context, index)=> ListTile(
          leading: Icon(Icons.map_rounded),
          title: Text(searchList[index]['Location_Name']),
          subtitle: Text(searchList[index]['Location_Type']),
          onTap:()=> print('${searchList[index]['Location_Type']}' + ' tapped'),
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