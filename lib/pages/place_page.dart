import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PlacePage extends StatefulWidget {
  PlacePage({this.page});

  final int page;

  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {

  bool _isLoading = true;
  PDFDocument document;
  PDFPage page;
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadDocument();
    openPage(4);
    //_pageController.animateToPage(widget.page);
    //_scrollController.jumpTo(50.0);
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/guide_rus_small.pdf');
    setState(() => _isLoading = false);
  }

  void openPage(_number) async {
    // Load specific page
    page = await document.get(page: _number);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Подробнее',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
          controller: _pageController,
          document: document,
          zoomSteps: 1,
          //uncomment below line to preload all pages
          lazyLoad: false,
          // uncomment below line to scroll vertically
          scrollDirection: Axis.vertical,
          //swipe navigation
          enableSwipeNavigation: false,
          //uncomment below code to replace bottom navigation with your own
          showNavigation: true,
          indicatorBackground: Colors.redAccent,
          showPicker: false,
          showIndicator: false,
          pickerButtonColor: Colors.redAccent,
          navigationBuilder: (context, page, totalPages, jumpToPage, animateToPage) {
            //jumpToPage(page: widget.page);
            return TextButton(
              child: Container(
                height: 40,
                  child: Text('Открыть страницу места')
              ),
                onPressed:()=> jumpToPage(page: widget.page),
            );
          },
        ),
      ),
    );
  }
}