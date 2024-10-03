import 'dart:typed_data';
import 'package:flutter/services.dart';

class SecurePrint {
  static const MethodChannel _channel = MethodChannel('secure_print');

  /// Prints the given PDF data to a specific printer.
  static Future<void> printPdf(Uint8List pdfData, String printerName) async {
    try {
      await _channel.invokeMethod('printPdf', {
        'pdfData': pdfData,
        'printerName': printerName,
      });
    } on PlatformException catch (e) {
      print('Failed to print PDF: ${e.message}');
    }
  }

  /// Fetches the list of available printers.
  static Future<List<String>> getAvailablePrinters() async {
    try {
      final List<dynamic> printerList =
          await _channel.invokeMethod('getAvailablePrinters');
      return printerList.cast<String>();
    } on PlatformException catch (e) {
      print('Failed to get available printers: ${e.message}');
      return [];
    }
  }
}
