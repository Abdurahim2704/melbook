import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  Future<String> getPDFtext(String path) async {
    PdfDocument document =
        PdfDocument(inputBytes: File(path).readAsBytesSync().toList());

    PdfTextExtractor extractor = PdfTextExtractor(document);

    String text = extractor.extractText();

    print(text);

    return text;
  }
}
