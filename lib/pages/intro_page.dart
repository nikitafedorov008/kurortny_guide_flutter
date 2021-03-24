import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  int index = 0;
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 150.0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      index = index;
    });
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(itemCount: index, currentPageNotifier: _currentPageNotifier,
          //currentPageNotifier: _currentPageNotifier, itemCount: index,
          dotColor: Colors.cyan,
          selectedDotColor: Colors.cyan,
          borderColor: Colors.cyan,
        ),
      ),
    );
  }

  pageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Center(
          child: Text('First Page'),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: pageView()),
          _buildCircleIndicator(),
        ],
      ),
    );
  }
}

