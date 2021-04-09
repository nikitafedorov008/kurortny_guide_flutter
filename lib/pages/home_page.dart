import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
      backgroundColor: HexColor("#52B6C0"),
      body: OrientationBuilder(
        builder: (context, orientation){
          if (orientation == Orientation.portrait) {
            return Stack(
              children: [
                Align(
                  //alignment: Alignment(1.0, -0.99),
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/sun.png', fit: BoxFit.fill),
                ),
                Align(
                  alignment: Alignment(-1.0, -0.5),
                  child: Image.asset('assets/cloud_one.png', fit: BoxFit.fill),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/cloud_two.png', fit: BoxFit.fill),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(child: Image.asset('assets/waves.png', fit: BoxFit.fitWidth, width: 1000,)),
                ),
                Align(
                  alignment: Alignment(0.9, -0.90),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#318A93'),
                      border: Border.all(
                          color: Colors.white,
                          width: 4),
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)),
                      //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
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
                ),
                Align(
                  alignment: Alignment(-0.9, -0.90),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#318A93'),
                      border: Border.all(
                          color: Colors.white,
                          width: 4),
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)),
                      //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
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
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor('#A23457'),
                            border: Border.all(
                                color: Colors.white,
                                width: 6),
                            borderRadius: BorderRadius.all(
                                Radius.circular(24)),
                            //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.redAccent,offset: Offset(1,3))]
                          ),
                          child: MaterialButton(
                            onPressed: ()=> Navigator.push(context,
                              MaterialPageRoute(
                                builder: (_) => GuidePage(),
                              ),
                            ),
                            textColor: Colors.white,
                            color: HexColor('#A23457'),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.0,
                              height: MediaQuery.of(context).size.height / 3.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/book.png', color: Colors.white,),
                                  Text(
                                    'Путеводитель',
                                    style: TextStyle(fontSize: 20.2, fontFamily: 'Aqum',),
                                  ),
                                  SizedBox(height: 4,),
                                  Text('по курортному', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),),
                                  Text('району', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),)
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
                            color: HexColor('#8E9C80'),
                            border: Border.all(
                                color: Colors.white,
                                width: 6),
                            borderRadius: BorderRadius.all(
                                Radius.circular(24)),
                            //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.cyan,offset: Offset(1,3))]
                          ),
                          child: MaterialButton(
                            onPressed: ()=> Navigator.push(context,
                              MaterialPageRoute(
                                builder: (_) => MapPage(),
                              ),
                            ),
                            textColor: Colors.white,
                            color: HexColor('#8E9C80'),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.0,
                              height: MediaQuery.of(context).size.height / 3.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/map.png',),
                                  SizedBox(height: 6,),
                                  Text(
                                    'Карта',
                                    style: TextStyle(fontSize: 20.2, fontFamily: 'Aqum'),
                                  ),
                                  SizedBox(height: 4,),
                                  Text('курортного', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),),
                                  Text('района', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor('#318A93'),
                          border: Border.all(
                              color: Colors.white,
                              width: 4),
                          borderRadius: BorderRadius.all(
                              Radius.circular(28)),
                          //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
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
                          color: HexColor('#318A93'),
                          border: Border.all(
                              color: Colors.white,
                              width: 4),
                          borderRadius: BorderRadius.all(
                              Radius.circular(28)),
                          //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
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
                        color: HexColor('#A23457'),
                        border: Border.all(
                            color: Colors.white,
                            width: 6),
                        borderRadius: BorderRadius.all(
                            Radius.circular(24)),
                        //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.redAccent,offset: Offset(1,3))]
                    ),
                    child: MaterialButton(
                      onPressed: ()=> Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => GuidePage(),
                        ),
                      ),
                      textColor: Colors.white,
                      // color: HexColor('#A23457'),
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
                              style: TextStyle(fontSize: 22, fontFamily: 'Aqum',),
                            ),
                            Text('по курортному', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),),
                            Text('району', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),)
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
                        color: HexColor('#8E9C80'),
                        border: Border.all(
                            color: Colors.white,
                            width: 6),
                        borderRadius: BorderRadius.all(
                            Radius.circular(24)),
                        //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.cyan,offset: Offset(1,3))]
                    ),
                    child: MaterialButton(
                      onPressed: ()=> Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => MapPage(),
                        ),
                      ),
                      textColor: Colors.white,
                      color: HexColor('#8E9C80'),
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
                              style: TextStyle(fontSize: 22, fontFamily: 'Aqum'),
                            ),
                            Text('курортного', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),),
                            Text('района', style: TextStyle(fontSize: 14, fontFamily: 'Aqum'),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}