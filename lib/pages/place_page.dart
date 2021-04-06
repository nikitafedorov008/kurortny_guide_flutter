import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets2.dart';
import 'package:transformer_page_view/index_controller.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import 'mark_page.dart';

class PlacePage extends StatefulWidget {
  PlacePage({this.page});
  final int page;

  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  PageController _pageController = PageController();
  final controller = PdfViewerController();

  int selectedIndex = 0;

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: ValueListenableBuilder<Object>(
            // The controller is compatible with ValueListenable<Matrix4> and you can receive notifications on scrolling and zooming of the view.
              valueListenable: controller,
              builder: (context, _, child) => Text(controller.isReady ? 'Страница №${controller.currentPageNumber}' : 'Подробнее',
              ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark_border),
              onPressed: ()=> Navigator.push(context,
                MaterialPageRoute(
                  builder: (_) => MarkPage(),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        ////
        body: PdfDocumentLoader(
          assetName: 'assets/guide.pdf',
          documentBuilder: (context, pdfDocument, pageCount)=> LayoutBuilder(
            builder: (context, constraints) => PageView.builder(
              onPageChanged: (index) {
                pageChanged(index);
              },
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: pageCount,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Center(
                child: Container(
                    //margin: EdgeInsets.all(8),
                    //padding: EdgeInsets.all(2),
                    color: Colors.black12,
                    child: PdfPageView(
                      pageNumber: index + widget.page,
                      // pageSize is the PDF page size in pt.
                      pageBuilder: (context, textureBuilder, pageSize) {
                        //
                        // This illustrates how to decorate the page image with other widgets
                        //
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            // the container adds shadow on each page
                            Container(
                              //margin: EdgeInsets.all(margin),
                              //padding: EdgeInsets.all(padding),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(2, 2))
                                ]),
                                // textureBuilder builds the actual page image
                                child: textureBuilder()),
                            // adding page number on the bottom of rendered page
                            //Text('${index + 1}', style: TextStyle(fontSize: 50))
                          ],
                        );
                      },
                    )
                ),
              ),
            ),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Начало',
          child: Icon(Icons.refresh),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          onPressed: (){
            _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                },
              ),
            ],
          ),
        ),
    );
  }
}