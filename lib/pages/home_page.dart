import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
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
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/
      //backgroundColor: Colors.cyan,
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
                          color: Colors.white,// set border color
                          width: 2),   // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)), // set rounded corner radius
                      boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]// make rounded corner of border
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
                          color: Colors.white,// set border color
                          width: 2),   // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)), // set rounded corner radius
                      boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]// make rounded corner of border
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
                /*Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)),
                      boxShadow: [BoxShadow(blurRadius: 32,color: Colors.cyan,offset: Offset(1,3))]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ImageButton(
                      pressedImage: Image.asset('assets/question.png'),
                      children: <Widget>[],
                      width: 18,
                      height: 18,
                      paddingTop: 5,
                      unpressedImage: Image.asset("assets/question.png"),
                      onTap:()=> Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => IntroPage(),
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(
                        color: Colors.white,// set border color
                        width: 6),   // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(24)), // set rounded corner radius
                    boxShadow: [BoxShadow(blurRadius: 32,color: Colors.redAccent,offset: Offset(1,3))]// make rounded corner of border
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
                        color: Colors.white,// set border color
                        width: 6),   // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(24)), // set rounded corner radius
                    boxShadow: [BoxShadow(blurRadius: 32,color: Colors.cyan,offset: Offset(1,3))]// make rounded corner of border
                ),
                child: MaterialButton(
                  /*onPressed: ()=> showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: OrientationBuilder(
                                builder: (context, orientation) {
                                  //height: orientation == Orientation.portrait ? 320 : 220,
                                  return Container(
                                    height: 360,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            16.0, 12.0, 16.0, 12.0,),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Text('Выберите категорию', style: TextStyle(
                                                  fontFamily: 'ProductSans',
                                                  fontSize: 18.0),),
                                              MaterialButton(
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.cancel, color: Colors.red,),
                                                    SizedBox(width: 4,),
                                                    Text('Отмена', style: TextStyle(fontFamily: 'ProductSans', color: Colors.red),),
                                                  ],
                                                ),
                                                onPressed: ()=> Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.museum),
                                          title: Text('Музеи', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          subtitle: Text('museums', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          onTap: () {
                                            //_category = 'Videogame Asset';
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.add_rounded),
                                          title: Text('Религия', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          subtitle: Text('religion',
                                            style: TextStyle(fontFamily: 'ProductSans'),),
                                          onTap: () {
                                            //_category = 'Gadgets';
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.military_tech),
                                          title: Text('Военные объекты', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          subtitle: Text(
                                            'military',
                                            style: TextStyle(fontFamily: 'ProductSans'),),
                                          onTap: () {
                                            //_category = 'Electronics';
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.account_box),
                                          title: Text('Памятники', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          subtitle: Text(
                                            'monuments',
                                            style: TextStyle(fontFamily: 'ProductSans'),),
                                          onTap: () {
                                            //_category = 'Childrens things';
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.food_bank),
                                          title: Text('Рестораны', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          subtitle: Text(
                                            'food',
                                            style: TextStyle(fontFamily: 'ProductSans'),),
                                          onTap: () {
                                            //_category = 'Childrens things';
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.hotel),
                                          title: Text('Отели и санатории', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          subtitle: Text(
                                            'hotel',
                                            style: TextStyle(fontFamily: 'ProductSans'),),
                                          onTap: () {
                                            //_category = 'Childrens things';
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.article),
                                          title: Text('Все места', style: TextStyle(
                                              fontFamily: 'ProductSans'),),
                                          subtitle: Text(
                                            'all',
                                            style: TextStyle(fontFamily: 'ProductSans'),),
                                          onTap: () {
                                            //_category = 'Childrens things';
                                            setState(() {});
                                            Navigator.pop(context);
                                            Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (_) => MapPage(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                  ),*/
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