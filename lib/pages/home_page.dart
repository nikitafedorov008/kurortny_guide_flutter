import 'package:flutter/material.dart';
import 'video_page.dart';
import 'guide_page.dart';
import 'intro_page.dart';
import 'map_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                          color: Colors.white,
                          width: 2),
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)),
                      boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
                  ),
                  child: IconButton(
                    icon: Icon(Icons.play_arrow, color: Colors.white,),
                    onPressed: ()=> Navigator.push(context,
                      MaterialPageRoute(
                        builder: (_) => VideoPage(),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                          color: Colors.white,
                          width: 2),
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)),
                      boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
                  ),
                  child: IconButton(
                    icon: Icon(Icons.contact_support, color: Colors.white,),
                    onPressed: ()=> Navigator.push(context,
                      MaterialPageRoute(
                        builder: (_) => IntroPage(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(
                        color: Colors.white,
                        width: 6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(24)),
                    boxShadow: [BoxShadow(blurRadius: 32,color: Colors.redAccent,offset: Offset(1,3))]
                ),
                child: MaterialButton(
                  onPressed: ()=> Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) => GuidePage(),
                    ),
                  ),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                  child: Container(
                    width: 220,
                    height: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/book.png', color: Colors.white,),
                        Text(
                            'Путеводитель',
                          style: TextStyle(fontSize: 30, fontFamily: 'ProductSans',),
                        ),
                        Text('по курортному', style: TextStyle(fontSize: 18, fontFamily: 'ProductSans'),),
                        Text('району', style: TextStyle(fontSize: 18, fontFamily: 'ProductSans'),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    border: Border.all(
                        color: Colors.white,
                        width: 6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(24)),
                    boxShadow: [BoxShadow(blurRadius: 32,color: Colors.cyan,offset: Offset(1,3))]
                ),
                child: MaterialButton(
                  onPressed: ()=> Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) => MapPage(),
                    ),
                  ),
                  textColor: Colors.white,
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                  child: Container(
                    width: 220,
                    height: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/map.png',),
                        SizedBox(height: 4,),
                        Text(
                          'Карта',
                          style: TextStyle(fontSize: 32, fontFamily: 'ProductSans'),
                        ),
                        Text('курортного', style: TextStyle(fontSize: 18, fontFamily: 'ProductSans'),),
                        Text('района', style: TextStyle(fontSize: 18, fontFamily: 'ProductSans'),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}