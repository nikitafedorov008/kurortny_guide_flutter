import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:kurortny_guide_flutter/pages/mark_list_page.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  bool _isLoading = true;
  PDFDocument document;
  PDFPage page;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/guide.pdf');
    setState(() => _isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Путеводитель',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: ()=> Navigator.push(context,
              MaterialPageRoute(
                builder: (_) => MarkListPage(),
              ),
            ),
              icon: Icon(Icons.bookmarks_outlined),
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
          document: document,
          zoomSteps: 1,
          //uncomment below line to preload all pages
           lazyLoad: false,
          // uncomment below line to scroll vertically
           //scrollDirection: Axis.horizontal,
          //swipe navigation
          //enableSwipeNavigation: true,
          //uncomment below code to replace bottom navigation with your own
          showNavigation: true,
          indicatorBackground: Colors.redAccent,
          pickerButtonColor: Colors.redAccent,
          navigationBuilder: (context, page, totalPages, jumpToPage, animateToPage) {
                    return BottomAppBar(
                      shape: CircularNotchedRectangle(),
                      notchMargin: 6,
                      clipBehavior: Clip.antiAlias,
                      child: ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.first_page),
                              onPressed: () {
                                jumpToPage(page: 0);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                animateToPage(page: page - 2);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward, color: Colors.transparent,),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                animateToPage(page: page);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.last_page),
                              onPressed: () {
                                jumpToPage(page: totalPages - 1);
                              },
                            ),
                          ],
                      ),
                    );
                  },
        ),
      ),
    );
  }
}