import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  @override
  void initState() {
    super.initState();
    writeState();
  }

  void writeState() async {
    var prefs = await SharedPreferences.getInstance();
    var myList = <String>[];

    await prefs.setStringList("myList", myList);

    myList.add("foobar");

    print(prefs.getStringList("myList")); // [foobar]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'foo text',
            ),
          ],
        ),
      ),
    );
  }
}