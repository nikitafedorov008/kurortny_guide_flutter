import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/guide_rus_small.pdf');
    setState(() => _isLoading = false);
  }

  void openPage(_number) async {
    // Load specific page
    PDFPage page = await document.get(page: _number);
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
      ),
      body: Center(
          child: _isLoading ? CircularProgressIndicator() : PDFViewer(
            document: document,
            showPicker: true,
            enableSwipeNavigation: true,
            showIndicator: true,
            showNavigation: true,
            zoomSteps: 1,
            indicatorBackground: Colors.redAccent,
            pickerButtonColor: Colors.redAccent,
          ),
      ),
    );
  }
}