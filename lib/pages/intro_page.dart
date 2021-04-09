import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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

  backToHomePage() {
    Navigator.pop(context);
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
    Container(
      padding: const EdgeInsets.all(4.0),
      color: HexColor('#52B6C0'),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, -0.85),
            child: Text(
              'меню',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aqum',
                  color: Colors.white
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'видеообращение',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: 'Aqum',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'посмортите видеообращение\nот автора путеводителя - льва лурье',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Aqum',
                      fontWeight: FontWeight.w500
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'путеводитель',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'читайте о популярных\nи малоизвестных местах куртного района',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Aqum',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'карта',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
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
                      fontSize: 14,
                      fontFamily: 'Aqum',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    //page2
    Container(
      padding: const EdgeInsets.all(4.0),
      color: HexColor('#8E9C80'),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, -0.85),
            child: Text(
              'карта',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aqum',
                  color: Colors.white
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Icon(Icons.article_outlined, color: Colors.white, size: 30,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'фильтры',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: 'Aqum',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'используйте фильры, чтобы\nнайти на карте нужные вам\n достопримечательности',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Aqum',
                      fontWeight: FontWeight.w500
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
                        child: Icon(Icons.navigation, color: Colors.white, size: 24,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'как добраться',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'выбрав нужную локацию,\nнажмите кнопку <<маршрут>>\nчтобы запустить навигацию',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Aqum',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.menu_book, color: Colors.white, size: 24,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'путеводитель',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'выбрав нужный объект\nнажмите на кнопку, чтобы найти текст\nо нём в путеводителе',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Aqum',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.local_taxi, color: Colors.white, size: 24,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'такси',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'выберите нужную точку на карте\nа затем нажмите,] чтобы найти тексткнопку такси',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Aqum',
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.favorite_border, color: Colors.white, size: 24,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'метка партнеров',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'метки партнёров проекта.\nвыберите любую из них\nи нажмите на название для перехода на название для\n'
                      'перехода на официальный сайт объекта',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Aqum',
                  ),
                ),
              ),*/
            ],
          ),
        ],
      ),
    ),
    //page3
    Container(
      padding: const EdgeInsets.all(4.0),
      color: HexColor('#A23457'),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, -0.85),
            child: Text(
              'путеводитель',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aqum',
                  color: Colors.white
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Icon(Icons.bookmark_border, color: Colors.white, size: 30,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'закладки',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: 'Aqum',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'добавляйте пнравившиеся\nстраницы в закладки и быстро\nвозвращайтесь к нужному \nфрагменту позжк',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Aqum',
                      fontWeight: FontWeight.w500
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
                        child: Icon(Icons.search, color: Colors.white, size: 24,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'поиск страниц',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'воспользуйтесь поиском,\nчтобы найти конкретную страницу',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Aqum',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.gesture, color: Colors.white, size: 24,),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'навигация',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Aqum',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  'для просмотра, прокурчивайте\текст вправо/лево',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Aqum',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildPageItem(BuildContext context, int index) {
    return new Page(page: _pages[index], idx: index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            Stack(
              children: [
                Align(
                  alignment: Alignment(0.95, -0.89),
                  child: IconButton(
                    icon: Icon(Icons.cancel_outlined, color: Colors.white, size: 34,),
                    onPressed: ()=> Navigator.pop(context),
                  ),
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
    return Center(
      child: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Container(
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              this.page,
              new Material(
                type: MaterialType.transparency,
                //child: new InkWell(onTap: this.onTap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}