import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kurortny_guide_flutter/model/mark.dart';
import 'package:kurortny_guide_flutter/pages/mark_list_page.dart';
import 'package:pdf_render/pdf_render_widgets2.dart';
import 'mark_detail.dart';

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
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() => _isLoading = false);
  }

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void navigateToDetail(Mark mark, String title) async {
    /*await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));*/
    await showDialog(
        context: context,
        builder: (BuildContext buildContext){
          return MarkDetail(mark, title);
        }
    );
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
          valueListenable: controller,
          builder: (context, _, child) => Text(controller.isReady ? 'Страница №${controller.currentPageNumber}' : 'Подробнее',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmarks_outlined),
            onPressed: ()=> Navigator.push(context,
              MaterialPageRoute(
                builder: (_) => MarkListPage(),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: PdfDocumentLoader(
        assetName: 'assets/guide.pdf',
        documentBuilder: (context, pdfDocument, pageCount) => LayoutBuilder(
          builder: (context, constraints) => PageView.builder(
            itemCount: pageCount,
            controller: _pageController,
            itemBuilder: (context, index) => Container(
                //margin: EdgeInsets.all(22),
                //padding: EdgeInsets.all(22),
                color: Colors.grey[100],
                child: Stack(
                  children: [
                    Center(
                      child: PdfPageView(
                        pdfDocument: pdfDocument,
                        pageNumber: index + 1 + widget.page,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: (){
                          navigateToDetail(Mark('', '', '${index + widget.page}'), 'Добавить Закладку');
                        },
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Начало',
        child: Icon(Icons.refresh),
        foregroundColor: Colors.white,
        backgroundColor: HexColor('#A23457'),
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