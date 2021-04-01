import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets2.dart';

class PlacePage extends StatefulWidget {
  PlacePage({this.page});

  final int page;

  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  final controller = PdfViewerController();

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
              builder: (context, _, child) => Text(controller.isReady ? 'Страница №${controller.currentPageNumber}' : 'Страница -',
              ),
          ),
        ),
        backgroundColor: Colors.grey,
        /*body: PdfDocumentLoader(
          assetName: 'assets/guide.pdf',
          documentBuilder: (context, pdfDocument, pageCount)=> LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pageCount,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(2),
                      color: Colors.black12,
                      child: PdfPageView(
                        pdfDocument: pdfDocument,
                        pageNumber: index + 1,
                      )
                  ),
              ),
          ),
        ),*/
        body: PdfViewer(
          //scaleEnabled: true,
          pageNumber: widget.page,
          assetName: 'assets/guide.pdf',
          padding: 8,
          maxScale: 0.3,
          minScale: 0.1,
          viewerController: controller,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: 'firstPage',
                  backgroundColor: Colors.red,
                  child: Icon(Icons.arrow_back),
                  onPressed: () => controller?.goToPage(pageNumber: controller.currentPageNumber - 1),
              ),
              FloatingActionButton(
                  heroTag: 'lastPage',
                  backgroundColor: Colors.red,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () => controller?.goToPage(pageNumber: controller.currentPageNumber + 1),
              ),
            ]
        )
    );
  }
}