import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  final _controller = new PageController(viewportFraction: 1.4);

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  String title = '';

  static onTap(index) {
    print("$index selected.");
  }

  appBarTitle(index) {
    if (index == 0) {
      title = 'Меню';
    }  else if (index == 1) {
      title = 'карта';
    } else if (index == 2) {
      title = 'путеводитель';
    }
  }

  final List<Widget> _pages = <Widget>[
    /*new FlutterLogo(
    ),
    new FlutterLogo(
        style: FlutterLogoStyle.stacked,
    ),
    new FlutterLogo(
        style: FlutterLogoStyle.horizontal,
    ),*/
    Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: Colors.cyan[200],
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'меню',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30,),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                            color: Colors.white,
                            width: 4),
                        borderRadius: BorderRadius.all(
                            Radius.circular(28)),
                        //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                      'видеообращение',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Text(
                'посмортите видеообращение\nот автора путеводителя - льва лурье',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.book_outlined, color: Colors.white, size: 24,),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                          color: Colors.white,
                          width: 4,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)),
                      //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'путеводитель',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'читайте о популярных\nи малоизвестных местах куртного района',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.map, color: Colors.white, size: 24,),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                          color: Colors.white,
                          width: 4),
                      borderRadius: BorderRadius.all(
                          Radius.circular(28)),
                      //boxShadow: [BoxShadow(blurRadius: 32,color: Colors.grey,offset: Offset(1,3))]
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'карта',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'ищите достопримечательност\на карте и смотрите, как до них\nдобраться',
                style: TextStyle(
                  color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  Widget _buildPageItem(BuildContext context, int index) {
    return new Page(page: _pages[index], idx: index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Информация'),
      ),
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPageItem(context, index % _pages.length);
              },
            ),
            new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                color: Colors.grey[800].withOpacity(0.5),
                padding: const EdgeInsets.all(24.0),
                child: new Center(
                  child: new DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
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

class Page extends StatelessWidget {
  final page;
  final idx;

  Page({
    @required this.page,
    @required this.idx,
  });

  onTap() {
    print("${this.idx} selected.");
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: MediaQuery.of(context).size.height/1.13,
          width: MediaQuery.of(context).size.width,
          child: new Container(
            child: new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                this.page,
                new Material(
                  type: MaterialType.transparency,
                  child: new InkWell(onTap: this.onTap),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}