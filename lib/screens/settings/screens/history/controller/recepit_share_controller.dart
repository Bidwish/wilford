import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class RecepitShareController {
  /// Share as image
  static Future<void> shareReceiptAsImage(GlobalKey key) async {
    try {
      // Get the render object
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        debugPrint("Render boundary is null — widget may not be rendered yet.");
        return;
      }

      // Convert to image
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        debugPrint("Failed to convert image to byte data.");
        return;
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // Save to temporary file
      final directory = await getTemporaryDirectory();
      final imagePath = File('${directory.path}/receipt.png');
      await imagePath.writeAsBytes(pngBytes);

      // Share
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: 'Here is your receipt',
      );
    } catch (e) {
      debugPrint('Error sharing receipt image: $e');
    }
  }

  /// Share as PDF
  static Future<void> shareReceiptAsPDF(GlobalKey key) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        debugPrint("Render boundary is null — widget may not be rendered yet.");
        return;
      }

      const double capturePixelRatio = 3.0;
      final ui.Image image =
          await boundary.toImage(pixelRatio: capturePixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        debugPrint("Failed to convert image to byte data.");
        return;
      }
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final double imgPxW = image.width.toDouble();
      final double imgPxH = image.height.toDouble();

      final pdf.PdfPageFormat a4 = pdf.PdfPageFormat.a4;
      final double maxW = a4.width;
      final double maxH = a4.height;

      final double scaleW = maxW / imgPxW;
      final double scaleH = maxH / imgPxH;
      final double scale =
          (scaleW < 1.0 || scaleH < 1.0) ? math.min(scaleW, scaleH) : 1.0;

      final double pageW = imgPxW * scale;
      final double pageH = imgPxH * scale;

      final pdfDoc = pw.Document();
      final pwImage = pw.MemoryImage(pngBytes);

      pdfDoc.addPage(
        pw.Page(
          pageFormat: pdf.PdfPageFormat(pageW, pageH),
          margin: pw.EdgeInsets.zero,
          build: (pw.Context ctx) {
            return pw.Container(
              width: pageW,
              height: pageH,
              child: pw.Image(pwImage,
                  fit: pw.BoxFit.fill, width: pageW, height: pageH),
            );
          },
        ),
      );

      final outputDir = await getTemporaryDirectory();
      final file = File(
          '${outputDir.path}/receipt_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdfDoc.save());

      // ignore: deprecated_member_use
      await Share.shareXFiles([XFile(file.path)], text: 'Here is your receipt');
    } catch (e) {
      // debugPrint('Error sharing receipt PDF: $e');
    }
  }
}
