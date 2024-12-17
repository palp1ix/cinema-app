import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class PdfView extends StatefulWidget {
  final Uint8List bytes;

  const PdfView({super.key, required this.bytes});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  String? _pdfPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/ticket.pdf');
    await file.writeAsBytes(widget.bytes);
    setState(() {
      _pdfPath = file.path;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _pdfPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onError: (error) {
                print('Error: $error');
              },
              onPageError: (page, error) {
                print('Page error: $error');
              },
            ),
    );
  }
}
