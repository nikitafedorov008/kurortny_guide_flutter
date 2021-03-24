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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Путеводитель', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),), backgroundColor: Colors.cyan,),
      body: Center(
          child: _isLoading ? CircularProgressIndicator() : PDFViewer(
            document: document,
            zoomSteps: 1,
            indicatorBackground: Colors.cyan,
            pickerButtonColor: Colors.cyan,
          ),
      ),
    );
  }
}
